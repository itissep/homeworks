import Foundation

struct APIResponseDTO: Decodable {
    
    let results: [CharacterDTO]
}
