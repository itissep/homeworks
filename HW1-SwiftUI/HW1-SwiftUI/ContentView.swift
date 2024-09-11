import SwiftUI

let colors: [Color] = [Color.lime, Color.plum, Color.peach, Color.lemon]

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var selectedItem: Int? = nil
    
    var body: some View {
        TabView(selection: $selectedTab) {
            FirstScreen(selectedTab: $selectedTab, selectedItem: $selectedItem)
                .tabItem { CustomTabLabel(index: 1) }
                .tag(0)
            
            SecondScreen(selectedItem: $selectedItem)
                .tabItem { CustomTabLabel(index: 2) }
                .tag(1)
            
            ThirdScreen()
                .tabItem { CustomTabLabel(index: 3) }
                .tag(3)
        }
    }
}
