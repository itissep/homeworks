import SwiftUI

struct AsyncImageView: View {
    var image: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: image),
            content: { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            },
            placeholder: {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .accentColor))
                    .frame(width: 200, height: 200)
            }
        )
    }
}
