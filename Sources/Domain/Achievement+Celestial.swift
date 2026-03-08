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

    var achievementCardLillianiteUltraStyle: String {
        isRareAchievement ? "steel grey orthorhombic" : "dull steel matte"
    }

    var achievementRequiresDominionPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardInjunctionWritSealMaxPlusText: String {
        switch category {
        case .mastery: return "Injunction Writ Seal Max Plus of the Legendary"
        case .streak: return "Injunction Writ Seal Max Plus of the Eternal"
        case .score: return "Injunction Writ Seal Max Plus of the Absolute"
        case .games: return "Injunction Writ Seal Max Plus of the Pilgrim"
        }
    }

    var achievementCardHeyrovskyiteUltraStyle: String {
        isRareAchievement ? "tin grey monoclinic" : "pale tin matte"
    }

    var achievementBifrostTripleThreshold: Int {
        switch category {
        case .mastery: return 205000000
        case .streak: return 82000000
        case .score: return 200000000
        case .games: return 20500000
        }
    }

    var achievementCardTintinaiteUltraStyle: String {
        isRareAchievement ? "iron grey prismatic" : "dull iron matte"
    }

    var achievementRequiresAscendantPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardResolutionWritSealMaxPlusText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal Max Plus of the Legendary"
        case .streak: return "Resolution Writ Seal Max Plus of the Eternal"
        case .score: return "Resolution Writ Seal Max Plus of the Absolute"
        case .games: return "Resolution Writ Seal Max Plus of the Pilgrim"
        }
    }

    var achievementCardBerthieriteUltraStyle: String {
        isRareAchievement ? "steel black prismatic" : "dark steel matte"
    }

    var achievementYggdrasilTripleThreshold: Int {
        switch category {
        case .mastery: return 210000000
        case .streak: return 84000000
        case .score: return 205000000
        case .games: return 21000000
        }
    }

    var achievementCardGuejariteUltraStyle: String {
        isRareAchievement ? "copper grey hexagonal" : "dull copper matte"
    }

    var achievementRequiresInfinitePlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardCompactWritSealMaxPlusText: String {
        switch category {
        case .mastery: return "Compact Writ Seal Max Plus of the Legendary"
        case .streak: return "Compact Writ Seal Max Plus of the Eternal"
        case .score: return "Compact Writ Seal Max Plus of the Absolute"
        case .games: return "Compact Writ Seal Max Plus of the Pilgrim"
        }
    }

    var achievementCardPanaderoiteUltraStyle: String {
        isRareAchievement ? "lead grey tabular" : "flat lead matte"
    }

    var achievementRagnarokTripleThreshold: Int {
        switch category {
        case .mastery: return 215000000
        case .streak: return 86000000
        case .score: return 210000000
        case .games: return 21500000
        }
    }
}
