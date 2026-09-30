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
            List {
                
                Header
                    .padding(.top,10)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                
                ForEach(decks) { deck in
                    NavigationLink {
                        DeckReviewView(deck: deck)
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
                    .navigationLinkIndicatorVisibility(.hidden)
                    .padding(.horizontal, 20)
                    .swipeActions(edge: .trailing) {
                        Button (role:.destructive){
                            modelContext.delete(deck)
                        } label: {
                            Image(systemName: "trash")
                        }
                    }
                    .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 12, trailing: 0))
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.clear)

                }
            }
            .listStyle(.plain)
            .background(.bg)
//            .task {
//                modelContext.insert(Deck(name:"Hard Vocab",words: []))
//            }
        
        }
    }
}

private var Header: some View {
    HStack(alignment: .top, spacing: 2) {
        HStack {
            Text("Practice").foregroundColor(.white)

        }
        .font(TT.rounded(30, .black))
        ZStack {
            Capsule().fill(Color.customMint)
                .frame(width: 4, height: 13)
                .rotationEffect(.degrees(25))
                .offset(x: -2, y: -3)
            Capsule().fill(Color.customMint)
                .frame(width: 4, height: 13)
                .rotationEffect(.degrees(70))
                .offset(x: 3, y: 6)
        }
        .frame(width: 16, height: 24)
    }
    .background(.bg)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
    
#Preview {
    DeckView()
        .modelContainer(for: Deck.self, inMemory: true)
}
