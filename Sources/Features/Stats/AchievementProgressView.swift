import SwiftUI

struct AchievementProgressView: View {
    let achievements: [Achievement]
    let stats: PlayerStats

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Achievements")
                .font(.system(size: 18, weight: .bold, design: .rounded))

            ForEach(achievements) { achievement in
                let unlocked = achievement.isUnlocked(stats: stats)
                let progressInfo = achievement.progress?(stats)

                HStack(spacing: 12) {
                    Text(achievement.emoji)
                        .font(.title2)
                        .grayscale(unlocked ? 0 : 0.8)

                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(achievement.title)
                                .font(.system(size: 14, weight: .bold, design: .rounded))
                            Spacer()
                            if unlocked {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.green)
                                    .font(.system(size: 16))
                            } else if let info = progressInfo {
                                Text("\(info.current)/\(info.target)")
                                    .font(.system(size: 12, weight: .semibold, design: .rounded))
                                    .foregroundStyle(.secondary)
                            }
                        }

                        Text(achievement.description)
                            .font(.system(size: 12, design: .rounded))
                            .foregroundStyle(.secondary)

                        if !unlocked, let info = progressInfo, info.target > 0 {
                            GeometryReader { geo in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.gray.opacity(0.2))
                                    RoundedRectangle(cornerRadius: 3)
                                        .fill(Color.purple)
                                        .frame(width: geo.size.width * min(Double(info.current) / Double(info.target), 1.0))
                                }
                            }
                            .frame(height: 6)
                        }
                    }
                }
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(unlocked ? Color.green.opacity(0.08) : Color(.systemGray6))
                )
                .accessibilityIdentifier("achievement_\(achievement.id)")
            }
        }
        .accessibilityIdentifier("achievementProgress")
    }
}
