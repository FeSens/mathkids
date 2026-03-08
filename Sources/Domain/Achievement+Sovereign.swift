import Foundation

extension Achievement {
    var achievementCardGladiteStyle: String {
        isRareAchievement ? "tin grey acicular" : "pale grey"
    }

    var achievementRequiresCouragePlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardDirectiveWritSealUltraText: String {
        switch category {
        case .mastery: return "Directive Writ Seal Ultra of the Omniscient"
        case .streak: return "Directive Writ Seal Ultra of the Vanguard"
        case .score: return "Directive Writ Seal Ultra of the Apex"
        case .games: return "Directive Writ Seal Ultra of the Novitiate"
        }
    }

    var achievementCardHammariteStyle: String {
        isRareAchievement ? "steel grey monoclinic" : "leaden"
    }

    var achievementOmnipotencePlusThreshold: Int {
        switch category {
        case .mastery: return 10000000
        case .streak: return 4000000
        case .score: return 10000000
        case .games: return 1000000
        }
    }

    var achievementCardPekoiteStyle: String {
        isRareAchievement ? "silver grey needle" : "flat silver"
    }

    var achievementRequiresAmbitionPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardInjunctionWritSealUltraText: String {
        switch category {
        case .mastery: return "Injunction Writ Seal Ultra of the Infinite"
        case .streak: return "Injunction Writ Seal Ultra of the Citadel"
        case .score: return "Injunction Writ Seal Ultra of the Pinnacle"
        case .games: return "Injunction Writ Seal Ultra of the Acolyte"
        }
    }

    var achievementCardNuffielditeStyle: String {
        isRareAchievement ? "lead grey tabular" : "dull lead"
    }

    var achievementParagonPlusThreshold: Int {
        switch category {
        case .mastery: return 15000000
        case .streak: return 6000000
        case .score: return 15000000
        case .games: return 1500000
        }
    }

    var achievementCardGalenobismutiteStyle: String {
        isRareAchievement ? "tin white lamellar" : "dull tin"
    }

    var achievementRequiresDiligencePlus: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardResolutionWritSealUltraText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal Ultra of the Supreme"
        case .streak: return "Resolution Writ Seal Ultra of the Eternal"
        case .score: return "Resolution Writ Seal Ultra of the Absolute"
        case .games: return "Resolution Writ Seal Ultra of the Pilgrim"
        }
    }

    var achievementCardCosaliteStyle: String {
        isRareAchievement ? "lead grey prismatic" : "flat grey"
    }

    var achievementExemplarPlusThreshold: Int {
        switch category {
        case .mastery: return 25000000
        case .streak: return 10000000
        case .score: return 20000000
        case .games: return 2500000
        }
    }

    var achievementCardLillianiteStyle: String {
        isRareAchievement ? "steel grey orthorhombic" : "dull grey"
    }

    var achievementRequiresValorPlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardCompactWritSealUltraText: String {
        switch category {
        case .mastery: return "Compact Writ Seal Ultra of the Transcendent"
        case .streak: return "Compact Writ Seal Ultra of the Sentinel"
        case .score: return "Compact Writ Seal Ultra of the Sovereign"
        case .games: return "Compact Writ Seal Ultra of the Wanderer"
        }
    }

    var achievementCardHeyrovskyiteStyle: String {
        isRareAchievement ? "tin grey monoclinic" : "pale pewter"
    }

    var achievementQuintessencePlusThreshold: Int {
        switch category {
        case .mastery: return 30000000
        case .streak: return 12000000
        case .score: return 25000000
        case .games: return 3000000
        }
    }

    var achievementCardVeeniteStyle: String {
        isRareAchievement ? "lead grey prismatic" : "ashen"
    }

    var achievementRequiresHonorPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardOrdinanceWritSealUltraText: String {
        switch category {
        case .mastery: return "Ordinance Writ Seal Ultra of the Celestial"
        case .streak: return "Ordinance Writ Seal Ultra of the Guardian"
        case .score: return "Ordinance Writ Seal Ultra of the Paramount"
        case .games: return "Ordinance Writ Seal Ultra of the Initiate"
        }
    }

    var achievementCardKobelliteStyle: String {
        isRareAchievement ? "blackish grey prismatic" : "dark grey"
    }

    var achievementNirvanaPlusThreshold: Int {
        switch category {
        case .mastery: return 35000000
        case .streak: return 14000000
        case .score: return 30000000
        case .games: return 3500000
        }
    }

    var achievementCardTintinaiteStyle: String {
        isRareAchievement ? "steel grey acicular" : "dull steel"
    }

    var achievementRequiresGracePlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardEdictWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Edict Writ Seal Ultra Plus of the Mythic"
        case .streak: return "Edict Writ Seal Ultra Plus of the Warden"
        case .score: return "Edict Writ Seal Ultra Plus of the Exalted"
        case .games: return "Edict Writ Seal Ultra Plus of the Apprentice"
        }
    }

    var achievementCardBerthieriteStyle: String {
        isRareAchievement ? "dark steel fibrous" : "flat steel"
    }

    var achievementParadisePlusThreshold: Int {
        switch category {
        case .mastery: return 40000000
        case .streak: return 16000000
        case .score: return 35000000
        case .games: return 4000000
        }
    }

    var achievementCardGuejariteStyle: String {
        isRareAchievement ? "grey black tabular" : "matte black"
    }

    var achievementRequiresPridePlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardCovenantWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Covenant Writ Seal Ultra Plus of the Legendary"
        case .streak: return "Covenant Writ Seal Ultra Plus of the Bastion"
        case .score: return "Covenant Writ Seal Ultra Plus of the Illustrious"
        case .games: return "Covenant Writ Seal Ultra Plus of the Neophyte"
        }
    }

    var achievementCardChalcostibiteProStyle: String {
        isRareAchievement ? "lead grey orthorhombic" : "dull lead"
    }

    var achievementElysiumPlusThreshold: Int {
        switch category {
        case .mastery: return 45000000
        case .streak: return 18000000
        case .score: return 40000000
        case .games: return 4500000
        }
    }

    var achievementCardPanaderoiteStyle: String {
        isRareAchievement ? "white prismatic" : "pale white"
    }

    var achievementRequiresGloryPlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardCharterWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Charter Writ Seal Ultra Plus of the Eternal"
        case .streak: return "Charter Writ Seal Ultra Plus of the Vigilant"
        case .score: return "Charter Writ Seal Ultra Plus of the Majestic"
        case .games: return "Charter Writ Seal Ultra Plus of the Aspirant"
        }
    }

    var achievementCardEmployiteStyle: String {
        isRareAchievement ? "tin grey tabular" : "flat tin"
    }

    var achievementValhallaThreshold: Int {
        switch category {
        case .mastery: return 50000000
        case .streak: return 20000000
        case .score: return 45000000
        case .games: return 5000000
        }
    }
}
