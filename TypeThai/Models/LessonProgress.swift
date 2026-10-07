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
    var currentIndex: Int
    var totalIndex: Int
    
    init(lessonID: String, isComplete: Bool, currentIndex: Int, totalIndex: Int) {
        self.lessonID = lessonID
        self.isComplete = isComplete
        self.currentIndex = currentIndex
        self.totalIndex = totalIndex
    }
}
