import Foundation

extension Achievement {
    var achievementCardPietersiteStyle: String {
        isRareAchievement ? "tempest" : "calm"
    }

    var achievementRequiresStamina: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardResolutionText: String {
        switch category {
        case .mastery: return "Resolution of the Learned"
        case .streak: return "Resolution of the Devoted"
        case .score: return "Resolution of the Skilled"
        case .games: return "Resolution of the Eager"
        }
    }

    var achievementCardAventurineStyle: String {
        isRareAchievement ? "sparkling" : "dull"
    }

    var achievementApexThreshold: Int {
        switch category {
        case .mastery: return 100000
        case .streak: return 25000
        case .score: return 75000
        case .games: return 10000
        }
    }
}
