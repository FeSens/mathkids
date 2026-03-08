import Foundation

extension Achievement {
    var achievementCardCylindriteStyle: String {
        isRareAchievement ? "dark lead cylindrical" : "matte lead"
    }

    var achievementRequiresEndurancePlusPlus: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardResolutionWritSealPlusText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal Plus of the Progenitor"
        case .streak: return "Resolution Writ Seal Plus of the Centurion"
        case .score: return "Resolution Writ Seal Plus of the Conqueror"
        case .games: return "Resolution Writ Seal Plus of the Acolyte"
        }
    }

    var achievementCardFranckeiteStyle: String {
        isRareAchievement ? "greyish black foliated" : "dark iron"
    }

    var achievementDominancePlusThreshold: Int {
        switch category {
        case .mastery: return 400000
        case .streak: return 160000
        case .score: return 350000
        case .games: return 40000
        }
    }
}
