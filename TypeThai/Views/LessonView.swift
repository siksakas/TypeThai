//
//  LessonView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/24/26.
//

import SwiftUI

struct LessonView: View {
    var thisLesson: Lesson
    @State var currentIndex = 0
    @State private var transcriber = LiveTranscriber()
    // store whatever text it hears
    @State private var transcript = ""
    @State private var isListening = false

    // here we treat nil and "none" the same way
    //its a computed property which returns an optional string bc if there is nothing in the "explanation" then it wont return anything
    private var currentExplanation: String? {
        guard let explanation = thisLesson.steps[currentIndex].explanation, explanation != "none"
        else { return nil }
        return explanation
    }

    //stops us from having an error for index being out of range
    private var lastIndex: Int {
        thisLesson.steps.count - 1
    }
    
    var leftButtonHidden: Bool {
        if isListening { return true }
        return currentIndex == 0
    }

    var body: some View {
        VStack(spacing: 20) {
            FlashcardView(currword: thisLesson.vocabContent[currentIndex],showPronunciation:!thisLesson.steps[currentIndex].requiresSpeaking)
                .padding(.top, 84)

            ZStack {
                if let explanation = currentExplanation {
                    Text(explanation)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .padding(.vertical, 16)
                        .padding(.horizontal, 16)
                        .frame(maxWidth: .infinity)
                        .background {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.orange)
                        }
                        .padding(.horizontal, 24)
                        .id(currentIndex) // new view per step → re-triggers the slide
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: .leading).combined(with: .opacity),
                                removal: .move(edge: .trailing).combined(with: .opacity)
                            )
                        )
                }
            }
            .frame(maxWidth: .infinity)

            navigationButtons

            if (thisLesson.steps[currentIndex].requiresSpeaking){
                HStack{
                    Text(transcript)
                }
            }
            Spacer() // keeps everything anchored to the top
        }
        .animation(.easeInOut(duration: 0.25), value: currentIndex)
        .task {
                requestPermissions()
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: leftButtonHidden ? 0 : 12) {
            Button {
                if currentIndex > 0 {
                    currentIndex -= 1
                }
            } label: {
                HStack {
                    Image(systemName: "arrow.left")
                    Text("Back").fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background {
                    RoundedRectangle(cornerRadius: 16).fill(Color.orange)
                }
            }
            .frame(maxWidth: leftButtonHidden ? 0 : .infinity)
            .opacity(leftButtonHidden ? 0 : 1)
            .disabled(currentIndex == 0)

            Button {
                // this has to be checked BEFORE adding to the index or else it starts one step too early
                if thisLesson.steps[currentIndex].requiresSpeaking {
                    let thisIndex = currentIndex
//                    print("pressed!")
                    if isListening {
                        transcriber.stop()
                        isListening = false
                        print("transcriber disabled")
                    } else {
                        isListening = true
                        transcript = ""
                        do {
                            try transcriber.start { text in
                                transcript = text
                                // need some way to reset it to blank automatically or only display latest word in transcript?
                                if (transcript == thisLesson.vocabContent[currentIndex].thai) {
                                    print("transcript matched")
                                    // sometimes this will fire off multiple times so if we increment currentIndex itself it can lead to a
                                    // out of bounds error but thisIndex+1 being set multiple times will not crash bc its always the same value
                                    currentIndex = thisIndex + 1
                                }
                            }
                            print("transcriber enabled")
                        } catch {
                            print("something went wrong")
                        }
                    }
                } else if currentIndex < lastIndex {
                    currentIndex += 1
                }
            } label: {
                HStack {
                    if thisLesson.steps[currentIndex].requiresSpeaking {
                        Image(systemName: "microphone.fill")
                    } else {
                        Text("Next").fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
//                    Image(systemName: currentSteps[currentIndex].requiresSpeaking ? "" : "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background {
                    RoundedRectangle(cornerRadius: 16).fill(Color.orange)
                }
            }
            .frame(maxWidth: .infinity)
            
            
        }
        .frame(height: 55)
        .padding(.horizontal, 24)
        .groupedGeometryIfAvailable() // animate the whole row as one unit
        
    }
}

// MARK: - Backward-compatible geometryGroup

private struct GroupedGeometry: ViewModifier {
    func body(content: Content) -> some View {
        if #available(iOS 17.0, macOS 14.0, *) {
            content.geometryGroup()
        } else {
            // Older OS: fall back to compositing the row into a single layer
            content.compositingGroup()
        }
    }
}

private extension View {
    func groupedGeometryIfAvailable() -> some View {
        modifier(GroupedGeometry())
    }
}

#Preview {
    LessonView(thisLesson: lessons[0])
}
