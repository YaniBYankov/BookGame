import Foundation

struct GameModel: Codable {
    let title: String
    let description: String
    let chapters: [ChapterModel]
}

struct ChapterModel: Codable, Identifiable, Hashable {
    let id: String
    var type: ChapterType?
    let title: String
    let text: String
    let actions: [ChapterActionModel]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let type = try container.decodeIfPresent(ChapterType.self, forKey: .type)
        self.title = try container.decode(String.self, forKey: .title)
        self.text = try container.decode(String.self, forKey: .text)
        self.actions = try container.decode([ChapterActionModel].self, forKey: .actions)
        
        if type != nil {
            self.type = type
        } else {
            if self.actions.isEmpty {
                self.type = .finish
            } else {
                self.type = .middle
            }
        }
    }
}

struct ChapterActionModel: Codable, Hashable{
    let description: String
    let next: String
}

enum ChapterType: String, Codable {
    case start
    case middle
    case finish
}
