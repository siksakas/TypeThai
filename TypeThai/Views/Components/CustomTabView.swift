//
//  CustomTabView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 10/6/26.
//
import SwiftUI

// allows you to loop thru all values by conforming to CaseIterable
enum AppTab: CaseIterable {
    case home, decks, stats
    
    // computed properties which return the title of each page along with string for the name of icon
    var title: String {
        switch self {
        case .home: "Home"
        case .decks: "Decks"
        case .stats: "Stats"
        }
    }
    var icon: String {
        switch self {
        case .home: "house.fill"
        case .decks: "book.fill"
        case .stats: "chart.bar.fill"
        }
    }
}

struct CustomTabBar: View {
    @Binding var selection: AppTab

    var body: some View {
        HStack(spacing: 6) {
            ForEach(AppTab.allCases, id: \.self) { tab in
                let isSelected = (tab == selection)
                Button {
                    withAnimation(.snappy) { selection = tab }
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 20, weight: .bold))
                        Text(tab.title)
                            .font(.caption.weight(.bold))
                    }
                    .foregroundStyle(isSelected ? Color.ink : .gray)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 10)
                    .background {
                        if isSelected {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.customYellow)
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(6)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.offWhite)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.offWhiteShadow)
                        .offset(y:5)
                )
        )
    }
}

#Preview {
    @Previewable @State var selection: AppTab = .home

    CustomTabBar(selection: $selection)
        .padding()
}
