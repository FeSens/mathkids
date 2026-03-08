import SwiftUI

struct OnboardingView: View {
    var onDismiss: () -> Void

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Text("🧮")
                .font(.system(size: 80))

            Text("Welcome to MathKids!")
                .font(.system(size: 32, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)
                .accessibilityIdentifier("onboardingTitle")

            VStack(alignment: .leading, spacing: 16) {
                OnboardingRow(icon: "brain.head.profile", text: "Practice mental math with fun challenges")
                OnboardingRow(icon: "flame.fill", text: "Build streaks and earn bonus points")
                OnboardingRow(icon: "chart.line.uptrend.xyaxis", text: "Track your progress and level up")
                OnboardingRow(icon: "star.fill", text: "Unlock achievements as you improve")
            }
            .padding(.horizontal, 32)

            Spacer()

            Button {
                onDismiss()
            } label: {
                Text("Let's Go!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
            }
            .padding(.horizontal, 32)
            .accessibilityIdentifier("onboardingDismiss")

            Spacer()
        }
        .accessibilityIdentifier("onboardingView")
    }
}

struct OnboardingRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(.purple)
                .frame(width: 32)
            Text(text)
                .font(.system(size: 16, design: .rounded))
        }
    }
}
