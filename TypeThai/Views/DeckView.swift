//
//  DeckView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/28/26.
//
import SwiftUI
import SwiftData

struct DeckView: View {
    @Query var decks: [Deck]
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(decks) { deck in
                    NavigationLink {
                        EmptyView()
                    } label: {
                        HStack {
                            Text(deck.name)
                                .font(.system(size: 18, weight: .bold, design: .rounded))

                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundStyle(.secondary)
                        }
                        .foregroundStyle(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 18)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(white: 0.98))
                        )
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(white: 0.85))
                                .offset(y: 5)
                        )
                    }
                    .frame(width:350)
                    .background (
                        RoundedRectangle(cornerRadius: 20)
                    )
                    .swipeActions {
                        Button {
                            
                        } label: {
                            Image(systemName: "pencil")
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .border(.black,width:1)
            .background(Color.bg)
        }
        .border(.black,width:1)
    }
}

#Preview {
    DeckView()
        .modelContainer(for: Deck.self, inMemory: true)
}
