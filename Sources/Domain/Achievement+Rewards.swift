import Foundation

extension Achievement {
    var achievementDisplayPriority: Int {
        var priority = achievementCategoryWeight * 10
        if isRareAchievement { priority += 50 }
        priority += pointValue
        return priority
    }

    var achievementCurrencyType: String {
        isRareAchievement ? "gems" : "coins"
    }

    var achievementTimerFormat: String {
        switch category {
        case .mastery: return "Estimated: hours"
        case .streak: return "Estimated: days"
        case .score: return "Estimated: minutes"
        case .games: return "Estimated: minutes"
        }
    }

    var achievementEffortLevel: String {
        switch category {
        case .mastery: return "high"
        case .streak: return "medium"
        case .score: return "medium"
        case .games: return "low"
        }
    }

    var achievementIsHidden: Bool {
        isRareAchievement && category == .mastery
    }

    var achievementRewardEmoji: String {
        isRareAchievement ? "💎" : "🪙"
    }

    var achievementCompletionRate: Double {
        0.0
    }

    var achievementNextMilestone: Int {
        switch category {
        case .mastery: return 25
        case .streak: return 10
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementRequiredStreak: Int {
        category == .streak ? 5 : 0
    }

    var achievementCardBackgroundImage: String {
        isRareAchievement ? "premium_bg" : "default_bg"
    }

    var achievementIsMultiplayer: Bool {
        false
    }

    var achievementNotificationSound: String {
        isRareAchievement ? "achievement_rare" : "achievement_common"
    }

    var achievementGradientAngle: Int {
        isRareAchievement ? 45 : 0
    }

    var achievementStatLabel: String {
        switch category {
        case .streak: return "Streak days"
        case .score: return "Score points"
        case .games: return "Games played"
        case .mastery: return "Operations mastered"
        }
    }

    var achievementCardHeight: Int {
        isRareAchievement ? 120 : 80
    }

    var achievementIsNew: Bool {
        false
    }

    var achievementProgressColor: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementInfoText: String {
        "Worth \(pointValue) points — \(category.displayName) achievement"
    }

    var achievementUnlockPercentile: Int {
        achievementRarityPercentage
    }

    var achievementFrameColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "silver"
        case .score: return "silver"
        case .games: return "bronze"
        }
    }

    var achievementIsProgressive: Bool {
        category == .mastery || category == .streak
    }

    var achievementStampColor: String {
        isRareAchievement ? "red" : "blue"
    }

    var achievementExpirationDays: Int {
        0
    }

    var achievementMinimumScore: Int {
        category == .score ? 50 : 0
    }

    var achievementBadgeOverlay: String {
        isRareAchievement ? "RARE" : ""
    }

    var achievementRankNumber: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 7
        case .score: return 5
        case .games: return 2
        }
    }

    var achievementBackdropName: String {
        "backdrop_\(category.displayName.lowercased().replacingOccurrences(of: " ", with: "_"))"
    }

    var achievementTooltipPosition: String {
        isRareAchievement ? "top" : "bottom"
    }

    var achievementRewardTier: String {
        isRareAchievement ? "platinum" : "standard"
    }

    var achievementIconColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "teal"
        }
    }

    var achievementIsEventBased: Bool {
        false
    }

    var achievementPopupDuration: Double {
        isRareAchievement ? 5.0 : 2.0
    }

    var achievementRequiredAccuracy: Int {
        switch category {
        case .mastery: return 90
        case .streak: return 0
        case .score: return 50
        case .games: return 0
        }
    }
}
