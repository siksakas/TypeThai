//
//  LessonView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/24/26.
//

import SwiftUI
import SwiftData

struct LessonView: View {
    @Query var lessonProgress: [LessonProgress]
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var completedSpeaking: Bool = false
    
    var thisLesson: Lesson
    @State var currentIndex = 0
    @State private var transcriber = LiveTranscriber()
    // store whatever text it hears
    @State private var transcript = ""
    @State private var isListening = false
    
    @State private var isComplete: Bool = false

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
            PageDots(count:lastIndex, currentPage: currentIndex)
            
            FlashcardView(currword: thisLesson.steps[currentIndex].word,showPronunciation:!thisLesson.steps[currentIndex].requiresSpeaking)
                .padding(.top,16)

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
                                .fill(Color.bgTextbox)
                        }
                        .padding(.horizontal, 24)
                        .id(currentIndex)
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
        .background(Color.bg)
        .navigationBarBackButtonHidden(true)
        .animation(.easeInOut(duration: 0.25), value: currentIndex)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrowshape.turn.up.backward.fill")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.white)
                        .frame(width: 40, height: 40)
                        .background(Circle().fill(Color.yellow))
                        .background(Circle().fill(Color.orange).offset(y: 2))
                }
                .buttonStyle(.plain)
            }
            .sharedBackgroundVisibility(.hidden)
        }
        .task {
                requestPermissions()
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: leftButtonHidden ? 0 : 12) {
            Button {
                isComplete.toggle()
                transcript = ""
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
                .background {
                    RoundedRectangle(cornerRadius: 16).fill(Color.customYellow)
                }
            }
            .buttonStyle(ChunkyButtonStyle())
            .frame(maxWidth: leftButtonHidden ? 0 : .infinity)
            .opacity(leftButtonHidden ? 0 : 1)
            .disabled(currentIndex == 0)
            .sensoryFeedback(.impact(weight: .light), trigger: isComplete)
            

            Button {
                isComplete.toggle()
                //exits current lesson
                if currentIndex == lastIndex {
                    // tries to find an instance in which the lessonID matches this current lessons
                    let updateProgress = lessonProgress.filter { $0.lessonID == thisLesson.name }.first
                    // if it cannot find one it moves to the else condition which creates one.
                    if let updateProgress {
                        updateProgress.isComplete = true
                        print("\(thisLesson.name) is now updated")
                    } else {
                        modelContext.insert(LessonProgress(lessonID: thisLesson.name, isComplete: true))
                        print("model created")
                    }
                    print("view dismissed")
                    dismiss()
                }
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
                                if (transcript.contains(thisLesson.steps[currentIndex].word.thai)) {
                                    print("transcript matched")
                                    isListening = false
                                    transcriber.stop()
                                    // sometimes this will fire off multiple times so if we increment currentIndex itself it can lead to a
                                    // out of bounds error but thisIndex+1 being set multiple times will not crash bc its always the same value
                                    currentIndex = thisIndex + 1
                                    completedSpeaking.toggle()
                                }
                            }
                            print("transcriber enabled")
                        } catch {
                            transcript = "Please enable the microphone!"
                            print("something went wrong")
                        }
                    }
                } else if currentIndex < lastIndex {
                    currentIndex += 1
                }
            } label: {
                HStack {
                    if currentIndex == lastIndex {
                        Image(systemName: "return")
                    } else if thisLesson.steps[currentIndex].requiresSpeaking {
                        Image(systemName: "microphone.fill")
                    } else {
                        Text("Next").fontWeight(.semibold)
                        Image(systemName: "arrow.right")
                    }
//                    Image(systemName: currentSteps[currentIndex].requiresSpeaking ? "" : "arrow.right")
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 16).fill(Color.customYellow)
                }
            }
            .frame(maxWidth: .infinity)
            .buttonStyle(ChunkyButtonStyle())
            .sensoryFeedback(.success, trigger: completedSpeaking)
            .sensoryFeedback(.impact(weight: currentIndex == lastIndex ? .heavy : .light), trigger: isComplete)
//            .sensoryFeedback(.success, trigger: isComplete)
            
        }
        .frame(height: 55)
        .padding(.horizontal, 24)
        .groupedGeometryIfAvailable() // animate the whole row as one unit
        
    }
    
    struct PageDots: View {
        let count: Int
        let currentPage: Int
        
        var body: some View {
            HStack (spacing: 20) {
                ForEach(0...count, id: \.self) { i in
                    Circle()
                        .foregroundStyle(i == currentPage ? .customYellow : .bgTextbox)
                        .frame(width: 12, height: 12)
                    
//                        .background(
//                            Circle()
//                                .frame(width: 12, height: 12)
//                                .offset(y: 1)
//                        )
//                        .foregroundColor(i == currentPage)
                }
            }
        }
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
        .modelContainer(for: LessonProgress.self, inMemory: true)
}
