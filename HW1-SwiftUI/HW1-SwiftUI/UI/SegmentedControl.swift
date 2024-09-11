import SwiftUI
import UIKit

struct SegmentedControl: UIViewRepresentable {
    @Binding var selectedSegmentIndex: Int
    var segments: [String]

    func makeUIView(context: Context) -> UISegmentedControl {
        let segmentedControl = UISegmentedControl(items: segments)
        segmentedControl.selectedSegmentIndex = selectedSegmentIndex
        segmentedControl.addTarget(context.coordinator, action: #selector(Coordinator.segmentChanged(_:)), for: .valueChanged)
        
        segmentedControl.selectedSegmentTintColor = .peach
        segmentedControl.layer.cornerRadius = 12
        
        return segmentedControl
    }

    func updateUIView(_ uiView: UISegmentedControl, context: Context) {
        uiView.selectedSegmentIndex = selectedSegmentIndex
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: SegmentedControl

        init(_ parent: SegmentedControl) {
            self.parent = parent
        }

        @objc func segmentChanged(_ sender: UISegmentedControl) {
            parent.selectedSegmentIndex = sender.selectedSegmentIndex
        }
    }
}
