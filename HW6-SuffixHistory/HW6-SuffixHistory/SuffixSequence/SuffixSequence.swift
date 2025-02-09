import Foundation

struct SuffixSequence: Sequence {
    
    let word: String
    
    init(_ word: String) {
        self.word = word
    }
    
    func makeIterator() -> SuffixIterator { SuffixIterator(word) }
}
