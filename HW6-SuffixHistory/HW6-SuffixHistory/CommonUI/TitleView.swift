import SwiftUI

struct TitleView: View {
    
    let title: String
    
    var body: some View {
        Text(title)
            .foregroundStyle(.white)
            .font(.title)
            .monospaced()
            .padding(.all, Style.spacing)
    }
}

