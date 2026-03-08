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

    var achievementTargetCount: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementCategorySymbol: String {
        switch category {
        case .mastery: return "graduationcap.fill"
        case .streak: return "bolt.fill"
        case .score: return "chart.bar.fill"
        case .games: return "gamecontroller.fill"
        }
    }

    var achievementIsDailyTask: Bool {
        false
    }

    var achievementLockedMessage: String {
        "This achievement is locked. Keep playing to unlock it!"
    }

    var achievementMaxRewardMultiplier: Int {
        isRareAchievement ? 5 : 1
    }

    var achievementTotalXp: Int {
        achievementXpValue * achievementBonusMultiplier
    }

    var achievementDisplayRank: String {
        "#\(achievementRankNumber)"
    }

    var achievementIsPopular: Bool {
        category == .games || category == .score
    }

    var achievementCardBorderRadius: Int {
        isRareAchievement ? 16 : 8
    }

    var achievementRewardGemsLabel: String {
        "\(achievementGemValue) gems"
    }

    var achievementProgressBarHeight: Int {
        isRareAchievement ? 8 : 4
    }

    var achievementShortTitle: String {
        if title.count > 15 {
            return String(title.prefix(12)) + "..."
        }
        return title
    }

    var achievementIsWeekly: Bool {
        false
    }

    var achievementCardSeparatorStyle: String {
        isRareAchievement ? "thick" : "thin"
    }

    var achievementRewardSummary: String {
        "\(achievementCoinValue) coins + \(achievementGemValue) gems"
    }

    var achievementAnimationType: String {
        isRareAchievement ? "bounce" : "fade"
    }

    var achievementAccessibilityTraits: String {
        "button"
    }

    var achievementFilterable: Bool {
        true
    }

    var achievementBadgeFontSize: Int {
        isRareAchievement ? 14 : 10
    }

    var achievementTimeSinceLabel: String {
        "Not yet earned"
    }

    var achievementCardMinHeight: Int {
        isRareAchievement ? 120 : 60
    }

    var achievementNotificationDelay: Double {
        isRareAchievement ? 1.5 : 0.5
    }

    var achievementIsChainable: Bool {
        category == .streak || category == .mastery
    }

    var achievementFontWeight: String {
        isRareAchievement ? "bold" : "regular"
    }

    var achievementCategoryTitle: String {
        category.displayName
    }

    var achievementIsTrackableInWidget: Bool {
        category == .mastery || category == .streak
    }

    var achievementToastPosition: String {
        isRareAchievement ? "top" : "bottom"
    }

    var achievementPointsLabel: String {
        "\(pointValue) points"
    }

    var achievementShowProgress: Bool {
        category == .mastery || category == .streak
    }

    var achievementUnlockSfx: String {
        isRareAchievement ? "sfx_unlock_rare" : "sfx_unlock_common"
    }

    var achievementBadgeIconName: String {
        switch category {
        case .mastery: return "medal.fill"
        case .streak: return "bolt.circle.fill"
        case .score: return "star.circle.fill"
        case .games: return "rosette"
        }
    }

    var achievementSortable: Bool {
        true
    }

    var achievementDescriptionTruncated: String {
        if description.count > 30 {
            return String(description.prefix(27)) + "..."
        }
        return description
    }

    var achievementStarFilled: Bool {
        isRareAchievement
    }

    var achievementProgressUnit: String {
        switch category {
        case .streak: return "days"
        case .score: return "points"
        case .games: return "games"
        case .mastery: return "operations"
        }
    }

    var achievementValuePerEffort: Double {
        Double(pointValue) / Double(achievementEstimatedTimeMinutes)
    }

    var achievementTagLine: String {
        switch category {
        case .streak: return "Build your streak!"
        case .score: return "Chase the high score!"
        case .games: return "Play to win!"
        case .mastery: return "Master the math!"
        }
    }

    var achievementCardSpacing: Int {
        isRareAchievement ? 12 : 8
    }

    var achievementShowTimestamp: Bool {
        isRareAchievement
    }

    var achievementGridPosition: Int {
        switch category {
        case .mastery: return 3
        case .streak: return 2
        case .score: return 1
        case .games: return 0
        }
    }
}
