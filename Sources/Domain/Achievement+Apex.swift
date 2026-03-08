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

    var achievementCardWeissiteStyle: String {
        isRareAchievement ? "blue black" : "dark grey"
    }

    var achievementRequiresPassionPlus: Bool {
        category == .games || category == .mastery
    }

    var achievementCardCharterWritSealPlusText: String {
        switch category {
        case .mastery: return "Charter Writ Seal Plus of the Pontiff"
        case .streak: return "Charter Writ Seal Plus of the Centurion"
        case .score: return "Charter Writ Seal Plus of the Legend"
        case .games: return "Charter Writ Seal Plus of the Pupil"
        }
    }

    var achievementCardRenieriteStyle: String {
        isRareAchievement ? "bronze yellow" : "mustard"
    }

    var achievementThronePlusThreshold: Int {
        switch category {
        case .mastery: return 50000
        case .streak: return 20000
        case .score: return 40000
        case .games: return 5000
        }
    }

    var achievementCardStanniteStyle: String {
        isRareAchievement ? "steel black" : "olive grey"
    }

    var achievementRequiresMettlePlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardAccordWritSealPlusText: String {
        switch category {
        case .mastery: return "Accord Writ Seal Plus of the Sovereign"
        case .streak: return "Accord Writ Seal Plus of the Vanguard"
        case .score: return "Accord Writ Seal Plus of the Titan"
        case .games: return "Accord Writ Seal Plus of the Aspirant"
        }
    }

    var achievementCardTetrahedriteStyle: String {
        isRareAchievement ? "steel grey sheen" : "iron"
    }

    var achievementScepterPlusThreshold: Int {
        switch category {
        case .mastery: return 75000
        case .streak: return 30000
        case .score: return 60000
        case .games: return 7500
        }
    }
}
