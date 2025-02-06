import Foundation
import Combine

final class ViewModel: ObservableObject {
    
    struct Suffix {
        let suffix: String
        let count: Int
    }
    
    enum SortingType: String {
        case asc = "ASC"
        case desc = "DESC"
    }
    
    // General
    @Published var text: String = Settings.defaultText
    
    // All
    @Published var sortingType: SortingType = SortingType.asc
    @Published var searchText: String = ""
    @Published var items: [Suffix]? = nil
    
    // Top
    @Published var topItems: [Suffix]? = nil

    private var subscriptions = Array<AnyCancellable>()
    
    init() {
        setup()
    }
    
    private func setup() {
        $text
            .sink { [weak self] _ in
                guard let self = self else {
                    return
                }
                update(sortingType, searchText)
            }
            .store(in: &subscriptions)
        
        $sortingType
            .sink { [weak self] sortBy in
                guard let self = self else {
                    return
                }
                update(sortBy, searchText)
            }
            .store(in: &subscriptions)
        
        $searchText
            .debounce(for: .milliseconds(Settings.debounceMs), scheduler: RunLoop.main)
            .sink { [weak self] searchString in
                guard let self = self else {
                    return
                }
                update(sortingType, searchString)
            }
            .store(in: &subscriptions)
    }
    
    private func update(_ sortBy: SortingType, _ searchString: String) {
        let wordIterator = WordIterator(text)
        
        var suffixes = [String: Int]()
        
        while let word = wordIterator.next() {
            let suffixSequence = SuffixSequence(word)
            for suffix in suffixSequence {
                if suffix.count >= Settings.suffixRange {
                    suffixes[suffix] = (suffixes[suffix] ?? 0) + 1
                }
            }
        }
        
        let suffixArray = suffixes.map { Suffix(suffix: $0, count: $1) }
        
        items = suffixArray.sorted(by: { sortBy == .asc ? $0.suffix < $1.suffix : $0.suffix > $1.suffix })
        
        if !searchString.isEmpty {
            items = items?.filter { $0.suffix.starts(with: searchString) }
        }
        
        topItems = Array(
            suffixArray
                .filter { $0.suffix.count == Settings.suffixRange }
                .sorted { $0.count > $1.count }
                .prefix(Settings.topNumber)
        )
    }
}
