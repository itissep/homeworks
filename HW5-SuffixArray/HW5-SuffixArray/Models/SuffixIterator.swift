import Foundation

final class SuffixIterator: IteratorProtocol {
    
    private let word: String
    private var index: String.Index

    init(_ word: String) {
        
        self.word = word
        self.index = word.startIndex
    }
    
    func next() -> String? {
        
        guard index != word.endIndex else {
            return nil
        }
        
        let suffix = String(word[index...]).lowercased()
        index = word.index(after: index)
        return suffix
    }
}
