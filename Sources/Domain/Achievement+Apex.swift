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

    var achievementCardWhitneyiteStyle: String {
        isRareAchievement ? "rose copper" : "tarnished"
    }

    var achievementRequiresBackbonePlus: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardCovenantWritSealPlusText: String {
        switch category {
        case .mastery: return "Covenant Writ Seal Plus of the Hierarch"
        case .streak: return "Covenant Writ Seal Plus of the Marshal"
        case .score: return "Covenant Writ Seal Plus of the Paladin"
        case .games: return "Covenant Writ Seal Plus of the Disciple"
        }
    }

    var achievementCardRickarditeStyle: String {
        isRareAchievement ? "purple bronze" : "dark bronze"
    }

    var achievementCrownPlusThreshold: Int {
        switch category {
        case .mastery: return 35000
        case .streak: return 14000
        case .score: return 28000
        case .games: return 3500
        }
    }
}
