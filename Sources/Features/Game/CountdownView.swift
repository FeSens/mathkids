import SwiftUI

struct CountdownView: View {
    let onComplete: () -> Void
    @State private var currentNumber = 3
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 1.0
    @State private var isFinished = false

    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .ignoresSafeArea()

            if isFinished {
                Text("GO!")
                    .font(.system(size: 96, weight: .bold, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .scaleEffect(scale)
                    .opacity(opacity)
            } else {
                Text("\(currentNumber)")
                    .font(.system(size: 120, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .scaleEffect(scale)
                    .opacity(opacity)
            }
        }
        .onAppear {
            animateCountdown()
        }
        .accessibilityIdentifier("countdownOverlay")
    }

    private func animateCountdown() {
        animateNumber {
            currentNumber = 2
            animateNumber {
                currentNumber = 1
                animateNumber {
                    isFinished = true
                    animateNumber {
                        onComplete()
                    }
                }
            }
        }
    }

    private func animateNumber(completion: @escaping () -> Void) {
        scale = 0.3
        opacity = 1.0

        withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
            scale = 1.2
        }

        withAnimation(.easeOut(duration: 0.2).delay(0.4)) {
            scale = 1.0
        }

        withAnimation(.easeIn(duration: 0.2).delay(0.6)) {
            opacity = 0.0
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            completion()
        }
    }
}
