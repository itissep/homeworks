import Foundation

struct CharacterDTO: Decodable, Identifiable, Equatable, Hashable {
    
    let id = UUID()
    let characterID: Int
    let name: String
    let species: String
    let type: String
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case characterID = "id"
        case name, species, type, image, episode, url, created
    }
}
