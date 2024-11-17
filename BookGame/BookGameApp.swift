import SwiftUI

@main
struct BookGameApp: App {
    let gameViewModel: GameViewModel = GameViewModel(withFile: "game")
    var body: some Scene {
        WindowGroup {
            GameView()
                .environmentObject(gameViewModel)
                .accentColor(Color.purple)
        }
    }
}
