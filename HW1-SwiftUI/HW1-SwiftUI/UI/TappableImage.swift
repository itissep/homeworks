import SwiftUI

struct TappableImage: View {
    let imageName: String
    let color: Color
    
    @State var isAnimated: Bool = false
    
    var body: some View {
        Button {
            isAnimated.toggle()
        } label: {
            VStack {
                Image(systemName: imageName)
                    .font(.system(size: 200))
                    .foregroundColor(color)
                    .symbolEffect(.bounce, value: isAnimated)
                CaptionText("click on me", color)
            }
        }
        .buttonStyle(.plain)
    }
}
