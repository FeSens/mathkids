import SwiftUI

struct CharacterView: View {
    let mood: GameViewModel.CharacterMood

    var body: some View {
        Text(emoji)
            .font(.system(size: 56))
            .scaleEffect(scale)
            .animation(.spring(duration: 0.4, bounce: 0.5), value: mood)
            .accessibilityIdentifier("characterFace")
    }

    private var emoji: String {
        switch mood {
        case .neutral: "🤔"
        case .happy: "😄"
        case .excited: "🤩"
        case .sad: "😢"
        }
    }

    private var scale: CGFloat {
        switch mood {
        case .neutral: 1.0
        case .happy: 1.1
        case .excited: 1.3
        case .sad: 0.9
        }
    }
}
