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

    }
}

#Preview {
    StatsView()
}
