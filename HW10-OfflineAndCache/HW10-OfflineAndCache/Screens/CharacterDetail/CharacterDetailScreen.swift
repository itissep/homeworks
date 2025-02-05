import SwiftUI

struct CharacterDetailScreen: View {
    var model: CharacterEntity
    
    var body: some View {
        VStack(spacing: Style.paddingLarge) {
            AsyncImageView(image: model.image)
            VStack {
                HStack {
                    Text("Species: ")
                    Text(model.species + model.type)
                }
                Text("ID: \(model.characterID)")
            }
            .padding(Style.paddingLarge)
            .background(.common)
            .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius))
            
            NavigationLink {
                EpisodeList(episodesURLs: model.episode)
            } label: {
                Text("Show episodes list")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .fontDesign(.monospaced)
                    .padding(Style.paddingLarge)
                    .background(Color.common)
                    .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius))
                    .background {
                        RoundedRectangle(cornerRadius: Style.cornerRadius)
                            .stroke(lineWidth: 3).foregroundColor(.accentColor)
                    }
            }
            Spacer()
        }
        .padding()
        .navigationBarTitle(model.name)
    }
}

struct DetailView: View {
    let title: String
    let detail: String
    
    init(_ title: String, _ detail: String) {
        self.title = title
        self.detail = detail
    }
    
    var body: some View {
        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
            Text(detail)
                .font(.headline)
        }
        .fontDesign(.monospaced)
    }
}
