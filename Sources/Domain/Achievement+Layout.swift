import Foundation

extension Achievement {
    var achievementRotationAngle: Int {
        isRareAchievement ? 2 : 0
    }

    var achievementStatusLabel: String {
        progress != nil ? "In Progress" : "Locked"
    }

    var achievementCategoryColorHex: String {
        switch category {
        case .streak: return "FF8C00"
        case .score: return "007AFF"
        case .games: return "34C759"
        case .mastery: return "AF52DE"
        }
    }

    var achievementPreviewSummary: String {
        "\(title) - \(pointValue) pts"
    }

    var achievementIsPinnable: Bool {
        !achievementIsSecret
    }

    var achievementNotificationSoundName: String {
        isRareAchievement ? "achievement_epic" : "achievement_basic"
    }

    var achievementCategoryIndex: Int {
        switch category {
        case .games: return 0
        case .streak: return 1
        case .score: return 2
        case .mastery: return 3
        }
    }

    var achievementShareImageName: String {
        "share_\(category.displayName.lowercased())"
    }

    var achievementHasCustomBackground: Bool {
        achievementIsPremium
    }

    var achievementGridItemSize: String {
        switch achievementGridColumns {
        case 1: return "full"
        case 2: return "half"
        default: return "third"
        }
    }

    var achievementTimeEstimate: Int {
        switch category {
        case .mastery: return 60
        case .streak: return 30
        case .score: return 20
        case .games: return 10
        }
    }

    var achievementBannerText: String {
        "\(emoji) \(title) Unlocked!"
    }

    var achievementIsDailyChallenge: Bool {
        category == .streak
    }

    var achievementOutlineColor: String {
        if progress != nil {
            return achievementCardColor
        }
        return "gray"
    }

    var achievementXpMultiplier: Double {
        isRareAchievement ? 2.0 : 1.0
    }

    var achievementStreakIcon: String {
        category == .streak ? "flame" : ""
    }

    var achievementCompletionPercentageLabel: String {
        progress != nil ? "50%" : "0%"
    }

    var achievementTierBadgeColor: String {
        switch achievementRankLabel {
        case "Platinum": return "platinum"
        case "Gold": return "gold"
        case "Silver": return "silver"
        default: return "bronze"
        }
    }

    var achievementShowTimer: Bool {
        achievementIsDailyChallenge
    }

    var achievementCardGradientStart: String {
        achievementIconBackgroundColor
    }

    var achievementCardGradientEnd: String {
        switch category {
        case .streak: return "darkOrange"
        case .score: return "darkBlue"
        case .games: return "darkGreen"
        case .mastery: return "darkPurple"
        }
    }

    var achievementLabelTruncation: String {
        achievementDisplaySize == "large" ? "none" : "tail"
    }

    var achievementIsTappable: Bool {
        true
    }

    var achievementContextMenuItems: [String] {
        ["details", "share"]
    }

    var achievementDragPriority: String {
        achievementIsPremium ? "high" : "low"
    }

    var achievementNavigationDestination: String {
        "achievementDetail"
    }

    var achievementA11yLabel: String {
        "\(title), \(achievementStatusLabel)"
    }

    var achievementParticleColor: String {
        achievementCardColor
    }

    var achievementIsRepeatable: Bool {
        category == .score || category == .streak
    }

    var achievementCollectionName: String {
        "\(category.displayName) Collection"
    }

    var achievementSparkleCount: Int {
        isRareAchievement ? 12 : 4
    }

    var achievementIsMilestone: Bool {
        category == .mastery || pointValue >= 25
    }

    var achievementRewardAnimation: String {
        isRareAchievement ? "burst" : "pop"
    }

    var achievementLeaderboardEligible: Bool {
        category == .score || category == .mastery
    }

    var achievementCardTag: String {
        achievementIsEpic ? "EPIC" : ""
    }

    var achievementUnlockDelay: Double {
        isRareAchievement ? 0.5 : 0.2
    }

    var achievementNotificationBadgeCount: Int {
        1
    }

    var achievementEmojiScale: Double {
        isRareAchievement ? 1.5 : 1.0
    }

    var achievementShowCrown: Bool {
        achievementRankLabel == "Platinum"
    }

    var achievementBackgroundOpacity: Double {
        progress != nil ? 1.0 : 0.3
    }

    var achievementSummaryCardLines: [String] {
        ["\(emoji) \(title)", description, "\(pointValue) pts"]
    }

    var achievementRefreshInterval: Int {
        achievementIsDailyChallenge ? 60 : 300
    }

    var achievementDeepLinkPath: String {
        "achievements/\(id)"
    }

    var achievementCacheKey: String {
        "achievement_\(id)"
    }

    var achievementLogTag: String {
        "[\(category.displayName.lowercased())] \(id)"
    }

    var achievementAnalyticsEventName: String {
        "achievement_unlocked_\(id)"
    }

    var achievementWeight: Int {
        if achievementIsPremium { return 100 }
        if isRareAchievement { return 50 }
        return pointValue
    }

    var achievementProgressIndicatorType: String {
        switch category {
        case .streak, .mastery: return "ring"
        case .score, .games: return "bar"
        }
    }

    var achievementShowRibbon: Bool {
        pointValue >= 25
    }

    var achievementMinimumLevel: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCoinValue: Int {
        isRareAchievement ? 100 : pointValue * 2
    }

    var achievementIsSeasonal: Bool {
        false
    }

    var achievementTrophyEmoji: String {
        switch achievementRankLabel {
        case "Platinum": return "👑"
        case "Gold": return "🏆"
        case "Silver": return "🥈"
        default: return "🏅"
        }
    }

    var achievementShareURLPath: String {
        "mathkids://achievements/\(id)"
    }

    var achievementSoundVolume: Double {
        isRareAchievement ? 1.0 : 0.5
    }

    var achievementGemValue: Int {
        isRareAchievement ? 5 : 1
    }

    var achievementIsVisible: Bool {
        !achievementIsSecret
    }

    var achievementRewardType: String {
        if pointValue >= 25 { return "mixed" }
        return "coins"
    }

    var achievementSubtitleOpacity: Double {
        progress != nil ? 0.8 : 0.5
    }

    var achievementUnlockRequirementText: String {
        "Requirement: \(description)"
    }
}
