import Foundation

extension Achievement {
    var achievementCardSarabauitePlusStyle: String {
        isRareAchievement ? "reddish brown prismatic" : "dull brown"
    }

    var achievementRequiresFaithPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardAccordWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Accord Writ Seal Ultra Plus of the Divine"
        case .streak: return "Accord Writ Seal Ultra Plus of the Stalwart"
        case .score: return "Accord Writ Seal Ultra Plus of the Resplendent"
        case .games: return "Accord Writ Seal Ultra Plus of the Seeker"
        }
    }

    var achievementCardKermesiniteStyle: String {
        isRareAchievement ? "cherry red acicular" : "dull red"
    }

    var achievementOlympusPlusThreshold: Int {
        switch category {
        case .mastery: return 55000000
        case .streak: return 22000000
        case .score: return 50000000
        case .games: return 5500000
        }
    }

    var achievementCardLivingstoniteProStyle: String {
        isRareAchievement ? "blackish grey prismatic" : "dull charcoal"
    }

    var achievementRequiresDutyPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardMandateWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Mandate Writ Seal Ultra Plus of the Immortal"
        case .streak: return "Mandate Writ Seal Ultra Plus of the Fortress"
        case .score: return "Mandate Writ Seal Ultra Plus of the Glorious"
        case .games: return "Mandate Writ Seal Ultra Plus of the Disciple"
        }
    }

    var achievementCardGuettarditeStyle: String {
        isRareAchievement ? "lead grey monoclinic" : "flat lead"
    }

    var achievementAsgardPlusThreshold: Int {
        switch category {
        case .mastery: return 60000000
        case .streak: return 24000000
        case .score: return 55000000
        case .games: return 6000000
        }
    }

    var achievementCardRobinsoniteStyle: String {
        isRareAchievement ? "lead grey prismatic" : "ashen lead"
    }

    var achievementRequiresLoyaltyPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardStatuteWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Statute Writ Seal Ultra Plus of the Primordial"
        case .streak: return "Statute Writ Seal Ultra Plus of the Rampart"
        case .score: return "Statute Writ Seal Ultra Plus of the Preeminent"
        case .games: return "Statute Writ Seal Ultra Plus of the Novice"
        }
    }

    var achievementCardTwinniteStyle: String {
        isRareAchievement ? "steel grey orthorhombic" : "dull steel"
    }

    var achievementMidgardPlusThreshold: Int {
        switch category {
        case .mastery: return 65000000
        case .streak: return 26000000
        case .score: return 60000000
        case .games: return 6500000
        }
    }

    var achievementCardVeeniteProStyle: String {
        isRareAchievement ? "tin grey fibrous" : "pale tin"
    }

    var achievementRequiresWisdomPlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardDirectiveWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Directive Writ Seal Ultra Plus of the Arcane"
        case .streak: return "Directive Writ Seal Ultra Plus of the Bulwark"
        case .score: return "Directive Writ Seal Ultra Plus of the Sublime"
        case .games: return "Directive Writ Seal Ultra Plus of the Pupil"
        }
    }

    var achievementCardFranckeiteProStyle: String {
        isRareAchievement ? "greyish black tabular" : "dark grey"
    }

    var achievementBifrostPlusThreshold: Int {
        switch category {
        case .mastery: return 70000000
        case .streak: return 28000000
        case .score: return 65000000
        case .games: return 7000000
        }
    }

    var achievementCardCylindriteProStyle: String {
        isRareAchievement ? "tin grey cylindrical" : "dull tin"
    }

    var achievementRequiresJusticePlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardInjunctionWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Injunction Writ Seal Ultra Plus of the Astral"
        case .streak: return "Injunction Writ Seal Ultra Plus of the Citadel"
        case .score: return "Injunction Writ Seal Ultra Plus of the Zenith"
        case .games: return "Injunction Writ Seal Ultra Plus of the Acolyte"
        }
    }

    var achievementCardStephaniteProStyle: String {
        isRareAchievement ? "iron black prismatic" : "flat black"
    }

    var achievementYggdrasilPlusThreshold: Int {
        switch category {
        case .mastery: return 75000000
        case .streak: return 30000000
        case .score: return 70000000
        case .games: return 7500000
        }
    }

    var achievementCardPolybasiteProStyle: String {
        isRareAchievement ? "steel black tabular" : "dark iron"
    }

    var achievementRequiresTruthPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardResolutionWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal Ultra Plus of the Ethereal"
        case .streak: return "Resolution Writ Seal Ultra Plus of the Eternal"
        case .score: return "Resolution Writ Seal Ultra Plus of the Absolute"
        case .games: return "Resolution Writ Seal Ultra Plus of the Pilgrim"
        }
    }

    var achievementCardPearceiteProStyle: String {
        isRareAchievement ? "black metallic trigonal" : "matte iron"
    }

    var achievementRagnarokPlusThreshold: Int {
        switch category {
        case .mastery: return 80000000
        case .streak: return 32000000
        case .score: return 75000000
        case .games: return 8000000
        }
    }
}
