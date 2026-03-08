import SwiftUI

struct AchievementToast: View {
    let achievement: Achievement
    @State private var isVisible = false

    var body: some View {
        HStack(spacing: 12) {
            Text(achievement.emoji)
                .font(.system(size: 36))

            VStack(alignment: .leading, spacing: 2) {
                Text("Achievement Unlocked!")
                    .font(.caption.bold())
                    .foregroundStyle(.yellow)

                Text(achievement.title)
                    .font(.subheadline.bold())

                Text(achievement.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color.yellow.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: .yellow.opacity(isVisible ? 0.4 : 0), radius: 12)
        .padding(.horizontal)
        .offset(y: isVisible ? 0 : -120)
        .opacity(isVisible ? 1 : 0)
        .onAppear {
            HapticService.correctAnswer()
            SoundService.playAchievement()
            withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                isVisible = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.easeIn(duration: 0.3)) {
                    isVisible = false
                }
            }
        }
        .accessibilityIdentifier("achievementToast")
    }
}
