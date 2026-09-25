import SwiftUI

struct OverviewView: View {
    var body: some View {
        NavigationStack {
            List (lessons) { lesson in
                NavigationLink {
                    LessonView(thisLesson: lesson)
                } label: {
                    Text("Lesson")
                }
            }
        }
    }
}

#Preview {
    OverviewView()
}
