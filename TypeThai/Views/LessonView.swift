//
//  LessonView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/24/26.
//

import SwiftUI

struct LessonView: View {
    @State var currentLesson: [VocabWord]
    @State var currentSteps: [LessonStep]
    @State var currentIndex = 0
    
    var body: some View {
        FlashcardView(currword: currentLesson[currentIndex])
        if(currentSteps[currentIndex].explanation != "none"){
            if let explanation = currentSteps[currentIndex].explanation {
                VStack(spacing: 10){
                    HStack {
                        Text(explanation)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 10)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.orange)
                            }
                            
                    }
                    .padding(.horizontal, 24)
                }
            }
        }
        GeometryReader { geometry in
            let spacing: CGFloat = 12
            let fullWidth = geometry.size.width
            let halfWidth = (fullWidth - spacing) / 2

            HStack(spacing: currentIndex == 0 ? 0 : spacing) {

                Button {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        currentIndex -= 1
                    }
                } label: {
                    HStack {
                        Image(systemName: "arrow.left")

                        Text("Back")
                            .fontWeight(.semibold)
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.orange)
                    }
                }
                .frame(width: currentIndex == 0 ? 0 : halfWidth)
                .opacity(currentIndex == 0 ? 0 : 1)
                .disabled(currentIndex == 0)

                Button {
                    if currentIndex < currentLesson.count - 1 {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            currentIndex += 1
                        }
                    }
                } label: {
                    HStack {
                        Text("Next")
                            .fontWeight(.semibold)

                        Image(systemName: "arrow.right")
                    }
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.orange)
                    }
                }
                .frame(
                    width: currentIndex == 0
                        ? fullWidth
                        : halfWidth
                )
            }
            .animation(.easeInOut(duration: 0.25), value: currentIndex)
        }
        .frame(height: 55)
        .padding(.horizontal, 24)
        
    }
}

#Preview {
    LessonView(currentLesson: lessonOneWords,currentSteps: lessonOneSteps)
}
