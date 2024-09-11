import SwiftUI

struct SecondScreen: View {
    @Binding var selectedItem: Int?
    
    var body: some View {
        NavigationView {
            List(0..<4) { index in
                HStack {
                    Spacer()
                    CardView(index: index, color: colors[index])
                        .overlay(
                            NavigationLink(
                                destination: DetailView(index: index, color: colors[index]),
                                tag: index,
                                selection: $selectedItem
                            ) { EmptyView() }.opacity(0)
                        )
                }
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
            }
        }.navigationViewStyle(.stack)
    }
}

struct CardView: View {
    let index: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\((index + 1).formatted)")
                .font(.system(size: 20, design: .monospaced))
        }
        .padding(.all, 20)
        .frame(maxWidth: .infinity)
        .background(color)
        .foregroundColor(.black)
        .clipShape(.rect(cornerRadius: 12))
    }
}

struct DetailView: View {
    var index: Int
    var color: Color

    var body: some View {
        VStack {
            CaptionText("this is \(index + 1) item", color)
            TappableImage(imageName: "target", color: color)
        }
    }
}
