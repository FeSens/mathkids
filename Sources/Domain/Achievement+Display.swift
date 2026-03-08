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
}
