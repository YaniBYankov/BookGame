import Foundation
import SwiftUI


struct GameView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack {
                if viewModel.path.isEmpty {
                    Button("Start Game") {
                        guard let startChapter = viewModel.getChapter(forType: .start) else { return }
                        viewModel.path.append(startChapter)
                    }
                }
            }
            .navigationDestination(for: ChapterModel.self) { chapter in
                ChapterView(forChapter: chapter)
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        let pathSize = viewModel.path.count
                        if pathSize >= 2 {
                            HStack {
                                Image(systemName: "chevron.compact.backward")
                                    .foregroundStyle(Color.accentColor)
                                Button(viewModel.path[pathSize - 2].title) {
                                    viewModel.path.removeLast()
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
