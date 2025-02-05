import SwiftUI

struct EpisodeList: View {
    
    var episodesURLs: [String]
    @State var episodes: [EpisodeDTO] = []
    
    var body: some View {
        VStack {
            List(episodes) { episode in
                HStack {
                    Text(episode.episode)
                        .bold()
                    Spacer()
                    Text(episode.name)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                .fontDesign(.monospaced)
            }.listStyle(.plain)
        }.task {
            episodesURLs.forEach { episodeURL in
                Task {
                    let episode = try await NetworkService.shared.fetch(.episode(episodeURL)).toEpisode()
                    self.episodes.append(episode)
                }
            }
        }
        .navigationBarTitle("Appears in:")
    }
}
