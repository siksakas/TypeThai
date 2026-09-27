//
//  Lesson.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/22/26.
//
import Foundation

struct Lesson: Identifiable {
    var id = UUID()
    let name: String
    let desc: String
    let vocabContent: [VocabWord]
    let steps: [LessonStep]
}

struct LessonStep: Identifiable {
    let id = UUID()
    let type: LessonStepType // if is speaking require the user to speak into the game first
    let thai: String //sfspeechanalyzer matches text to this?
    let explanation: String?
    let requiresSpeaking: Bool
}

enum LessonStepType {
    case character
    case explanation
    case word
    case speaking
}
