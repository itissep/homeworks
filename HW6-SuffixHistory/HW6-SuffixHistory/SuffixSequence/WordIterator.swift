import Foundation

final class WordIterator: IteratorProtocol {
    
    private let text: String
    private var currentRange: Range<String.Index>
    private var isFinished = false
    
    init(_ text: String) {
        self.text = text
        self.currentRange = text.startIndex..<text.endIndex
    }
    
    func next() -> String? {
        
        guard !isFinished else {
            return nil
        }
        
        var word: String? = nil
        
        text.enumerateSubstrings(in: currentRange, options: [.byWords]) {[weak self] substring, range, _, stop in
            guard let self else {
                return
            }
            
            word = substring
            currentRange = range.upperBound..<text.endIndex
            stop = true
        }
        
        if word == nil {
            isFinished = true
        }
        return word
    }
}
