import Foundation

struct Character: Decodable, Identifiable, Equatable, Hashable {
    
    let id = UUID()
    let characterID: Int
    let name: String
    let status: Status
    let species: String
    let type: String
    let gender: Gender
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    enum CodingKeys: String, CodingKey {
        case characterID = "id"
        case name, status, species, type, gender, origin, location, image, episode, url, created
    }
}

struct Origin: Decodable, Equatable {
    let name: String
}

enum Gender: String, Decodable, Hashable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}

enum Status: String, Decodable, Hashable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
