import SwiftUI

struct BounceButtonStyle: ButtonStyle {
    var rippleColor: Color = .blue

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .brightness(configuration.isPressed ? 0.1 : 0)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .fill(rippleColor.opacity(configuration.isPressed ? 0.15 : 0))
                    .scaleEffect(configuration.isPressed ? 1.0 : 0.8)
            )
            .animation(.spring(duration: 0.2, bounce: 0.4), value: configuration.isPressed)
    }
}

struct MiniParticleBurst: View {
    let color: Color
    @State private var particles: [(id: Int, x: CGFloat, y: CGFloat, opacity: Double)] = []

    var body: some View {
        ZStack {
            ForEach(particles, id: \.id) { p in
                Circle()
                    .fill(color)
                    .frame(width: 6, height: 6)
                    .offset(x: p.x, y: p.y)
                    .opacity(p.opacity)
            }
        }
        .onAppear {
            for i in 0..<8 {
                let angle = Double(i) * .pi / 4
                particles.append((id: i, x: 0, y: 0, opacity: 1.0))
                withAnimation(.easeOut(duration: 0.5)) {
                    particles[i].x = CGFloat(cos(angle) * 40)
                    particles[i].y = CGFloat(sin(angle) * 40)
                    particles[i].opacity = 0
                }
            }
        }
        .accessibilityIdentifier("particleBurst")
    }
}

struct PauseOverlay: View {
    let onResume: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text("PAUSED")
                .font(.system(size: 36, weight: .bold, design: .rounded))
                .foregroundStyle(.secondary)
            Button(action: onResume) {
                Text("Resume")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.blue)
            }
            .accessibilityIdentifier("resumeButton")
        }
        .frame(maxWidth: .infinity, maxHeight: 200)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .accessibilityIdentifier("pausedLabel")
    }
}

struct NumberButton: View {
    let label: String
    var color: Color = .blue
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(color.opacity(0.15))
                )
        }
        .buttonStyle(BounceButtonStyle())
    }
}
