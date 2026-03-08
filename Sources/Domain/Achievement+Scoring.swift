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

    var achievementCardTrophyStyle: String {
        isRareAchievement ? "large" : "small"
    }

    var achievementExperienceMultiplier: Double {
        switch category {
        case .mastery: return 3.0
        case .streak: return 2.0
        case .score: return 1.5
        case .games: return 1.0
        }
    }

    var achievementCardFrameStyle: String {
        isRareAchievement ? "ornate" : "simple"
    }

    var achievementIsPrecisionBased: Bool {
        category == .score
    }

    var achievementCardTierBadge: String {
        switch category {
        case .mastery: return "Elite"
        case .streak: return "Dedicated"
        case .score: return "Skilled"
        case .games: return "Starter"
        }
    }
}
