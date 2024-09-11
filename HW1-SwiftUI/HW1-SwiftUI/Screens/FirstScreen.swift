import SwiftUI

struct FirstScreen: View {
    @Binding var selectedTab: Int
    @Binding var selectedItem: Int?

    @State private var selectedSegmentIndex = 0
    let segments = (0..<4).map { ($0 + 1).formatted }
    
    var body: some View {
        NavigationView {
            VStack {
                SegmentedControl(
                    selectedSegmentIndex: $selectedSegmentIndex,
                    segments: segments
                )
                .padding(30)
                
                CaptionText("pick an item!", .plum)
                
                CustomButton(title: "to the ... item!") {
                    selectedItem = selectedSegmentIndex
                    selectedTab = 1
                }
            }
        }.navigationViewStyle(.stack)
    }
}
