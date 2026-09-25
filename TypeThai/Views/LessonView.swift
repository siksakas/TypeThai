//
//  LessonView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/22/26.
//
import SwiftUI

struct LessonView: View {
    let lesson: Lesson
    
    var body: some View {
        Text(lesson.name)
            .font(Font.largeTitle.bold())
        Text(lesson.desc)
            .font(.body)
//        Divider()
//            .padding(.horizontal, 30)
    
    }
}

#Preview {
}
