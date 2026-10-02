//
//  DeckReviewView.swift
//  TypeThai
//
//  Created by Siksaka Suriyasat on 9/28/26.
//
import SwiftUI
import SwiftData

struct DeckReviewView: View {
    @Bindable var deck: Deck
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                pageControl
            }
            
            List (deck.words) { word in
                HStack {
                    Text(word.thai)
                    Spacer()
                    Text(word.pronunciation)
                    Spacer()
                    Text(word.english)
                }
            }
            .scrollContentBackground(.hidden)
        }
        .navigationBarBackButtonHidden(true)
        .background(.bg)
    }
    
    private var pageControl: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "arrowshape.turn.up.backward.fill")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.offWhiteShadow)
                    .frame(width: 50, height: 35)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.offWhite)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.offWhiteShadow)
                            .offset(y: 3)
                    )
            }
            .buttonStyle(.plain)
            .padding(.leading, 24)
            .padding(.trailing,12)
            
            Text(deck.name)
                .multilineTextAlignment(.center)
                .font(Font.title.bold())
                .fontDesign(.rounded)
                .padding(.horizontal, 12)
                .frame(maxWidth: .infinity)
                .padding(.vertical,4)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(.offWhite)
                        .background(
                            RoundedRectangle(cornerRadius: 16)
                                .fill(.offWhiteShadow)
                                .offset(y:4)
                        )
                )

//            ProgressView(value: Double(currentIndex), total: Double(lastIndex))
                

            Button {

            } label: {
                Image(systemName: "pencil")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.offWhiteShadow)
                    .frame(width: 50, height: 35)
                    .background(
                        RoundedRectangle(cornerRadius:16)
                            .fill(Color.offWhite)
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.offWhiteShadow)
                            .offset(y: 3)
                    )
            }
            .buttonStyle(.plain)
            .padding(.trailing, 24)
            .padding(.leading,12)
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
