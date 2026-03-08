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

    var achievementCardSamsoniteProStyle: String {
        isRareAchievement ? "steel black monoclinic" : "dark steel"
    }

    var achievementRequiresVisionPlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardOrdinanceWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Ordinance Writ Seal Ultra Plus of the Empyrean"
        case .streak: return "Ordinance Writ Seal Ultra Plus of the Guardian"
        case .score: return "Ordinance Writ Seal Ultra Plus of the Paramount"
        case .games: return "Ordinance Writ Seal Ultra Plus of the Initiate"
        }
    }

    var achievementCardMatilditeProStyle: String {
        isRareAchievement ? "iron grey hexagonal" : "dull iron"
    }

    var achievementFimbulwinterThreshold: Int {
        switch category {
        case .mastery: return 90000000
        case .streak: return 36000000
        case .score: return 85000000
        case .games: return 9000000
        }
    }

    var achievementCardEmplectiteProStyle: String {
        isRareAchievement ? "tin grey prismatic" : "pale grey"
    }

    var achievementRequiresIntegrityPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardEdictWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Edict Writ Seal Ultra Plus Plus of the Infinite"
        case .streak: return "Edict Writ Seal Ultra Plus Plus of the Warden"
        case .score: return "Edict Writ Seal Ultra Plus Plus of the Exalted"
        case .games: return "Edict Writ Seal Ultra Plus Plus of the Neophyte"
        }
    }

    var achievementCardAikiniteProStyle: String {
        isRareAchievement ? "lead grey orthorhombic" : "flat lead"
    }

    var achievementHelheimPlusThreshold: Int {
        switch category {
        case .mastery: return 95000000
        case .streak: return 38000000
        case .score: return 90000000
        case .games: return 9500000
        }
    }
}
