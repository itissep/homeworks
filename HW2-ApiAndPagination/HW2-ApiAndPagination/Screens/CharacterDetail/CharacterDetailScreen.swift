import SwiftUI

struct CharacterDetailScreen: View {
    var model: Character
    
    var body: some View {
        VStack(spacing: 24) {
            AsyncImageView(image: model.image)
            VStack {
                HStack {
                    Text("Species: ")
                    Text(model.species + model.type)
                }
                Text("Gender: \(model.gender.rawValue)")
                Text("Status: \(model.status.rawValue)")
                Text("ID: \(model.characterID)")
            }
            .padding(20)
            .background(.common)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            

            DetailView("Origin:", model.origin.name)
            DetailView("Last known location:", model.location.name)
            
            NavigationLink {
                EpisodeList(episodesURLs: model.episode)
            } label: {
                Text("Show episodes list")
                    .font(.headline)
                    .foregroundColor(.accentColor)
                    .fontDesign(.monospaced)
                    .padding(20)
                    .background(Color.common)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .background {
                        RoundedRectangle(cornerRadius: 20)
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
