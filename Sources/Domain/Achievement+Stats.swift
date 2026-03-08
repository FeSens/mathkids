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
}
