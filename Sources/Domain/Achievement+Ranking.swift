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

    var achievementCardPedestalStyle: String {
        isRareAchievement ? "marble" : "wood"
    }

    var achievementIsFrequencyBased: Bool {
        category == .streak || category == .games
    }

    var achievementCardLaurelStyle: String {
        isRareAchievement ? "golden" : "none"
    }

    var achievementMinRoundsPlayed: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementCardPlateColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "copper"
        case .score: return "bronze"
        case .games: return "silver"
        }
    }
}
