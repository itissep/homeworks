import SwiftUI

struct CharacterCell: View {
    var model: Character
    
    var body: some View {
        HStack {
            AsyncImageView(image: model.image)
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 3).foregroundColor(.accentColor)
                }
            Spacer()
        }.overlay {
            HStack {
                Spacer()
                    .frame(minWidth: 100)
                VStack(alignment: .leading, spacing: 4) {
                    Text(model.name)
                        .font(.headline)
                        .fontDesign(.monospaced)
                    
                    Text("Species: \(model.species)")
                        .font(.subheadline)
                        .fontDesign(.monospaced)
                    
                    Group {
                        Text("Gender: \(model.gender.rawValue)")
                        Text("Origin: \(model.origin.name)")
                    }
                    .font(.caption)
                    .fontDesign(.monospaced)
                    .foregroundColor(.secondary)
                    
                }
                .padding(20)
                .background(Color.common)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            }
        }
    }
}
