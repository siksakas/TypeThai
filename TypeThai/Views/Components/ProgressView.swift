//
//  ProgressView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 10/6/26.
//

import SwiftUI
import SwiftData

struct ProgressionView: View {
    @Query var lessonProgress: [LessonProgress]
    @Environment(\.modelContext) var modelContext
    
    private var latestLessonStarted: Bool {
        // safely gets the last element of lessonProgress, if it cannot get one then it returns false because there is nothing in lessonProgress
        guard let latest = lessonProgress.last else {
            return false
        }
        // if latest does exist, and it is NOT completed then it has been started
        return !latest.isComplete
    }
    
    private var lessonToDisplay: Lesson {
        if lessonProgress.isEmpty {
            return lessons[0]
        } else {
            let latest = lessonProgress[lessonProgress.count-1]
            
            if latest.isComplete {
                return lessons[lessonProgress.count]
            } else {
                return lessons[lessonProgress.count-1]
            }
        }
    }
    
    private var progress: Int {
        if latestLessonStarted {
            return lessonProgress[lessonProgress.count-1].currentIndex
        } else {
            return 0
        }
    }
    
    private var total: Int {
        return lessonToDisplay.steps.count - 1
    }
    
    var body: some View {
        VStack (spacing: 0 ){
            HStack {
                Text(latestLessonStarted ? "CONTINUE" : "START")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.darkBlue)
                Spacer()
                Text("\(progress) / \(total)")
                    .fontWeight(.semibold)
                    .font(.subheadline)
                    .fontDesign(.rounded)
                    .foregroundStyle(.darkBlue)
                
            }
            .padding(.horizontal,20)
            .padding(.top,20)
            .padding(.bottom,5)
            
            HStack {
                Text(lessonToDisplay.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                Spacer()
            }
            .padding(.horizontal,20)
            .padding(.bottom,15)
            
            ProgressDots
                .padding(.bottom, 10)
            
            StartButton
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offWhiteShadow)
                        .offset(y:5)
                )
        )
//        .padding(24)
    }
    
    var ProgressDots: some View {
        HStack() {
            ForEach(0..<total, id:\.self) { index in
                var fillColour: Color {
                    if index < progress {
                        return Color.green
                    } else if index == progress {
                        return Color.customYellow
                    } else {
                        return Color.offWhiteShadow
                    }
                }
                Capsule()
                    .frame(width:.infinity,height:10)
                    .foregroundStyle(fillColour)
            }
        }
        .padding(.horizontal,23)
    }
    
    var StartButton: some View {
        HStack {
            Button {
                // go to view
            } label: {
                Text(latestLessonStarted ? "Continue" : "Start!")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .fontDesign(.rounded)
                    .frame(maxWidth:.infinity)
                    .frame(height: 50)
            }
            .buttonStyle(RaisedButtonStyle(face:.customYellow, shadow: .customYellowDeep))
            
        }
        
        .padding(.horizontal,22)
        .padding(.top,10)
        .padding(.bottom,10)
    }
}

#Preview {
    ProgressionView()
        .modelContainer(for: LessonProgress.self, inMemory: true)
        .padding(24)
}

