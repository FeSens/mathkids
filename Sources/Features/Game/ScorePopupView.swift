import SwiftUI

struct ScorePopup: Identifiable {
    let id = UUID()
    let text: String
    let color: Color
    var offset: CGFloat = 0
    var horizontalOffset: CGFloat = CGFloat.random(in: -30...30)
    var opacity: Double = 1.0
}

struct ScorePopupView: View {
    let popup: ScorePopup

    var body: some View {
        Text(popup.text)
            .font(.system(size: 28, weight: .bold, design: .rounded))
            .foregroundStyle(popup.color)
            .offset(x: popup.horizontalOffset, y: popup.offset)
            .opacity(popup.opacity)
    }
}
