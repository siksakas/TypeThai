//
//  Lesson.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/22/26.
//
import Foundation

struct Lesson: Identifiable, Codable {
    let id = UUID()
    let name: String
    let desc: String
    let vocabContent: [VocabWord]
}
