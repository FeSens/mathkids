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
}
