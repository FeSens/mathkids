import Foundation

extension Achievement {
    var achievementCardPyrargyriteUltraStyle: String {
        isRareAchievement ? "deep red prismatic" : "dull crimson matte"
    }

    var achievementRequiresEmpyreanPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardAccordWritSealMaxText: String {
        switch category {
        case .mastery: return "Accord Writ Seal Max of the Arcane"
        case .streak: return "Accord Writ Seal Max of the Stalwart"
        case .score: return "Accord Writ Seal Max of the Resplendent"
        case .games: return "Accord Writ Seal Max of the Pupil"
        }
    }

    var achievementCardMiargyriteUltraStyle: String {
        isRareAchievement ? "steel grey monoclinic" : "flat pewter matte"
    }

    var achievementHelheimPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 165000000
        case .streak: return 66000000
        case .score: return 160000000
        case .games: return 16500000
        }
    }
}
