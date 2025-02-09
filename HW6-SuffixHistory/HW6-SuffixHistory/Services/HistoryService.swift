import Foundation
import SwiftUI

struct Searches {
    let text: String
    let time: TimeInterval
    let results: [Suffix]
}


class HistoryService: ObservableObject {
    @Published var items: [Searches] = []
    
    @MainActor
    func append(_ data: Searches) {
        items.append(data)
        print("added \(items.count)")
    }
    
    @MainActor
    func clear() {
        items.removeAll()
    }
    
    var maxTime: TimeInterval {
        items.map { $0.time }.max() ?? 0
    }
    
    var minTime: TimeInterval {
        items.map { $0.time }.min() ?? 0
    }
}
