//
//  Deck.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/28/26.
//

import SwiftData

@Model
final class Deck {
    var name: String
    var words: [VocabWord]
    
    init(name: String, words: [VocabWord]) {
        self.name = name
        self.words = words
    }
}
