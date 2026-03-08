import Foundation

extension Achievement {
    var achievementCardGuejariteProStyle: String {
        isRareAchievement ? "grey black tabular" : "matte charcoal"
    }

    var achievementRequiresEternityPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardResolutionWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal Ultra Plus Plus of the Mythic"
        case .streak: return "Resolution Writ Seal Ultra Plus Plus of the Eternal"
        case .score: return "Resolution Writ Seal Ultra Plus Plus of the Absolute"
        case .games: return "Resolution Writ Seal Ultra Plus Plus of the Pilgrim"
        }
    }

    var achievementCardPanaderoiteProStyle: String {
        isRareAchievement ? "white prismatic" : "pale chalk"
    }

    var achievementMidgardPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 135000000
        case .streak: return 54000000
        case .score: return 130000000
        case .games: return 13500000
        }
    }

    var achievementCardEmployiteProStyle: String {
        isRareAchievement ? "tin grey tabular" : "flat tin grey"
    }

    var achievementRequiresInfinityPlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardCompactWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Compact Writ Seal Ultra Plus Plus of the Divine"
        case .streak: return "Compact Writ Seal Ultra Plus Plus of the Sentinel"
        case .score: return "Compact Writ Seal Ultra Plus Plus of the Sovereign"
        case .games: return "Compact Writ Seal Ultra Plus Plus of the Seeker"
        }
    }

    var achievementCardKobelliteProStyle: String {
        isRareAchievement ? "blackish grey prismatic" : "dark grey lead"
    }

    var achievementBifrostPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 140000000
        case .streak: return 56000000
        case .score: return 135000000
        case .games: return 14000000
        }
    }

    var achievementCardRobinsoniteProStyle: String {
        isRareAchievement ? "lead grey prismatic" : "ashen lead grey"
    }

    var achievementRequiresAbsolutePlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardOrdinanceWritSealUltraPlusPlusText: String {
        switch category {
        case .mastery: return "Ordinance Writ Seal Ultra Plus Plus of the Immortal"
        case .streak: return "Ordinance Writ Seal Ultra Plus Plus of the Guardian"
        case .score: return "Ordinance Writ Seal Ultra Plus Plus of the Paramount"
        case .games: return "Ordinance Writ Seal Ultra Plus Plus of the Disciple"
        }
    }

    var achievementCardTwinniteProStyle: String {
        isRareAchievement ? "steel grey orthorhombic" : "dull steel lead"
    }

    var achievementYggdrasilPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 145000000
        case .streak: return 58000000
        case .score: return 140000000
        case .games: return 14500000
        }
    }

    var achievementCardVeeniteUltraStyle: String {
        isRareAchievement ? "lead grey prismatic" : "ashen pewter"
    }

    var achievementRequiresPrimordialPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardEdictWritSealMaxText: String {
        switch category {
        case .mastery: return "Edict Writ Seal Max of the Primordial"
        case .streak: return "Edict Writ Seal Max of the Warden"
        case .score: return "Edict Writ Seal Max of the Exalted"
        case .games: return "Edict Writ Seal Max of the Aspirant"
        }
    }

    var achievementCardFranckeiteUltraStyle: String {
        isRareAchievement ? "greyish black tabular" : "dark grey matte"
    }

    var achievementRagnarokPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 150000000
        case .streak: return 60000000
        case .score: return 145000000
        case .games: return 15000000
        }
    }

    var achievementCardCylindriteUltraStyle: String {
        isRareAchievement ? "tin grey cylindrical" : "dull tin matte"
    }

    var achievementRequiresCosmicPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardCovenantWritSealMaxText: String {
        switch category {
        case .mastery: return "Covenant Writ Seal Max of the Celestial"
        case .streak: return "Covenant Writ Seal Max of the Bastion"
        case .score: return "Covenant Writ Seal Max of the Illustrious"
        case .games: return "Covenant Writ Seal Max of the Wanderer"
        }
    }

    var achievementCardStephaniteUltraStyle: String {
        isRareAchievement ? "iron black prismatic" : "flat iron matte"
    }

    var achievementGotterdammerungPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 155000000
        case .streak: return 62000000
        case .score: return 150000000
        case .games: return 15500000
        }
    }

    var achievementCardPolybasiteUltraStyle: String {
        isRareAchievement ? "steel black tabular" : "dark iron matte"
    }

    var achievementRequiresAstralPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardCharterWritSealMaxText: String {
        switch category {
        case .mastery: return "Charter Writ Seal Max of the Empyrean"
        case .streak: return "Charter Writ Seal Max of the Vigilant"
        case .score: return "Charter Writ Seal Max of the Majestic"
        case .games: return "Charter Writ Seal Max of the Initiate"
        }
    }

    var achievementCardPearceiteUltraStyle: String {
        isRareAchievement ? "black metallic trigonal" : "matte iron grey"
    }

    var achievementFimbulwinterPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 160000000
        case .streak: return 64000000
        case .score: return 155000000
        case .games: return 16000000
        }
    }
}
