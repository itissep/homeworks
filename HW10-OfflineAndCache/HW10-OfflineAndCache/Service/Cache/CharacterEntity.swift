import Foundation
import SwiftData

@Model
class CharacterEntity {
    
    @Attribute(.unique) var id: UUID
    var characterID: Int
    var name: String
    var species: String
    var type: String
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
    init(
        id: UUID,
        characterID: Int,
        name: String,
        species: String,
        type: String,
        image: String,
        episode: [String],
        url: String,
        created: String
    ) {
        self.id = id
        self.characterID = characterID
        self.name = name
        self.species = species
        self.type = type
        self.image = image
        self.episode = episode
        self.url = url
        self.created = created
    }
}

extension CharacterEntity {
    
    convenience init(from characterDTO: CharacterDTO) {
        self.init(
            id: characterDTO.id,
            characterID: characterDTO.characterID,
            name: characterDTO.name,
            species: characterDTO.species,
            type: characterDTO.type,
            image: characterDTO.image,
            episode: characterDTO.episode,
            url: characterDTO.url,
            created: characterDTO.created
        )
    }
}

extension CharacterEntity: Identifiable { }
