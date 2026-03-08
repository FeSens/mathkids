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
}
