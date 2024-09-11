import SwiftUI

struct FirstScreen: View {
    @Binding var selectedTab: Int
    @Binding var selectedItem: Int?

    var body: some View {
        NavigationView {
            VStack {
                CustomButton(title: "to the ... item!") {
                    selectedItem = 1
                    selectedTab = 1
                }
                CaptionText("pick item", .plum)
            }
        }
    }
}
