import SwiftUI

struct ResultItem: Identifiable {
    let id = UUID()
    let string: String
    let suffixes: String
    let duration: TimeInterval
    var color: Color = .green
}
