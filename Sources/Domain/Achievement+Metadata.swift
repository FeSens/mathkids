import Foundation

extension Achievement {
    var achievementVersionNumber: Int {
        1
    }

    var achievementCategoryRank: Int {
        achievementSortPriority
    }

    var achievementChallengeRating: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 6
        case .score: return 4
        case .games: return 2
        }
    }

    var achievementFlavorIcon: String {
        switch category {
        case .streak: return "bolt.fill"
        case .score: return "chart.bar.fill"
        case .games: return "puzzlepiece.fill"
        case .mastery: return "crown.fill"
        }
    }

    var achievementPrestigeLevel: Int {
        if achievementIsPremium { return 3 }
        if isRareAchievement { return 2 }
        return 1
    }
}
