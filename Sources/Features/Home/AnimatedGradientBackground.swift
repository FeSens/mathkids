import SwiftUI

struct AnimatedGradientBackground: View {
    let colors: [Color]
    @Binding var animate: Bool

    var body: some View {
        LinearGradient(
            colors: animate ? colors : colors.reversed(),
            startPoint: animate ? .topLeading : .bottomTrailing,
            endPoint: animate ? .bottomTrailing : .topLeading
        )
        .animation(.easeInOut(duration: 4).repeatForever(autoreverses: true), value: animate)
    }
}
