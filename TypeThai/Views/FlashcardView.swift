import SwiftUI

struct FlashcardView: View {
    
    let currword: VocabWord
    let showPronunciation: Bool
    
    var body: some View {
        VStack(spacing: 24) {
            
            // Word type
            Text(currword.type.uppercased())
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.orange)
                .padding(.horizontal, 14)
                .padding(.vertical, 7)
                .background {
                    Capsule()
                        .fill(.orange.opacity(0.12))
                }
            
            Spacer()
            
            // Thai word
            Text(currword.thai)
                .font(.system(size: 72, weight: .bold))
                .foregroundStyle(.primary)
            
            // Pronunciation
            Text(currword.pronunciation)
                .font(.title3)
                .foregroundStyle(.secondary)
            
            // English meaning
            Text(currword.english)
                .font(.title2)
                .fontWeight(.medium)
            
            Spacer()
            
            Divider()
            
            if showPronunciation {
                HStack {
                    Image(systemName: "speaker.wave.2.fill")
                        .foregroundStyle(.orange)
                    
                    Text("Tap to hear pronunciation")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    Spacer()
                }
            }
            
        }
        .padding(28)
        .frame(width: 350, height: 400)
        .background {
            RoundedRectangle(cornerRadius: 28)
                .fill(.background)
                .shadow(
                    color: .black.opacity(0.08),
                    radius: 15,
                    x: 0,
                    y: 8
                )
        }
        .overlay {
            RoundedRectangle(cornerRadius: 28)
                .stroke(.gray.opacity(0.15), lineWidth: 1)
        }
    }
}

#Preview {
    ZStack {
        Color(.systemGroupedBackground)
            .ignoresSafeArea()
        
        FlashcardView(currword: exampleWord,showPronunciation: true)
    }
}
