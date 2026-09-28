//
//  DeckReviewView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/28/26.
//
import SwiftUI

struct DeckReviewView: View {
    let deck: Deck
    var body: some View {
        List (deck.words) { word in
            HStack {
                Text(word.thai)
                Spacer()
                Text(word.pronunciation)
                Spacer()
                Text(word.english)
            }
        }
    }
}

#Preview {
    DeckReviewView(deck: Deck(name:"Hard Vocab",words: [
        VocabWord(
                thai: "ก",
                pronunciation: "gaw",
                english: "g / k sound",
                type: "Consonant"
            ),
            VocabWord(
                thai: "ม",
                pronunciation: "maw",
                english: "m sound",
                type: "Consonant"
            ),
            VocabWord(
                thai: "า",
                pronunciation: "aa",
                english: "long a vowel",
                type: "Vowel"
            )
    ]))
}
