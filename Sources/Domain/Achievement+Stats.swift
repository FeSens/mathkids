import Foundation

extension Achievement {
    var achievementStatsSummary: String {
        "\(category.displayName): \(pointValue) pts"
    }

    var achievementCardRadius: Double {
        isRareAchievement ? 16 : 8
    }

    var achievementIsDailyQuest: Bool {
        category == .streak
    }

    var achievementBadgeTag: String {
        "\(emoji) \(title)"
    }

    var achievementEffortDescription: String {
        switch category {
        case .mastery: return "Requires significant practice"
        case .streak: return "Requires daily consistency"
        case .score: return "Requires high performance"
        case .games: return "Requires playing games"
        }
    }

    var achievementDifficultyRating: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 3
        case .score: return 2
        case .games: return 1
        }
    }

    var achievementGradientStartColor: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementIsFinishable: Bool {
        true
    }

    var achievementCardTitleFont: String {
        isRareAchievement ? "bold" : "regular"
    }

    var achievementPointsSummary: String {
        "\(pointValue) points"
    }

    var achievementUnlockThreshold: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementCardSubtitleStyle: String {
        isRareAchievement ? "italic" : "regular"
    }

    var achievementIsPremiumTier: Bool {
        category == .mastery
    }

    var achievementBarFillColor: String {
        switch category {
        case .mastery: return "indigo"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementCardTitleAlignment: String {
        isRareAchievement ? "center" : "leading"
    }

    var achievementCardBackgroundStyle: String {
        isRareAchievement ? "gradient" : "solid"
    }

    var achievementMinPlayerLevel: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardBadgePosition: String {
        isRareAchievement ? "topRight" : "topLeft"
    }

    var achievementIsMonitorable: Bool {
        category == .mastery || category == .streak
    }

    var achievementRewardDescriptionText: String {
        "Earn \(pointValue) points"
    }
}
