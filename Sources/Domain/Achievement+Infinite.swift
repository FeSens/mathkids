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
}
