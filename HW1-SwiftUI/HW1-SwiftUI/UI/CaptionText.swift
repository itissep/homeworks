import SwiftUI

struct CaptionText: View {
    let title: String
    let color: Color
    
    init(_ title: String, _ color: Color) {
        self.title = title
        self.color = color
    }
    
    var body: some View {
        Text(title)
            .font(.system(size: 20, design: .monospaced))
            .foregroundColor(color.opacity(0.4))
    }
}
