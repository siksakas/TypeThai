//
//  SpeechTranscriber.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/25/26.
//

import Foundation
import Speech
import AVFoundation

class SpeechRecognizer {
    
    
    func transcribe(avFile: AVAudioFile) async throws -> String {
        let transcriber = SpeechTranscriber(locale: Locale(identifier: "th-TH"), preset:.transcription)
        
        async let transcriptionFuture = try transcriber.results.reduce("")
        {
            str, result in
            str + String(result.text.characters)
        }
        
        let analyzer = SpeechAnalyzer(modules: [transcriber])
        if let lastSample = try await analyzer.analyzeSequence(from: avFile) {
            try await analyzer.finalizeAndFinish(through: lastSample)
        } else {
            await analyzer.cancelAndFinishNow()
        }
        
        return try await transcriptionFuture
    }
}
