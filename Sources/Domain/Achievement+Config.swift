import Foundation

extension Achievement {
    var achievementCompactDescription: String {
        "\(emoji) \(title)"
    }

    var achievementNotificationIcon: String {
        switch category {
        case .mastery: return "trophy.fill"
        case .streak: return "flame.fill"
        case .score: return "star.fill"
        case .games: return "gamecontroller.fill"
        }
    }

    var achievementShowConfetti: Bool {
        isRareAchievement
    }

    var achievementDetailURL: String {
        "/achievements/\(id)"
    }

    var achievementEarnedLabel: String {
        "Not Earned"
    }

    var achievementUnlockDifficulty: Double {
        switch category {
        case .mastery: return 0.9
        case .streak: return 0.6
        case .score: return 0.4
        case .games: return 0.1
        }
    }

    var achievementListIcon: String {
        switch category {
        case .mastery: return "crown.fill"
        case .streak: return "bolt.fill"
        case .score: return "chart.bar.fill"
        case .games: return "play.fill"
        }
    }

    var achievementStreakRequired: Bool {
        category == .streak
    }

    var achievementCardOpacity: Double {
        0.6
    }

    var achievementRewardCoinsLabel: String {
        "\(achievementCoinValue) coins"
    }
}
