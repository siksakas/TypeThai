import SwiftUI
import SwiftData
import AVFoundation


struct FlashcardView: View {
    @Query var decks: [Deck]
    @Environment(\.modelContext) var modelContext
    
    let currword: VocabWord
    let showPronunciation: Bool
    
    let audioPlayer = AVSpeechSynthesizer()
    
    
    var body: some View {
        
        VStack(spacing: 24) {

            // Word type
            ZStack {
                Text(currword.type.uppercased())
                    .font(.system(size: 12, weight: .semibold,design:.rounded))
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.ink)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 7)
                    .background {
                        Capsule()
                            .fill(.bgTextbox.opacity(0.1))
                    }
                
                HStack() {
                    Spacer()
                    Menu {
                        DeckMenu(decks: decks,currword: currword)
                    } label: {
                        Image(systemName:"ellipsis")
                            .font(.headline)
                            .foregroundStyle(Color.ink)
                    }
//                    .padding(.trailing,20)
                }
                .frame(maxWidth: .infinity)
            }

            Spacer()
            
            // Thai word
            Text(currword.thai)
                .font(.system(size: 72, weight: .bold,design: .rounded))
                .foregroundStyle(Color.ink)
            
            // Pronunciation
            Text(currword.pronunciation)
                .font(.title3)
            // make this one a lighter clr later
                .foregroundStyle(Color.ink)
            
            // English meaning
            Text(currword.english)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundStyle(Color.ink)
            
            Spacer()
            
            Divider()
            
            
            HStack {
                Button {
                    // allows sound to play despite silent mode on phone
                    let session = AVAudioSession.sharedInstance()
                    try? session.setCategory(.playback, mode: .spokenAudio, options: [.duckOthers])
                    try? session.setActive(true)
                    
                    let utterance = AVSpeechUtterance(string: currword.thai)
                    utterance.voice = AVSpeechSynthesisVoice(language: "th-TH")
                    utterance.rate = 0.3
                    audioPlayer.speak(utterance)
                } label: {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundStyle(.bgTextbox)
                    
                    Text("Tap to hear pronunciation")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.6))
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom,10)
                
                Spacer()
            }
            .opacity(showPronunciation ? 1 : 0)
            
            
        }
        .padding(28)
        .frame(width: 350, height: 400)
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(.offWhite)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 15,
                    x: 0,
                    y: 8
                )
        }
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(.offWhiteShadow)
                .offset(y: 7)
        }
        .overlay {
            RoundedRectangle(cornerRadius: 28)
                .stroke(.gray.opacity(0.15), lineWidth: 1)
        }
    }
}

struct DeckMenu: View {
    var decks: [Deck] // allows us to use the model from
    let currword: VocabWord
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        Section {
            ForEach(decks,id: \.self) { deck in
                Button {
                    let word = currword
                    if !deck.words.contains(where: { $0.thai == currword.thai }) {
                        deck.words.append(word)
                        print("\(currword.thai) added!")
                        print("deck words:")
                        print(deck.words)
                    } else {
                        // if its alr added, itll like remove instead
                        deck.words.removeAll(where: { $0.thai == currword.thai})
                        print("\(currword.thai) removed!")
                        print("deck words:")
                        print(deck.words)
                    }
                } label: {
                    Text(deck.name)
                    if deck.words.contains(where: { $0.thai == currword.thai }) {
                        Image(systemName: "checkmark.circle.fill")
                    }
                }
                .menuActionDismissBehavior(.disabled)
            }
        }
        Section {
            Button {
                modelContext.insert(Deck(name: "New Deck \(decks.count + 1)", words: []))
                print("deck created")
                print(decks)
            } label: {
                Text("Create Deck")
            }
            .menuActionDismissBehavior(.disabled)
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
        
        FlashcardView(currword: exampleWord,showPronunciation: true)
            .modelContainer(for: Deck.self, inMemory: true)
    }
}
