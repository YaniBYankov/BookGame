import Foundation
import SwiftUI

public enum GameState {
    case notStarted
    case started
    case ednded
}

class GameViewModel: ObservableObject {
    
    var model: GameModel? = nil
    
    @Published var path = [ChapterModel]()
    
    init(withFile: String) {
        if let data = readLocalJSONFile(forName: withFile) {
            self.model = try? JSONDecoder().decode(GameModel.self, from: data)
        } else {
            print("Function \(#function) couldn't decode JSON")
        }
    }
    
    func getChapter(forId id: String) -> ChapterModel? {
        guard let model = self.model else { return nil }
        return model.chapters.first { $0.id == id }
    }
    
    func getChapter(forType type: ChapterType) -> ChapterModel? {
        guard let model = self.model else { return nil }
        return model.chapters.first { $0.type == type }
    }
    
    
    func readLocalJSONFile(forName name: String) -> Data? {
        
        guard let filePath = Bundle.main.path(forResource: name, ofType: "json") else {
            print(" Function: \(#function) file \(name).json couldn't be found")
            return nil
        }
        
        let fileURL = URL(filePath: filePath)
        
        do {
            let data = try Data(contentsOf: fileURL)
            return data
        } catch {
            print(" Function: \(#function) error: \(error)")
        }
        return nil
    }

    
}
