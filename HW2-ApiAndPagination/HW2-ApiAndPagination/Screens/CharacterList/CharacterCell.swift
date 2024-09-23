import SwiftUI

struct CharacterCell: View {
    var model: Character
    @State var isExpanded = false
    @State var isInfoShown = false
    @Namespace private var shapeTransition

    
    var body: some View {
        HStack {
            AsyncImageView(image: model.image)
                .padding(5)
                .background {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 3).foregroundColor(.accentColor)
                }
            Spacer()
        }.overlay {
            HStack {
                Spacer()
                if isExpanded {
                    RoundedRectangle(cornerRadius: 50.0)
                        .matchedGeometryEffect(id: "circle", in: shapeTransition)
                        .frame(minWidth: 0, maxHeight: 300)
                        .padding()
                        .foregroundColor(Color.common)
                        .animation(.easeIn)
                        .overlay {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(model.name)
                                    .font(.headline)
                                    .fontDesign(.monospaced)
                                
                                Text("Species: \(model.species)")
                                    .font(.subheadline)
                                    .fontDesign(.monospaced)
                                
                                Group {
                                    Text("Gender: \(model.gender.rawValue)")
                                    Text("Origin: \(model.origin.name)")
                                }
                                .font(.caption)
                                .fontDesign(.monospaced)
                                .foregroundColor(.secondary)
                            }
                            .opacity(isInfoShown ? 1 : 0)

                        }
                } else {
                    RoundedRectangle(cornerRadius: 50.0)
                        .matchedGeometryEffect(id: "circle", in: shapeTransition)
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.accentColor)
                        .animation(.easeIn)
                        .onTapGesture {
                            isExpanded.toggle()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isInfoShown = true
                            }
                        }
                }
            }
        }
    }
}
