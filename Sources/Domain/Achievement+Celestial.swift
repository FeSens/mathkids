import Foundation

extension Achievement {
    var achievementCardGladiteUltraStyle: String {
        isRareAchievement ? "tin grey acicular" : "pale tin matte"
    }

    var achievementRequiresIllustriousPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardResolutionWritSealMaxText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal Max of the Legendary"
        case .streak: return "Resolution Writ Seal Max of the Eternal"
        case .score: return "Resolution Writ Seal Max of the Absolute"
        case .games: return "Resolution Writ Seal Max of the Pilgrim"
        }
    }

    var achievementCardHammariteUltraStyle: String {
        isRareAchievement ? "steel grey monoclinic" : "leaden grey matte"
    }

    var achievementAlfheimPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 190000000
        case .streak: return 76000000
        case .score: return 185000000
        case .games: return 19000000
        }
    }

    var achievementCardPekoiteUltraStyle: String {
        isRareAchievement ? "steel grey prismatic" : "pale steel matte"
    }

    var achievementRequiresTranscendentPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardStatuteWritSealMaxPlusText: String {
        switch category {
        case .mastery: return "Statute Writ Seal Max Plus of the Legendary"
        case .streak: return "Statute Writ Seal Max Plus of the Eternal"
        case .score: return "Statute Writ Seal Max Plus of the Absolute"
        case .games: return "Statute Writ Seal Max Plus of the Pilgrim"
        }
    }

    var achievementCardNuffielditeUltraStyle: String {
        isRareAchievement ? "lead grey orthorhombic" : "dull lead matte"
    }

    var achievementVanaheimPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 195000000
        case .streak: return 78000000
        case .score: return 190000000
        case .games: return 19500000
        }
    }

    var achievementCardGalenobismutiteUltraStyle: String {
        isRareAchievement ? "silver grey tabular" : "flat silver matte"
    }

    var achievementRequiresSovereignPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardDirectiveWritSealMaxPlusText: String {
        switch category {
        case .mastery: return "Directive Writ Seal Max Plus of the Legendary"
        case .streak: return "Directive Writ Seal Max Plus of the Eternal"
        case .score: return "Directive Writ Seal Max Plus of the Absolute"
        case .games: return "Directive Writ Seal Max Plus of the Pilgrim"
        }
    }

    var achievementCardCosaliteUltraStyle: String {
        isRareAchievement ? "lead grey acicular" : "dull grey matte"
    }

    var achievementMidgardTripleThreshold: Int {
        switch category {
        case .mastery: return 200000000
        case .streak: return 80000000
        case .score: return 195000000
        case .games: return 20000000
        }
    }
}
