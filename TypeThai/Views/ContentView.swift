//
//  ContentView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/22/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Tab {
                LessonListView()
            } label: {
                Image(systemName:"house.fill")
                Text("Home")
            }
        
            Tab {
               DeckView()
            } label: {
                Image(systemName:"pencil")
                Text("Practice")
            }
            
            Tab {
                StatsView()
            } label: {
                Image(systemName: "person.fill")
                Text("Stats")
            }
            
        }
    }
}

#Preview {
    ContentView()
}
