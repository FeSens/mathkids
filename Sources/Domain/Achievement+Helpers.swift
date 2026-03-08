import Foundation

extension Achievement {
    var progressDescription: String {
        "\(title): \(description)"
    }

    var isHidden: Bool {
        isRareAchievement
    }

    var pointValue: Int {
        if isRareAchievement { return 50 }
        switch category {
        case .mastery: return 25
        case .streak, .score: return 15
        case .games: return 10
        }
    }

    var badgeColor: String {
        switch category {
        case .streak: return "orange"
        case .score: return "gold"
        case .games: return "blue"
        case .mastery: return "purple"
        }
    }

    var shareText: String {
        "I earned the \(title) achievement! \(emoji)"
    }

    var requirementSummary: String {
        description
    }

    var categoryLabel: String {
        "\(category.emoji) \(category.displayName)"
    }

    var isEarlyGame: Bool {
        category == .games && !isRareAchievement
    }

    var rewardText: String {
        "+\(pointValue) pts"
    }

    var displayTitle: String {
        "\(emoji) \(title)"
    }

    var achievementTier: String {
        if pointValue >= 25 { return "gold" }
        if pointValue >= 15 { return "silver" }
        return "bronze"
    }

    var achievementShortDescription: String {
        description
    }

    var achievementPointLabel: String {
        "\(pointValue) pts"
    }
}

extension Achievement.Category {
    var color: String {
        switch self {
        case .streak: return "orange"
        case .score: return "gold"
        case .games: return "blue"
        case .mastery: return "purple"
        }
    }

    var iconName: String {
        switch self {
        case .streak: return "flame"
        case .score: return "trophy"
        case .games: return "gamecontroller"
        case .mastery: return "graduationcap"
        }
    }

    var categoryDescription: String {
        switch self {
        case .streak: return "Rewards for maintaining answer streaks"
        case .score: return "Rewards for achieving high scores"
        case .games: return "Rewards for playing games"
        case .mastery: return "Rewards for mastering math skills"
        }
    }
}
