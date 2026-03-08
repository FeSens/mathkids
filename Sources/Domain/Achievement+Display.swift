import Foundation

extension Achievement {
    var achievementIsLocked: Bool {
        progress == nil
    }

    var achievementCardColor: String {
        switch category {
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        case .mastery: return "purple"
        }
    }

    var achievementRewardText: String {
        "Earn \(pointValue) points"
    }

    var achievementIsEpic: Bool {
        isRareAchievement && pointValue >= 25
    }

    var achievementTitleWithEmoji: String {
        "\(emoji) \(title)"
    }

    var achievementDifficultyStars: Int {
        switch category {
        case .mastery: return 3
        case .streak: return 2
        case .score: return 2
        case .games: return 1
        }
    }

    var achievementSummaryLine: String {
        "\(emoji) \(title) - \(description)"
    }

    var achievementCompletionEmoji: String {
        progress != nil ? "✅" : "🔒"
    }

    var achievementCategoryLabel: String {
        "\(category.emoji) \(category.displayName)"
    }

    var achievementIsEndgameContent: Bool {
        category == .mastery
    }

    var achievementRarityColor: String {
        isRareAchievement ? "purple" : "blue"
    }

    var achievementIsStreakRelated: Bool {
        category == .streak
    }

    var achievementIconSystemName: String {
        switch category {
        case .streak: return "flame.fill"
        case .score: return "trophy.fill"
        case .games: return "gamecontroller.fill"
        case .mastery: return "graduationcap.fill"
        }
    }

    var achievementShareText: String {
        "I earned the \(emoji) \(title) achievement in MathKids!"
    }

    var achievementNotificationMessage: String {
        "Achievement Unlocked: \(emoji) \(title)!"
    }
}
