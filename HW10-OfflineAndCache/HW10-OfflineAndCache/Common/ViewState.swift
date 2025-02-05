import Foundation

enum ViewState: Equatable {
    case loading
    case completed
    case failure(error: Error)
    
    static func == (lhs: ViewState, rhs: ViewState) -> Bool {
        switch (lhs, rhs) {
        case (.completed, .completed): true
        case (.loading, .loading): true
        case (.failure(error: _), .failure(error: _)): true
        default: false
        }
    }
}
