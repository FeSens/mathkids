import SwiftUI

struct CelebrationView: View {
    let intensity: GameViewModel.CelebrationIntensity
    var difficulty: DifficultyLevel = .easy
    @State private var particles: [Particle] = []

    private var particleCount: Int {
        switch intensity {
        case .normal: 20
        case .big: 40
        case .huge: 70
        }
    }

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(particles) { particle in
                    particle.shape
                        .font(.system(size: particle.size))
                        .position(particle.position)
                        .opacity(particle.opacity)
                }
            }
            .onAppear {
                createParticles(in: geo.size)
                animateParticles()
            }
        }
        .allowsHitTesting(false)
    }

    private var themedShapes: [String] {
        switch difficulty {
        case .easy:
            return ["⭐", "🌟", "✨", "🎉", "😄", "👍", "🌈"]
        case .medium:
            return ["🔥", "💫", "⚡", "🎊", "💪", "🏅", "✨"]
        case .hard:
            return ["🏆", "👑", "💎", "🎯", "🌟", "🔥", "⭐"]
        }
    }

    private func createParticles(in size: CGSize) {
        let shapes = themedShapes
        particles = (0..<particleCount).map { _ in
            Particle(
                shape: Text(shapes.randomElement()!),
                position: CGPoint(
                    x: CGFloat.random(in: 0...size.width),
                    y: size.height + 20
                ),
                targetPosition: CGPoint(
                    x: CGFloat.random(in: 0...size.width),
                    y: CGFloat.random(in: -50...size.height * 0.6)
                ),
                size: CGFloat.random(in: 16...36),
                opacity: 1.0
            )
        }
    }

    private func animateParticles() {
        withAnimation(.easeOut(duration: 0.6)) {
            for i in particles.indices {
                particles[i].position = particles[i].targetPosition
            }
        }

        withAnimation(.easeIn(duration: 0.4).delay(0.4)) {
            for i in particles.indices {
                particles[i].opacity = 0
            }
        }
    }
}

struct Particle: Identifiable {
    let id = UUID()
    let shape: Text
    var position: CGPoint
    var targetPosition: CGPoint
    var size: CGFloat
    var opacity: Double
}
