import SwiftUI

struct CharacterListScreen: View {
    @Environment(CharacterListViewModel.self) private var viewModel
    
    var body: some View {
        AsyncContentView(viewState: viewModel.viewState) {
            List {
                ForEach(viewModel.characters) { item in
                    CharacterCell(model: item)
                        .overlay(
                            NavigationLink(
                                destination: CharacterDetailScreen(model: item)
                            ) { EmptyView() }.opacity(0)
                        )
                }
            }
            .navigationTitle("Characters")
            .refreshable { await viewModel.refresh() }
        } onRetry: { Task { await viewModel.load() } }
        .task { await viewModel.load() }
    }
}
