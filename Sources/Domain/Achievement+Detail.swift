import Foundation

extension Achievement {
    var achievementDetailDescription: String {
        "\(description) — \(category.displayName) achievement"
    }

    var achievementProgressTarget: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementSuggestionText: String {
        switch category {
        case .mastery: return "Practice more to unlock!"
        case .streak: return "Keep coming back daily!"
        case .score: return "Aim higher each game!"
        case .games: return "Play more games to unlock!"
        }
    }

    var achievementCardTitleColor: String {
        isRareAchievement ? "white" : "black"
    }

    var achievementIsOffline: Bool {
        true
    }

    var achievementLevelRequirement: Int {
        switch category {
        case .mastery: return 8
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardOverlayOpacity: Double {
        isRareAchievement ? 0.3 : 0
    }

    var achievementShowInFeed: Bool {
        true
    }

    var achievementRequiredOperations: Int {
        category == .mastery ? 100 : 0
    }

    var achievementThemeColor: String {
        switch category {
        case .mastery: return "indigo"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementCollectionSize: Int {
        switch category {
        case .mastery: return 8
        case .streak: return 6
        case .score: return 4
        case .games: return 3
        }
    }

    var achievementIsUrgent: Bool {
        category == .streak
    }

    var achievementStreakBonusPoints: Int {
        category == .streak ? 10 : 0
    }

    var achievementCardGradientColors: String {
        switch category {
        case .mastery: return "purple-indigo"
        case .streak: return "orange-red"
        case .score: return "blue-cyan"
        case .games: return "green-teal"
        }
    }

    var achievementMaxDisplayCount: Int {
        99
    }

    var achievementPrioritySortKey: String {
        "\(achievementCategoryWeight)-\(id)"
    }

    var achievementBadgeAnimated: Bool {
        isRareAchievement
    }

    var achievementUnlockCountTag: String {
        "1x Unlocked"
    }

    var achievementCardRatio: Double {
        switch category {
        case .mastery: return 1.5
        case .streak: return 1.4
        case .score: return 1.3
        case .games: return 1.2
        }
    }

    var achievementIsMilestoneType: Bool {
        category == .mastery || category == .streak
    }

    var achievementAlertPriority: String {
        switch category {
        case .mastery: return "high"
        case .streak: return "medium"
        case .score: return "medium"
        case .games: return "low"
        }
    }

    var achievementCardFooterText: String {
        "\(category.displayName) — \(pointValue) pts"
    }

    var achievementUnlockNote: String {
        "You unlocked \(title)!"
    }

    var achievementCardShadowRadius: Double {
        isRareAchievement ? 10 : 4
    }

    var achievementIsCategoryTop: Bool {
        category == .mastery
    }

    var achievementBadgeScale: Double {
        isRareAchievement ? 1.2 : 1.0
    }

    var achievementCategorySortOrder: Int {
        switch category {
        case .mastery: return 1
        case .streak: return 2
        case .score: return 3
        case .games: return 4
        }
    }

    var achievementDisplaySubtitle: String {
        "\(category.displayName) achievement"
    }

    var achievementCardLineHeight: Double {
        switch category {
        case .mastery: return 24
        case .streak: return 22
        case .score: return 20
        case .games: return 18
        }
    }

    var achievementIsReearnable: Bool {
        category == .streak || category == .games
    }

    var achievementRewardStars: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 3
        case .score: return 2
        case .games: return 1
        }
    }

    var achievementCardBorderWidth: Double {
        isRareAchievement ? 3 : 1
    }

    var achievementEarnedDateFormat: String {
        "MM/dd/yyyy"
    }

    var achievementCardFontSize: Double {
        switch category {
        case .mastery: return 18
        case .streak: return 16
        case .score: return 15
        case .games: return 14
        }
    }

    var achievementTierLabel: String {
        switch category {
        case .mastery: return "Platinum"
        case .streak: return "Gold"
        case .score: return "Silver"
        case .games: return "Bronze"
        }
    }

    var achievementIsFeaturedItem: Bool {
        isRareAchievement
    }

    var achievementCardEmojiSize: Double {
        isRareAchievement ? 48 : 32
    }
}
