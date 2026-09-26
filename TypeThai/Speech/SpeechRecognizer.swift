//
//  SpeechTranscriber.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/25/26.
//

import Foundation
import Speech
import AVFoundation
import Combine

@MainActor //actor associated with apps main ui thread, swiftui expects ui changes to happen on this main actor
final class SpeechRecognizer: ObservableObject {
    // class is conforming to observableobject bc it notifies swiftUI to update views that depend on it
    // so it makes the class something SwiftUI can observe and @Published marks what properties changing causes those updates
    @Published var transcript: String = ""

    //transcriber that turns speech to text
    private var transcriber: SpeechTranscriber?
    //pass in a module to it and actually runs speech analysis
    private var analyzer: SpeechAnalyzer?
    // stream of audio chunks going into analyzer
    private var inputSequence: AsyncStream<AnalyzerInput>?
    // puts things into inputSequence????
    private var inputBuilder: AsyncStream<AnalyzerInput>.Continuation?
    //stores audio format speech analyzer expects
    private var analyzerFormat: AVAudioFormat?
    // live audio from mic
    private let audioEngine = AVAudioEngine()
    
    func setUpTranscriber() async throws {

        let transcriber = SpeechTranscriber(
            locale: Locale(identifier: "th-TH"), // sets it up for thai speech
            preset: .progressiveTranscription //live transcription
        )

        self.transcriber = transcriber

        analyzer = SpeechAnalyzer(
            modules: [transcriber]
        )

        analyzerFormat =
            await SpeechAnalyzer.bestAvailableAudioFormat(
                compatibleWith: [transcriber]
            )

        (inputSequence, inputBuilder) =
            AsyncStream<AnalyzerInput>.makeStream()

        guard let inputSequence else {
            return
        }

        try await analyzer?.start(
            inputSequence: inputSequence
        )

        Task {
            do {
                for try await result in transcriber.results {

                    let text =
                        String(result.text.characters)

                    self.transcript = text

                    print("Heard:", text)
                }
            } catch {
                print("Speech error:", error)
            }
        }
    }
    
//    func transcribe(avFile: AVAudioFile) async throws -> String {
//        let transcriber = SpeechTranscriber(locale: Locale(identifier: "th-TH"), preset:.transcription)
//        
//        async let transcriptionFuture = try transcriber.results.reduce("")
//        {
//            str, result in
//            str + String(result.text.characters)
//        }
//        
//        let analyzer = SpeechAnalyzer(modules: [transcriber])
//        if let lastSample = try await analyzer.analyzeSequence(from: avFile) {
//            try await analyzer.finalizeAndFinish(through: lastSample)
//        } else {
//            await analyzer.cancelAndFinishNow()
//        }
//        
//        return try await transcriptionFuture
//    }
}
