import SwiftUI
import SwiftData

struct OverviewView: View {
    @Query var lessonProgress: [LessonProgress]
    func isComplete(_ lesson: Lesson) -> Bool {
        if (lessonProgress.contains { $0.lessonID == lesson.name && $0.isComplete }) {
            print("marked complete!")
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationStack {
            List (lessons) { lesson in
                NavigationLink {
                    LessonView(thisLesson: lesson)
                } label: {
                    Text(lesson.name)
                    
                    if isComplete(lesson) {
                        Image(systemName: "checkmark")
                    }
                }
            }
        }
    }
}

#Preview {
    OverviewView()
        .modelContainer(for: LessonProgress.self, inMemory: true)
}
