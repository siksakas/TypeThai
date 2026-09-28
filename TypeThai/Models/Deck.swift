//
//  Deck.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/28/26.
//

import SwiftData

@Model
final class Deck {
    var deckName: String
    var words: [VocabWord]
    
    init(deckName: String, words: [VocabWord]) {
        self.deckName = deckName
        self.words = words
    }
}
