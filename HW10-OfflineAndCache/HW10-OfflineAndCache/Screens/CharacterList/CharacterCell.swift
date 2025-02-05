import SwiftUI

struct CharacterCell: View {
    var model: CharacterEntity
    
    var body: some View {
        HStack(spacing: Style.paddingLarge) {
            AsyncImageView(image: model.image)
                .padding(Style.paddingSmall)
                .background {
                    RoundedRectangle(cornerRadius: Style.cornerRadius)
                        .stroke(lineWidth: 3).foregroundColor(.accentColor)
                }
            VStack(spacing: Style.paddingSmall) {
                Text(model.name)
                    .font(.title3)
                    .fontDesign(.monospaced)
                    .multilineTextAlignment(.center)
                    .bold()
                Text("\(model.species)")
                    .fontDesign(.monospaced)
            }
        }
    }
}
