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
}
