import Foundation

extension Achievement {
    var achievementCardPyrargyriteProStyle: String {
        isRareAchievement ? "deep red prismatic" : "dull crimson"
    }

    var achievementRequiresClarityPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardCompactWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Compact Writ Seal Ultra Plus of the Cosmic"
        case .streak: return "Compact Writ Seal Ultra Plus of the Sentinel"
        case .score: return "Compact Writ Seal Ultra Plus of the Sovereign"
        case .games: return "Compact Writ Seal Ultra Plus of the Wanderer"
        }
    }

    var achievementCardMiargyriteProStyle: String {
        isRareAchievement ? "steel grey monoclinic" : "flat pewter"
    }

    var achievementGotterdammerungThreshold: Int {
        switch category {
        case .mastery: return 85000000
        case .streak: return 34000000
        case .score: return 80000000
        case .games: return 8500000
        }
    }
}
