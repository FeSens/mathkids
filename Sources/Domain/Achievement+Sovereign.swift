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
}
