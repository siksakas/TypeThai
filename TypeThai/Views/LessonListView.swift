import SwiftUI
import SwiftData

struct LessonListView: View {
    @Query var lessonProgress: [LessonProgress]
    
    @Binding var showTabBar: Bool
    
    @State private var lessonTap: Int = 0
    
    func isComplete(_ lesson: Lesson) -> Bool {
        if (lessonProgress.contains { $0.lessonID == lesson.name && $0.isComplete }) {
            print("marked complete!")
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Logo()
                    .padding(.top,10)
                VStack(spacing: 20) {
                    
                    ProgressionView()
                    
                    ForEach(lessons) { lesson in
                        NavigationLink {
                            LessonView(thisLesson: lesson)
                                .onAppear {
                                    showTabBar = false
                                }
                                .onDisappear {
                                    showTabBar = true
                            }
                                .toolbar(.hidden,for: .tabBar)
                        } label: {
                            HStack {
                                Text(lesson.name)
                                    .font(.system(size: 18, weight: .bold, design: .rounded))

                                Spacer()

                                if isComplete(lesson) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundStyle(.green)
                                }

                                Image(systemName: "chevron.right")
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(.secondary)
                            }
                            .foregroundStyle(.black)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 18)

                        }
                        .buttonStyle(
                            RaisedButtonStyle(
                                face: Color(.offWhite),
                                shadow: Color(.offWhiteShadow),
                                cornerRadius: 20,
                                depth: 5
                            )
                        )
                        .simultaneousGesture(
                            TapGesture().onEnded {
                                lessonTap += 1
                            }
                        )
                        .sensoryFeedback(.impact(weight: .light), trigger: lessonTap)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
            }
            .background(Color.bg)
        }
        
    }
    
    struct Logo: View {
        var body: some View {
            HStack(alignment: .top, spacing: 2) {
                HStack {
                    Text("Type").foregroundColor(.white)
                    Text("Thai").foregroundColor(Color.customYellow)
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
        }
    }
}



#Preview {
    @Previewable @State var showTabBar: Bool = true
    LessonListView(showTabBar: $showTabBar)
        .modelContainer(for: LessonProgress.self, inMemory: true)
        .modelContainer(for: Deck.self, inMemory: true)
}
