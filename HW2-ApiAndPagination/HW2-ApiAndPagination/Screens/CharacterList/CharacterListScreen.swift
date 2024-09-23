import SwiftUI

struct CharacterListScreen: View {
    @State var selectedStatus: CharacterStatus = .all
    @State var models: [Character] = []
    @State var error: Error?
    
    @State var page: Int = 1
    
    @State var isLastPage: Bool = false
    
    var body: some View {
        NavigationStack {
            Picker("Status", selection: $selectedStatus) {
                ForEach(CharacterStatus.allCases) { status in
                    Text(status.rawValue)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            if models.isEmpty {
                Spacer()
                ProgressView()
                Spacer()
            } else {
                List {
                    ForEach(models) { item in
                        HStack {
                            CharacterCell(model: item)
                                .overlay(
                                    NavigationLink(
                                        destination: CharacterDetailScreen(model: item)
                                    ) { EmptyView() }.opacity(0)
                                )
                        }
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                    }
                    if !self.isLastPage {
                        Text("Loading more ... ")
                            .fontDesign(.monospaced)
                            .foregroundColor(.accentColor)
                            .onAppear {
                                Task {
                                    self.page += 1
                                    let result = try await NetworkingService
                                        .fetch(.characters(page, selectedStatus))
                                        .toAPIResponse()
                                    self.models += result.results
                                    
                                    if result.info.next == nil {
                                        self.isLastPage = true
                                    }
                                }
                            }
                    }
                }
                .listStyle(.plain)
                .overlay {
                    VStack {
                        Spacer()
                        Text("loaded pages: \(page)")
                            .font(.caption)
                            .fontDesign(.monospaced)
                            .padding(10)
                            .background(Color.common)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .opacity(0.8)
                    }
                }
            }
        }
        .onChange(of: selectedStatus) {
            Task {
                self.models = try await NetworkingService
                    .fetch(.characters(1, selectedStatus))
                    .toAPIResponse()
                    .results
            }
        }
        .task {
            Task {
                self.models = try await NetworkingService
                    .fetch(.characters(1, .all))
                    .toAPIResponse()
                    .results
            }
        }
    }
}
