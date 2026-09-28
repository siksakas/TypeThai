//
//  TypeThaiApp.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/22/26.
//

import SwiftUI
import SwiftData

@main
struct TypeThaiApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [LessonProgress.self,Deck.self])
        }
    }
}
