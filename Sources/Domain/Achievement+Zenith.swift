import Foundation

extension Achievement {
    var achievementCardVanadiniteStyle: String {
        isRareAchievement ? "crimson" : "rust"
    }

    var achievementRequiresIronNervePlus: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardCharterWritSealText: String {
        switch category {
        case .mastery: return "Charter Writ Seal of the Architect"
        case .streak: return "Charter Writ Seal of the Guardian"
        case .score: return "Charter Writ Seal of the Conqueror"
        case .games: return "Charter Writ Seal of the Initiate"
        }
    }

    var achievementCardProustiteStyle: String {
        isRareAchievement ? "vermilion" : "scarlet"
    }

    var achievementTranscendencePlusThreshold: Int {
        switch category {
        case .mastery: return 1000
        case .streak: return 400
        case .score: return 800
        case .games: return 100
        }
    }
}
