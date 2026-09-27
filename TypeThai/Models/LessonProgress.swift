//
//  LessonProgress.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/26/26.
//


import SwiftData

@Model
final class LessonProgress {
    var lessonID: String
    var isComplete: Bool
    
    init(lessonID: String, isComplete: Bool) {
        self.lessonID = lessonID
        self.isComplete = isComplete
    }
}
