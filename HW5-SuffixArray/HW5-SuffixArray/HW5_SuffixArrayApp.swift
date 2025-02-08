import SwiftUI

@main
struct HW5_SuffixArrayApp: App {
    let viewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: viewModel)
                .preferredColorScheme(.dark)
                .onOpenURL { handleURL($0) }
        }
    }
    
    private func handleURL(_ url: URL) {
        if url.scheme == "gui", url.host == "sharedText" {
            let sharedDefaults = UserDefaults(suiteName: "group.gui.HW5-SuffixArray")
            if let text = sharedDefaults?.string(forKey: "text") {
                viewModel.text = text
            }
        }
    }
}
