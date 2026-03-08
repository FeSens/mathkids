import SwiftUI

struct CharacterView: View {
    let mood: GameViewModel.CharacterMood
    @State private var bounce: CGFloat = 0

    var body: some View {
        Text(emoji)
            .font(.system(size: 56))
            .scaleEffect(scale)
            .offset(y: bounce)
            .animation(.spring(duration: 0.4, bounce: 0.5), value: mood)
            .onChange(of: mood) { _, newMood in
                if newMood == .happy || newMood == .excited {
                    withAnimation(.spring(duration: 0.3, bounce: 0.6)) { bounce = -12 }
                    withAnimation(.spring(duration: 0.3).delay(0.15)) { bounce = 0 }
                }
            }
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
