import SwiftUI

struct AnimatedGradientBackground: View {
    let colors: [Color]
    @Binding var animate: Bool
    @State private var phase: CGFloat = 0

    var body: some View {
        LinearGradient(
            colors: colors,
            startPoint: UnitPoint(x: 0.0 + phase * 0.3, y: 0.0 + phase * 0.2),
            endPoint: UnitPoint(x: 1.0 - phase * 0.3, y: 1.0 - phase * 0.2)
        )
        .onAppear {
            guard animate else { return }
            withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                phase = 1.0
            }
        }
        .onChange(of: animate) { _, newValue in
            if newValue {
                withAnimation(.easeInOut(duration: 5).repeatForever(autoreverses: true)) {
                    phase = 1.0
                }
            }
        }
    }
}
