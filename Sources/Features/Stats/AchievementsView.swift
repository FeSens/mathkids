import SwiftUI

struct AchievementsView: View {
    let stats: PlayerStats

    private var unlockedCount: Int {
        Achievement.all.filter { $0.isUnlocked(stats: stats) }.count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Achievements")
                    .font(.headline)

                Spacer()

                Text("\(unlockedCount)/\(Achievement.all.count)")
                    .font(.subheadline.bold())
                    .foregroundStyle(.secondary)
                    .accessibilityIdentifier("achievementCount")
            }

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                ForEach(Achievement.all) { achievement in
                    AchievementBadge(
                        achievement: achievement,
                        isUnlocked: achievement.isUnlocked(stats: stats)
                    )
                }
            }
        }
    }
}

struct AchievementBadge: View {
    let achievement: Achievement
    let isUnlocked: Bool

    var body: some View {
        VStack(spacing: 6) {
            Text(isUnlocked ? achievement.emoji : "🔒")
                .font(.system(size: 32))
                .opacity(isUnlocked ? 1.0 : 0.4)

            Text(achievement.title)
                .font(.caption2.bold())
                .multilineTextAlignment(.center)
                .foregroundStyle(isUnlocked ? .primary : .secondary)
                .lineLimit(2)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(isUnlocked ? Color.yellow.opacity(0.15) : Color.gray.opacity(0.08))
        )
        .accessibilityIdentifier("badge_\(achievement.id)")
    }
}
