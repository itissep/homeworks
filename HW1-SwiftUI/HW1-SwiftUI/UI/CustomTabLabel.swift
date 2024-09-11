import SwiftUI

struct CustomTabLabel: View {
    let index: Int
    
    var valueFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        return formatter
    }()
    
    var formattedNumber: String { valueFormatter.string(from: NSNumber(value: index))! }
    
    var body: some View {
        Label(
            title: { Text(formattedNumber) },
            icon: { Image(systemName: "\(index).square.fill") }
        )
    }
}
