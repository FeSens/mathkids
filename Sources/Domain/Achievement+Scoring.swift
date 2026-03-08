import Foundation

extension Achievement {
    var achievementCardPulseEffect: Bool {
        isRareAchievement
    }

    var achievementRequiredRounds: Int {
        switch category {
        case .mastery: return 50
        case .streak: return 10
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardCrownColor: String {
        switch category {
        case .mastery: return "gold"
        case .streak: return "silver"
        case .score: return "bronze"
        case .games: return "gray"
        }
    }

    var achievementIsPerformanceBased: Bool {
        category == .score || category == .mastery
    }

    var achievementCardRankLabel: String {
        switch category {
        case .mastery: return "S Rank"
        case .streak: return "A Rank"
        case .score: return "B Rank"
        case .games: return "C Rank"
        }
    }
}
