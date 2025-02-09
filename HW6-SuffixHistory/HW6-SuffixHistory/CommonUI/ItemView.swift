import SwiftUI

struct ItemView: View {
    var model: ResultItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(model.string)
                    .font(.largeTitle)
                    .foregroundStyle(model.color)
                    .monospaced()
                
                Text(model.suffixes)
                    .font(.caption)
                    .foregroundStyle(.white)
                    .monospaced()
            }
            Spacer()
            
            Text(String(format: "%.6f сек", model.duration))
                .monospaced()
                .foregroundStyle(.white)
        }
        .padding(.all, Style.spacing)
        .background {
            RoundedRectangle(cornerRadius: Style.cornerRadius)
                .foregroundStyle(model.color.opacity(0.1))
        }
    }
}
