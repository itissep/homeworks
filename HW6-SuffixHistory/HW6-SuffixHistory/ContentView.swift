import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel: ViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                TitleView(title: "your text")
                
                TextEditor(text: $viewModel.text)
                    .foregroundStyle(.accent)
                    .monospaced()
                    .padding(.all, Style.spacing)
                    .scrollContentBackground(.hidden)
                    .background {
                        RoundedRectangle(cornerRadius: Style.cornerRadius)
                            .foregroundStyle(Color.accent.opacity(0.1))
                    }
                    .padding(.horizontal, Style.spacing)
                    .padding(.top, Style.spacing)
                    .frame(maxWidth: .infinity)
                    .frame(height: 100)
                
                Text(viewModel.summary)
                    .foregroundStyle(.accent.opacity(0.5))
                    .monospaced()
                    .font(.caption)
                    .padding(.horizontal, Style.spacing)
                    .padding(.bottom, Style.spacing)
                
                TitleView(title: "strings")
            
                Group {
                    ForEach(viewModel.items, id: \.id) {
                        ItemView(model: $0)
                    }
                }
                .padding(.all, Style.spacing)
            }
        }
        .backgroundStyle(.dark)
    }
}
