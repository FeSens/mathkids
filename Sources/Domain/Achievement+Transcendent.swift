import Foundation

extension Achievement {
    var achievementCardGladiteProStyle: String {
        isRareAchievement ? "tin grey acicular" : "pale tin"
    }

    var achievementRequiresHarmonyPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardAccordWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Accord Writ Seal Ultra Plus Plus of the Transcendent"
        case .streak: return "Accord Writ Seal Ultra Plus Plus of the Stalwart"
        case .score: return "Accord Writ Seal Ultra Plus Plus of the Resplendent"
        case .games: return "Accord Writ Seal Ultra Plus Plus of the Disciple"
        }
    }

    var achievementCardHammariteProStyle: String {
        isRareAchievement ? "steel grey monoclinic" : "leaden grey"
    }

    var achievementJotunheimThreshold: Int {
        switch category {
        case .mastery: return 110000000
        case .streak: return 44000000
        case .score: return 105000000
        case .games: return 11000000
        }
    }

    var achievementCardPekoiteProStyle: String {
        isRareAchievement ? "silver grey needle" : "flat silver"
    }

    var achievementRequiresBalancePlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardMandateWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Mandate Writ Seal Ultra Plus Plus of the Absolute"
        case .streak: return "Mandate Writ Seal Ultra Plus Plus of the Fortress"
        case .score: return "Mandate Writ Seal Ultra Plus Plus of the Glorious"
        case .games: return "Mandate Writ Seal Ultra Plus Plus of the Novice"
        }
    }

    var achievementCardNuffielditeProStyle: String {
        isRareAchievement ? "lead grey tabular" : "dull lead grey"
    }

    var achievementSvartAlfaheimThreshold: Int {
        switch category {
        case .mastery: return 115000000
        case .streak: return 46000000
        case .score: return 110000000
        case .games: return 11500000
        }
    }

    var achievementCardGalenobismutiteProStyle: String {
        isRareAchievement ? "tin white lamellar" : "dull tin white"
    }

    var achievementRequiresUnityPlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardStatuteWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Statute Writ Seal Ultra Plus Plus of the Primeval"
        case .streak: return "Statute Writ Seal Ultra Plus Plus of the Rampart"
        case .score: return "Statute Writ Seal Ultra Plus Plus of the Preeminent"
        case .games: return "Statute Writ Seal Ultra Plus Plus of the Pupil"
        }
    }

    var achievementCardCosaliteProStyle: String {
        isRareAchievement ? "lead grey prismatic" : "flat grey lead"
    }

    var achievementAlfheimPlusThreshold: Int {
        switch category {
        case .mastery: return 120000000
        case .streak: return 48000000
        case .score: return 115000000
        case .games: return 12000000
        }
    }

    var achievementCardLillianiteProStyle: String {
        isRareAchievement ? "steel grey orthorhombic" : "dull grey steel"
    }

    var achievementRequiresSerenityPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardDirectiveWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Directive Writ Seal Ultra Plus Plus of the Almighty"
        case .streak: return "Directive Writ Seal Ultra Plus Plus of the Vanguard"
        case .score: return "Directive Writ Seal Ultra Plus Plus of the Apex"
        case .games: return "Directive Writ Seal Ultra Plus Plus of the Recruit"
        }
    }

    var achievementCardHeyrovskyiteProStyle: String {
        isRareAchievement ? "tin grey monoclinic" : "pale pewter grey"
    }

    var achievementVanaheimPlusThreshold: Int {
        switch category {
        case .mastery: return 125000000
        case .streak: return 50000000
        case .score: return 120000000
        case .games: return 12500000
        }
    }

    var achievementCardTintinaiteProStyle: String {
        isRareAchievement ? "steel grey acicular" : "dull steel grey"
    }

    var achievementRequiresEssencePlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardInjunctionWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Injunction Writ Seal Ultra Plus Plus of the Omniscient"
        case .streak: return "Injunction Writ Seal Ultra Plus Plus of the Citadel"
        case .score: return "Injunction Writ Seal Ultra Plus Plus of the Pinnacle"
        case .games: return "Injunction Writ Seal Ultra Plus Plus of the Novitiate"
        }
    }

    var achievementCardBerthieriteProStyle: String {
        isRareAchievement ? "dark steel fibrous" : "flat steel grey"
    }

    var achievementAsgardPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 130000000
        case .streak: return 52000000
        case .score: return 125000000
        case .games: return 13000000
        }
    }
}
