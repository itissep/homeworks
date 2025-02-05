import Foundation
import SwiftUI

@Observable
class CharacterListViewModel {
    @ObservationIgnored
    private let repository: CharacterServiceProtocol
    
    var viewState: ViewState = .loading
    var characters: [CharacterEntity] = []
    
    init(repository: CharacterServiceProtocol) {
        self.repository = repository
    }
    
    @MainActor
    func load() async {
        self.viewState = .loading
        let entities = repository.fetch()
        if(entities.isEmpty) {
            do {
                try await update()
            } catch {
                self.viewState = .failure(error: error)
            }
        } else {
            self.characters = entities
            self.viewState = .completed
            await refresh()
        }
    }
    
    func refresh() async {
        do {
            try await update()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    private func update() async throws {
        try await repository.update()
        self.characters = repository.fetch()
        self.viewState = .completed
    }
}
