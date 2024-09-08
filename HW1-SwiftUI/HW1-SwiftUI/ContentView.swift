import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeScreen()
                .tabItem { Label(
                    title: { Text("Home") },
                    icon: { Image(systemName: "42.circle") }
                ) }
        }
    }
}

#Preview {
    ContentView()
}
