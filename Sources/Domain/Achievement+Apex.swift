import Foundation

extension Achievement {
    var achievementCardAlgodoniteStyle: String {
        isRareAchievement ? "steel blue" : "iron grey"
    }

    var achievementRequiresNervePlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardEdictWritSealPlusText: String {
        switch category {
        case .mastery: return "Edict Writ Seal Plus of the Grandmaster"
        case .streak: return "Edict Writ Seal Plus of the Sentinel"
        case .score: return "Edict Writ Seal Plus of the Virtuoso"
        case .games: return "Edict Writ Seal Plus of the Candidate"
        }
    }

    var achievementCardDomeykiteStyle: String {
        isRareAchievement ? "tin white sheen" : "pewter grey"
    }

    var achievementCrestPlusThreshold: Int {
        switch category {
        case .mastery: return 25000
        case .streak: return 10000
        case .score: return 20000
        case .games: return 2500
        }
    }
}
