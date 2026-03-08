import Foundation

extension Achievement {
    var achievementCardWingStyle: String {
        isRareAchievement ? "spread" : "folded"
    }

    var achievementIsCompetitiveBased: Bool {
        category == .score
    }

    var achievementCardFlameEffect: Bool {
        isRareAchievement
    }

    var achievementDailyTarget: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 1
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementCardBannerColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "red"
        case .score: return "blue"
        case .games: return "green"
        }
    }
}
