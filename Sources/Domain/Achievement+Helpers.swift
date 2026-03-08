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

    var achievementDifficultyLabel: String {
        isRareAchievement ? "Hard" : "Easy"
    }

    var achievementCategoryIcon: String {
        category.iconName
    }

    var achievementSortKey: String {
        "\(category.displayName)-\(title)"
    }

    var achievementIsCommon: Bool {
        !isRareAchievement
    }

    var achievementAccessibilityLabel: String {
        "\(title), \(category.displayName) achievement"
    }

    var achievementEmojiLabel: String {
        "\(emoji) \(category.displayName)"
    }

    var achievementIsStreak: Bool {
        category == .streak
    }

    var achievementIsMastery: Bool {
        category == .mastery
    }

    var achievementRarityLabel: String {
        isRareAchievement ? "Rare" : "Common"
    }

    var achievementIdPrefix: String {
        String(id.split(separator: "_").first ?? Substring(id))
    }

    var achievementIsScore: Bool {
        category == .score
    }

    var achievementIsGames: Bool {
        category == .games
    }

    var achievementBadgeText: String {
        String(category.displayName.prefix(1))
    }

    var achievementFullLabel: String {
        "\(emoji) \(title) (\(pointValue) pts)"
    }

    var achievementIsDaily: Bool {
        id.hasPrefix("daily_")
    }

    var achievementTitleLength: Int {
        title.count
    }

    var achievementHasProgress: Bool {
        progress != nil
    }

    var achievementDescriptionLength: Int {
        description.count
    }

    var achievementIsHighValue: Bool {
        pointValue >= 25
    }

    var achievementIdSuffix: String {
        String(id.split(separator: "_").last ?? Substring(id))
    }

    var achievementRequiresMultipleGames: Bool {
        category == .games && id != "first_game"
    }

    var achievementShareMessage: String {
        "\(emoji) \(title) - \(description)"
    }

    var achievementNotificationTitle: String {
        "Achievement Unlocked!"
    }

    var achievementNotificationBody: String {
        "\(emoji) \(title): \(description)"
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

    var categorySortOrder: Int {
        switch self {
        case .streak: return 0
        case .score: return 1
        case .games: return 2
        case .mastery: return 3
        }
    }

    var categoryIsCompetitive: Bool {
        self == .streak || self == .score
    }

    var categoryBadgeColor: String {
        switch self {
        case .streak: return "red"
        case .score: return "yellow"
        case .games: return "green"
        case .mastery: return "indigo"
        }
    }

    var categoryAccessibilityLabel: String {
        "\(displayName) category"
    }

    var categoryIsEndgame: Bool {
        self == .mastery
    }

    var categoryDisplayOrder: Int {
        switch self {
        case .games: return 0
        case .streak: return 1
        case .score: return 2
        case .mastery: return 3
        }
    }
}
