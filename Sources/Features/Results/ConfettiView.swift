import SwiftUI

struct ConfettiPiece: Identifiable {
    let id = UUID()
    var x: CGFloat
    var y: CGFloat
    let color: Color
    let size: CGFloat
    let rotation: Double
    let speed: Double
}

struct ConfettiView: View {
    @State private var pieces: [ConfettiPiece] = []
    @State private var opacity: Double = 1.0

    var body: some View {
        GeometryReader { geo in
            ZStack {
                ForEach(pieces) { piece in
                    RoundedRectangle(cornerRadius: 2)
                        .fill(piece.color)
                        .frame(width: piece.size, height: piece.size * 0.6)
                        .rotationEffect(.degrees(piece.rotation))
                        .position(x: piece.x, y: piece.y)
                }
            }
            .opacity(opacity)
            .onAppear {
                generatePieces(in: geo.size)
                animatePieces(in: geo.size)
                withAnimation(.easeIn(duration: 2.5).delay(0.5)) {
                    opacity = 0
                }
            }
        }
        .allowsHitTesting(false)
        .accessibilityIdentifier("confettiView")
    }

    private static let colors: [Color] = [
        .red, .blue, .green, .yellow, .purple, .orange, .pink, .cyan
    ]

    private func generatePieces(in size: CGSize) {
        pieces = (0..<40).map { _ in
            ConfettiPiece(
                x: CGFloat.random(in: 0...size.width),
                y: -20,
                color: Self.colors.randomElement()!,
                size: CGFloat.random(in: 6...14),
                rotation: Double.random(in: 0...360),
                speed: Double.random(in: 1...3)
            )
        }
    }

    private func animatePieces(in size: CGSize) {
        for i in pieces.indices {
            let delay = Double.random(in: 0...0.3)
            withAnimation(.easeIn(duration: pieces[i].speed).delay(delay)) {
                pieces[i].y = size.height + 20
                pieces[i].x += CGFloat.random(in: -60...60)
            }
        }
    }
}
