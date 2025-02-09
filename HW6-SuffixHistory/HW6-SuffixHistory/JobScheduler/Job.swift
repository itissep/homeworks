import Foundation

struct Job {
    let id: UUID = UUID()
    let word: String
    let completion: (ResultItem) -> Void
}
