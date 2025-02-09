import SwiftUI

struct ItemView: View {
    var title: String
    var subtitle: String
    var color: Color
    
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .foregroundStyle(.dark)
                .monospaced()
                .lineLimit(1)
            Spacer()
            Circle()
                .foregroundColor(.dark)
                .frame(width: 50, height: 50)
                .overlay {
                    Text(subtitle)
                        .font(.title)
                        .monospaced()
                        .foregroundStyle(.white)
                }
        }
        .padding(.all, Style.spacing)
        .background {
            RoundedRectangle(cornerRadius: Style.cornerRadius)
                .foregroundStyle(color)
        }
    }
}
