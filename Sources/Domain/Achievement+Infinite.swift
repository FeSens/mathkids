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
}
