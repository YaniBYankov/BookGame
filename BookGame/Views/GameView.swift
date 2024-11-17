import Foundation
import SwiftUI


struct GameView: View {
    
    @EnvironmentObject var viewModel: GameViewModel
    
    var body: some View {
        NavigationStack(path: $viewModel.path) {
            VStack {
                if viewModel.path.isEmpty {
                    Text(viewModel.model?.title ?? "")
                        .multilineTextAlignment(.center)
                        .fontWeight(.bold)
                        .font(.title)
                        .padding(20)
                        .background(Color.accentColor.opacity(0.2))
                        .cornerRadius(20)
                    Spacer()
                    Text(viewModel.model?.description ?? "")
                        .fontWeight(.medium)
                    Spacer()
                    Button("Start Game") {
                        guard let startChapter = viewModel.getChapter(forType: .start) else { return }
                        viewModel.path.append(startChapter)
                    }
                    .padding(20)
                    .background(Color.accentColor.opacity(0.10))
                    .cornerRadius(20)
                    Spacer()
                }
            }
            .padding(20)
            .cornerRadius(20)
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
