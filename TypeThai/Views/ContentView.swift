//
//  ContentView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/22/26.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: AppTab = .home
    @State var showTabBar: Bool = true
    
    var body: some View {
        TabView (selection: $selection) {
            Tab (value: AppTab.home){
                LessonListView(showTabBar: $showTabBar)
                .toolbarVisibility(.hidden, for: .tabBar)
            }
            Tab (value: AppTab.decks){
                DeckView()
                .toolbarVisibility(.hidden, for: .tabBar)
            }
            Tab (value: AppTab.stats){
                StatsView()
                .toolbarVisibility(.hidden, for: .tabBar)
            }
        }
        .safeAreaInset(edge: .bottom) {
            if showTabBar {
                CustomTabBar(selection: $selection)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 4)
            }
        }
    }
}

#Preview {
    ContentView()
}
