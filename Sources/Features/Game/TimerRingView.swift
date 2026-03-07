import SwiftUI

struct TimerRingView: View {
    let progress: Double
    let timeRemaining: Int
    let isPulsing: Bool

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 4)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AngularGradient(
                        colors: ringColors,
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360 * progress)
                    ),
                    style: StrokeStyle(lineWidth: 4, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: progress)

            Text("\(timeRemaining)")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(timeRemaining <= 10 ? .red : .primary)
        }
        .scaleEffect(isPulsing ? 1.1 : 1.0)
        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: isPulsing)
    }

    private var ringColors: [Color] {
        if progress > 0.5 {
            return [.green, .blue]
        } else if progress > 0.25 {
            return [.yellow, .orange]
        } else {
            return [.orange, .red]
        }
    }
}
