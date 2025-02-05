import SwiftUI

struct AsyncImageView: View {
    var image: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: image),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: Style.imageSize, height: Style.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadiusSmall))
            },
            placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .frame(width: Style.imageSize, height: Style.imageSize)
            }
        )
    }
}
