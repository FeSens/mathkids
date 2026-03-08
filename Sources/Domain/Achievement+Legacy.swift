import Foundation

extension Achievement {
    var achievementCardLarimarStyle: String {
        isRareAchievement ? "volcanic" : "oceanic"
    }

    var achievementRequiresGrowth: Bool {
        category == .mastery || category == .score
    }

    var achievementCardCovenantText: String {
        switch category {
        case .mastery: return "Covenant of Mastery"
        case .streak: return "Covenant of Perseverance"
        case .score: return "Covenant of Valor"
        case .games: return "Covenant of Fellowship"
        }
    }

    var achievementCardSodaliteStyle: String {
        isRareAchievement ? "royal" : "muted"
    }

    var achievementLegendThreshold: Int {
        switch category {
        case .mastery: return 1000
        case .streak: return 365
        case .score: return 500
        case .games: return 100
        }
    }
}
