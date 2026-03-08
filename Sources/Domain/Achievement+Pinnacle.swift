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

    var achievementCardLivingstoniteStyle: String {
        isRareAchievement ? "blackish grey prismatic" : "ashen"
    }

    var achievementRequiresTenacityPlusPlus: Bool {
        category == .score || category == .mastery
    }

    var achievementCardCompactWritSealPlusText: String {
        switch category {
        case .mastery: return "Compact Writ Seal Plus of the Patriarch"
        case .streak: return "Compact Writ Seal Plus of the Sentinel"
        case .score: return "Compact Writ Seal Plus of the Titan"
        case .games: return "Compact Writ Seal Plus of the Novice"
        }
    }

    var achievementCardStephaniteStyle: String {
        isRareAchievement ? "iron black orthorhombic" : "dark slate"
    }

    var achievementAscendancyPlusThreshold: Int {
        switch category {
        case .mastery: return 500000
        case .streak: return 200000
        case .score: return 450000
        case .games: return 50000
        }
    }

    var achievementCardPolybasiteStyle: String {
        isRareAchievement ? "iron black tabular" : "dark iron"
    }

    var achievementRequiresFortitudePlusPLus: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardOrdinanceWritSealPlusText: String {
        switch category {
        case .mastery: return "Ordinance Writ Seal Plus of the Grandmaster"
        case .streak: return "Ordinance Writ Seal Plus of the Warden"
        case .score: return "Ordinance Writ Seal Plus of the Exemplar"
        case .games: return "Ordinance Writ Seal Plus of the Pupil"
        }
    }

    var achievementCardPearceiteStyle: String {
        isRareAchievement ? "black metallic hexagonal" : "matte black"
    }

    var achievementSupremacyPlusThreshold: Int {
        switch category {
        case .mastery: return 750000
        case .streak: return 300000
        case .score: return 600000
        case .games: return 75000
        }
    }

    var achievementCardPyrargyriteStyle: String {
        isRareAchievement ? "deep ruby red" : "dark red"
    }

    var achievementRequiresWillpowerPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardEdictWritSealPlusPlusText: String {
        switch category {
        case .mastery: return "Edict Writ Seal Ultra of the Ascendant"
        case .streak: return "Edict Writ Seal Ultra of the Harbinger"
        case .score: return "Edict Writ Seal Ultra of the Destroyer"
        case .games: return "Edict Writ Seal Ultra of the Aspirant"
        }
    }

    var achievementCardProustitePlusStyle: String {
        isRareAchievement ? "scarlet adamantine" : "dull scarlet"
    }

    var achievementHegemonyPlusThreshold: Int {
        switch category {
        case .mastery: return 1000000
        case .streak: return 400000
        case .score: return 800000
        case .games: return 100000
        }
    }
}
