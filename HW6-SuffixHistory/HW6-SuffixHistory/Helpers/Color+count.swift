import SwiftUI

extension Color {
    
    static func rarity(for count: Int) -> Color {
        if count == 2 { return .rare }
        if count <= 6  { return .uncommon }
        return .common
    }
    
    static func speed(for value: TimeInterval, minTime: TimeInterval, maxTime: TimeInterval) -> Color {
        let startColor: UIColor = .green
        let endColor: UIColor = .red
        let factor: CGFloat = CGFloat((value - minTime)/(maxTime - minTime))
        var startRed: CGFloat = 0, startGreen: CGFloat = 0, startBlue: CGFloat = 0, startAlpha: CGFloat = 0
        var endRed: CGFloat = 0, endGreen: CGFloat = 0, endBlue: CGFloat = 0, endAlpha: CGFloat = 0
        
        startColor.getRed(&startRed, green: &startGreen, blue: &startBlue, alpha: &startAlpha)
        endColor.getRed(&endRed, green: &endGreen, blue: &endBlue, alpha: &endAlpha)
        
        let interpolatedRed = startRed + factor * (endRed - startRed)
        let interpolatedGreen = startGreen + factor * (endGreen - startGreen)
        let interpolatedBlue = startBlue + factor * (endBlue - startBlue)
        
        return Color(red: interpolatedRed, green: interpolatedGreen, blue: interpolatedBlue)
    }
}
