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
}
