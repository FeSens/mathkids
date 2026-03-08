import Foundation

extension Achievement {
    var achievementCardPyrargyriteUltraStyle: String {
        isRareAchievement ? "deep red prismatic" : "dull crimson matte"
    }

    var achievementRequiresEmpyreanPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardAccordWritSealMaxText: String {
        switch category {
        case .mastery: return "Accord Writ Seal Max of the Arcane"
        case .streak: return "Accord Writ Seal Max of the Stalwart"
        case .score: return "Accord Writ Seal Max of the Resplendent"
        case .games: return "Accord Writ Seal Max of the Pupil"
        }
    }

    var achievementCardMiargyriteUltraStyle: String {
        isRareAchievement ? "steel grey monoclinic" : "flat pewter matte"
    }

    var achievementHelheimPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 165000000
        case .streak: return 66000000
        case .score: return 160000000
        case .games: return 16500000
        }
    }

    var achievementCardSamsoniteUltraStyle: String {
        isRareAchievement ? "steel black monoclinic" : "dark steel matte"
    }

    var achievementRequiresEternalPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardMandateWritSealMaxText: String {
        switch category {
        case .mastery: return "Mandate Writ Seal Max of the Cosmic"
        case .streak: return "Mandate Writ Seal Max of the Fortress"
        case .score: return "Mandate Writ Seal Max of the Glorious"
        case .games: return "Mandate Writ Seal Max of the Novice"
        }
    }

    var achievementCardMatilditeUltraStyle: String {
        isRareAchievement ? "iron grey hexagonal" : "dull iron matte"
    }

    var achievementNiflheimPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 170000000
        case .streak: return 68000000
        case .score: return 165000000
        case .games: return 17000000
        }
    }

    var achievementCardEmplectiteUltraStyle: String {
        isRareAchievement ? "tin grey prismatic" : "pale grey matte"
    }

    var achievementRequiresSublimePlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardStatuteWritSealMaxText: String {
        switch category {
        case .mastery: return "Statute Writ Seal Max of the Astral"
        case .streak: return "Statute Writ Seal Max of the Rampart"
        case .score: return "Statute Writ Seal Max of the Preeminent"
        case .games: return "Statute Writ Seal Max of the Recruit"
        }
    }

    var achievementCardAikiniteUltraStyle: String {
        isRareAchievement ? "lead grey orthorhombic" : "flat lead matte"
    }

    var achievementMuspelheimPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 175000000
        case .streak: return 70000000
        case .score: return 170000000
        case .games: return 17500000
        }
    }
}
