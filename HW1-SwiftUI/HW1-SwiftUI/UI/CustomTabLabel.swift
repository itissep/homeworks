import SwiftUI

struct CustomTabLabel: View {
    let index: Int
    
    var body: some View {
        Label(
            title: { Text(index.formatted) },
            icon: { Image(systemName: "\(index).square.fill") }
        )
    }
}
