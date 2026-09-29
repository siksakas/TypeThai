//
//  StatsView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/29/26.
//

import SwiftUI
import SwiftData

struct StatsView: View {
    @Query var lessonProgress: [LessonProgress]
    var completedLessons: [LessonProgress] {
        lessonProgress.filter { $0.isComplete }
    }
    var completedCount: Int {
        completedLessons.count
    }
    
    
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.offWhite)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.offWhiteShadow)
                            .offset(y:7)
                    )
            }
            .padding(10)
            
            HStack (spacing:20) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offWhite)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.offWhiteShadow)
                                .offset(y:8)
                        )
                }
                
                ZStack {
                    
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offWhite)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.offWhiteShadow)
                                .offset(y:8)
                        )
                    VStack {
                        Text("Lessons Finished:")
                            .font(TT.rounded(25, .black))
                        Text("\(completedCount)")
                            .font(TT.rounded(30, .black))
                    }
                    
                        
                }
            }
            .padding(15)
            HStack {
                RoundedRectangle(cornerRadius: 20)
            }
            .padding(10)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.bg)
    }
}

#Preview {
    StatsView()
}
