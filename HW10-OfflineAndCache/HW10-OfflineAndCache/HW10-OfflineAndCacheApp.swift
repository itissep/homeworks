import SwiftUI
import SwiftData

@main
struct HW10_OfflineAndCacheApp: App {
    private let networkService: NetworkServiceProtocol = NetworkService.shared
    private let modelContainer = try! ModelContainer(for: CharacterEntity.self)
    
    @State private var viewModel: CharacterListViewModel
    
    init() {
        let repository = CharacterService(
            networkService: networkService,
            modelContext: modelContainer.mainContext
        )
        viewModel = CharacterListViewModel(repository: repository)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CharacterListScreen().environment(viewModel)
            }
            .preferredColorScheme(.dark)
        }
    }
}
