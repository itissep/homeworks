import SwiftUI

struct ThirdScreen: View {
    @State private var isModalShown = false
    
    var body: some View {
        CustomButton(title: "show modal") { isModalShown.toggle() }
            .sheet(isPresented: $isModalShown) { ModalView() }
    }
}

struct ModalView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Spacer()
            TappableImage(imageName: "ellipsis.message.fill", color: .plum)
            Spacer()
            CustomButton(title: "dismiss") { dismiss() }
        }
        .padding()
    }
}
