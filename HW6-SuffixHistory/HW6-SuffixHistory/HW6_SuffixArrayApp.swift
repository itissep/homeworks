import SwiftUI

@main
struct HW6_SuffixArrayApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
                .preferredColorScheme(.dark)
        }
    }
}
