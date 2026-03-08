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

    var achievementBorderColor: String {
        isRareAchievement ? "gold" : "silver"
    }

    var achievementIsGameRelated: Bool {
        category == .games
    }

    var achievementIsScoreRelated: Bool {
        category == .score
    }

    var achievementIsMasteryRelated: Bool {
        category == .mastery
    }

    var achievementAnimationName: String {
        isRareAchievement ? "sparkle" : "bounce"
    }

    var achievementProgressDisplayText: String {
        if progress != nil {
            return "In Progress"
        }
        return "Locked"
    }

    var achievementSortPriority: Int {
        switch category {
        case .mastery: return 4
        case .streak: return 2
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementBadgeStyle: String {
        isRareAchievement ? "epic" : "standard"
    }

    var achievementIsNewPlayerFriendly: Bool {
        category == .games
    }

    var achievementCelebrationType: String {
        pointValue >= 25 ? "fireworks" : "confetti"
    }

    var achievementDescriptionWithPoints: String {
        "\(description) - \(pointValue) points"
    }

    var achievementIsHighValueReward: Bool {
        pointValue >= 20
    }

    var achievementDisplaySize: String {
        if pointValue >= 25 {
            return "large"
        } else if pointValue >= 15 {
            return "medium"
        }
        return "small"
    }

    var achievementTooltipText: String {
        "\(emoji) \(title): \(description)"
    }

    var achievementUnlockSound: String {
        isRareAchievement ? "fanfare" : "chime"
    }

    var achievementFilterTag: String {
        switch category {
        case .streak: return "streak"
        case .score: return "score"
        case .games: return "games"
        case .mastery: return "mastery"
        }
    }

    var achievementIsStarter: Bool {
        pointValue <= 10
    }

    var achievementBackgroundGradient: String {
        switch category {
        case .streak: return "fireGradient"
        case .score: return "blueGradient"
        case .games: return "greenGradient"
        case .mastery: return "royalGradient"
        }
    }

    var achievementRankLabel: String {
        if pointValue >= 50 { return "Platinum" }
        if pointValue >= 25 { return "Gold" }
        if pointValue >= 15 { return "Silver" }
        return "Bronze"
    }

    var achievementIsCategoryLeader: Bool {
        category == .mastery || category == .score
    }

    var achievementGridColumns: Int {
        switch achievementDisplaySize {
        case "large": return 1
        case "medium": return 2
        default: return 3
        }
    }

    var achievementAccessibilityHint: String {
        let status = progress != nil ? "in progress" : "locked"
        return "\(category.displayName) achievement, \(status)"
    }

    var achievementSectionHeader: String {
        "\(category.emoji) \(category.displayName) Achievements"
    }

    var achievementIsPremium: Bool {
        isRareAchievement && pointValue >= 50
    }

    var achievementFlavorText: String {
        switch category {
        case .streak: return "Keep the fire burning!"
        case .score: return "Aim for the top score!"
        case .games: return "Play more to unlock!"
        case .mastery: return "True mastery awaits!"
        }
    }

    var achievementCollectionGroup: String {
        switch category {
        case .streak, .mastery: return "Skill"
        case .score: return "Competition"
        case .games: return "Activity"
        }
    }

    var achievementRarityStars: Int {
        if isRareAchievement { return 5 }
        switch category {
        case .mastery: return 3
        case .streak, .score: return 2
        case .games: return 1
        }
    }

    var achievementCardSubtitle: String {
        "\(category.displayName) - \(achievementRankLabel)"
    }

    var achievementIsCompletable: Bool {
        progress != nil
    }

    var achievementTrophyType: String {
        switch achievementRankLabel {
        case "Platinum": return "💎"
        case "Gold": return "🥇"
        case "Silver": return "🥈"
        default: return "🥉"
        }
    }

    var achievementSearchKeywords: [String] {
        [title, category.displayName, description]
    }

    var achievementDisplayOrder: String {
        "\(achievementSortPriority)-\(title)"
    }

    var achievementIsFeatured: Bool {
        achievementIsEpic
    }

    var achievementUnlockMessage: String {
        "You unlocked \(emoji) \(title)! +\(pointValue) points"
    }

    var achievementCardFooter: String {
        "\(pointValue) pts - \(achievementRankLabel)"
    }
}
