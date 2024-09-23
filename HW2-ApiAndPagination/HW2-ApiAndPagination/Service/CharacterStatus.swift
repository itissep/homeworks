import Foundation

enum CharacterStatus: String, CaseIterable, Identifiable, Equatable {
    case all = "all"
    case alive = "alive"
    case dead = "dead"
    case unknown = "unknown"
    
    var id: CharacterStatus { self }
}
