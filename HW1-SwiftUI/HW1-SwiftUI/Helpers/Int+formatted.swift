import Foundation

extension Int {
    private var valueFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }
    
    var formatted: String {
        valueFormatter.string(from: NSNumber(value: self))!
    }
}
