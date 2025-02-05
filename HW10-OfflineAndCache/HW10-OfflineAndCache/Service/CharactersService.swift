import Foundation
import SwiftData

protocol CharacterServiceProtocol {
    
    func append(entity: CharacterEntity) throws
    func fetch() -> [CharacterEntity]
    func update() async throws
    func deleteAll() throws
}

class CharacterService: CharacterServiceProtocol {
    
    private let modelContext: ModelContextProtocol
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol, modelContext: ModelContextProtocol) {
        self.modelContext = modelContext
        self.networkService = networkService
    }
    
    func fetch() -> [CharacterEntity] {
        do {
            let userEntities = try modelContext.fetch(FetchDescriptor<CharacterEntity>())
            print("--> number of cached entities: \(userEntities.count) ")
            return userEntities
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func append(entity: CharacterEntity) throws {
        modelContext.insert(entity)
        try modelContext.save()
    }
    
    func deleteAll() throws {
        try modelContext.deleteAll(model: CharacterEntity.self)
    }
    
    func update() async throws {
        let request = Request.characters
        let items: [CharacterDTO] = try await networkService.fetch(request).toAPIResponse().results
        print("--> number of fetched from net entities: \(items.count) ")
        try deleteAll()
        for item in items {
            let characterEntity = CharacterEntity(from: item)
            try append(entity: characterEntity)
        }
    }
}
