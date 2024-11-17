import Foundation
import SwiftUI

struct ChapterView: View {
    let chapter: ChapterModel
    
    @EnvironmentObject var viewModel: GameViewModel
    
    init(forChapter chapter: ChapterModel) {
        self.chapter = chapter
    }
    
    var body: some View {
        ScrollView {
            Text(chapter.title)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .font(.title)
                .padding(20)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(20)
            Spacer()
            Text(chapter.text)
                .fontWeight(.medium)
        }
        .padding(20)
        .background(Color.accentColor.opacity(0.2))
        .cornerRadius(20)
        .padding(10)
        
        if chapter.actions.isEmpty {
            Button("Play Again!") {
                guard let startChapter = viewModel.getChapter(forType: .start) else { return }
                viewModel.path = [startChapter]
            }
        }
        
        List {
            ForEach(chapter.actions, id: \.self) { action in
                Button {
                    guard let nextChapter = viewModel.getChapter(forId: action.next) else { return }
                    viewModel.path.append(nextChapter)
                } label: {
                    Text(action.description)
                }
            }
        }
        .cornerRadius(20)
        .padding(10)
        
    }
}
