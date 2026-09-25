//
//  LessonView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/24/26.
//

import SwiftUI

struct LessonView: View {
    var thisLesson: Lesson
    //thisLesson.vocabContent
    //thisLesson.steps
    @State var currentIndex = 0

    // here we treat nil and "none" the same way
    private var currentExplanation: String? {
        guard let explanation = thisLesson.steps[currentIndex].explanation,
              explanation != "none" else { return nil }
        return explanation
    }

    private var lastIndex: Int {
        min(thisLesson.vocabContent.count, thisLesson.steps.count) - 1
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
                        .padding(.horizontal, 24)
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

            Spacer() // keeps everything anchored to the top
        }
        .animation(.easeInOut(duration: 0.25), value: currentIndex)
    }

    private var navigationButtons: some View {
        HStack(spacing: currentIndex == 0 ? 0 : 12) {
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
            .frame(maxWidth: currentIndex == 0 ? 0 : .infinity)
            .opacity(currentIndex == 0 ? 0 : 1)
            .disabled(currentIndex == 0)

            Button {
                if currentIndex < lastIndex {
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
