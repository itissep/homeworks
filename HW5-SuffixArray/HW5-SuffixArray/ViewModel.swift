import Foundation
import Combine

enum SortingType: String, CaseIterable {
    case asc = "ascending"
    case desc = "descending"
    
    func check(_ first: String, _ second: String) -> Bool {
        switch self {
        case .asc: first < second
        case .desc: first > second
        }
    }
}

enum FilteringType: String, CaseIterable {
    case moreThen = "more then"
    case only = "only"
    
    func check(_ count: Int) -> Bool {
        switch self {
        case .moreThen: count >= Settings.suffixRange
        case .only: count == Settings.suffixRange
        }
    }
}

enum ListType: String, CaseIterable {
    case all = "all"
    case top = "top"
}

final class ViewModel: ObservableObject {
    
    // General
    @Published var text: String = Settings.defaultText
    @Published var filteringType: FilteringType = .only
    @Published var listType: ListType = .all
    
    // All
    @Published var sortingType: SortingType = .asc
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
                update(sortingType, filteringType, searchText)
            }
            .store(in: &subscriptions)
        
        $filteringType
            .sink { [weak self] filteringType in
                guard let self = self else {
                    return
                }
                update(sortingType, filteringType, searchText)
            }
            .store(in: &subscriptions)
        
        $sortingType
            .sink { [weak self] sortingType in
                guard let self = self else {
                    return
                }
                update(sortingType, filteringType, searchText)
            }
            .store(in: &subscriptions)
        
        $searchText
            .debounce(for: .milliseconds(Settings.debounceMs), scheduler: RunLoop.main)
            .sink { [weak self] searchString in
                guard let self = self else {
                    return
                }
                update(sortingType, filteringType, searchString)
            }
            .store(in: &subscriptions)
    }
    
    private func update(_ sortingType: SortingType, _ filteringType: FilteringType, _ searchString: String) {
        let wordIterator = WordIterator(text)
        
        var suffixes = [String: Int]()
        
        while let word = wordIterator.next() {
            let suffixSequence = SuffixSequence(word)
            for suffix in suffixSequence {
                if filteringType.check(suffix.count) {
                    suffixes[suffix] = (suffixes[suffix] ?? 0) + 1
                }
            }
        }
        
        let suffixArray = suffixes.map { Suffix(suffix: $0, count: $1) }
        
        items = suffixArray.sorted(by: { sortingType.check($0.suffix, $1.suffix) } )
        
        if !searchString.isEmpty {
            items = items?.filter { $0.suffix.starts(with: searchString) }
        }
        
        topItems = Array(
            suffixArray
                .filter { filteringType.check($0.suffix.count) }
                .sorted { $0.count > $1.count }
                .prefix(Settings.topNumber)
        )
    }
}
