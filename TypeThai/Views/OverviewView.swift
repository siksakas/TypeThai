import SwiftUI
import SwiftData

struct OverviewView: View {
    @Query var lessonProgress: [LessonProgress]
    
    @State private var lessonTap: Int = 0
    
    func isComplete(_ lesson: Lesson) -> Bool {
        if (lessonProgress.contains { $0.lessonID == lesson.name && $0.isComplete }) {
            print("marked complete!")
            return true
        }
        return false
    }
    
    var body: some View {
        TabView {
            Tab {
                NavigationStack {
                    ScrollView {
                        Logo()
                            .padding(.top,10)
                        VStack(spacing: 20) {
                            ForEach(lessons) { lesson in
                                NavigationLink {
                                    LessonView(thisLesson: lesson)
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
                                .buttonStyle(.plain)
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
            label: {
                Image(systemName:"house.fill")
                Text("Home")
            }
            
            Tab {
               DeckView()
            } label: {
                
            }
            
        }
//        .tabViewStyle()
        
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
    OverviewView()
        .modelContainer(for: LessonProgress.self, inMemory: true)
        .modelContainer(for: Deck.self, inMemory: true)
}
