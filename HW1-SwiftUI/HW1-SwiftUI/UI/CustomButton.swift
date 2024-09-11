import SwiftUI

struct CustomButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.system(size: 20, design: .monospaced))
        }
        .buttonStyle(.plain)
        .padding(20)
        .background(.accent)
        .foregroundColor(.black)
        .clipShape(.rect(cornerRadius: 12))
    }
}
