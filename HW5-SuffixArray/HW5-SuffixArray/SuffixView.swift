import SwiftUI

struct SuffixView: View {
    var model: Suffix
    
    var body: some View {
        HStack {
            Text(model.suffix)
                .font(.largeTitle)
                .foregroundStyle(.dark)
                .monospaced()
            Spacer()
            Circle()
                .foregroundColor(.dark)
                .frame(width: 50, height: 50)
                .overlay {
                    Text("\(model.count)")
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
    
    private var color: Color {
        if model.count == 2 { return .rare }
        if model.count <= 6  { return .uncommon }
        return .common
    }
}

