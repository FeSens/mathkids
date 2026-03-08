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
}
