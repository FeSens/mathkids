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
}
