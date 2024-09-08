import SwiftUI

struct HomeScreen: View {
    var body: some View {
        Text("Hello, World!")
    }
    
    @ViewBuilder
    func section() -> any View {
        Text("Hello, World!")
    }
}

#Preview {
    HomeScreen()
}
