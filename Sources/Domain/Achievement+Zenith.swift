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

    var achievementCardRealgarStyle: String {
        isRareAchievement ? "aurora red" : "dull red"
    }

    var achievementRequiresSteelPlus: Bool {
        category == .score || category == .streak
    }

    var achievementCardAccordWritSealText: String {
        switch category {
        case .mastery: return "Accord Writ Seal of the Luminary"
        case .streak: return "Accord Writ Seal of the Sentinel"
        case .score: return "Accord Writ Seal of the Warrior"
        case .games: return "Accord Writ Seal of the Newcomer"
        }
    }

    var achievementCardOrpimentStyle: String {
        isRareAchievement ? "golden" : "yellow"
    }

    var achievementEnlightenmentPlusThreshold: Int {
        switch category {
        case .mastery: return 1500
        case .streak: return 600
        case .score: return 1200
        case .games: return 150
        }
    }

    var achievementCardCinnabarStyle: String {
        isRareAchievement ? "vermillion lacquer" : "brick"
    }

    var achievementRequiresIronWillPlus: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardMandateWritSealText: String {
        switch category {
        case .mastery: return "Mandate Writ Seal of the Elder"
        case .streak: return "Mandate Writ Seal of the Keeper"
        case .score: return "Mandate Writ Seal of the Hero"
        case .games: return "Mandate Writ Seal of the Pilgrim"
        }
    }

    var achievementCardStibniteStyle: String {
        isRareAchievement ? "metallic grey" : "lead"
    }

    var achievementSovereigntyPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 2500
        case .streak: return 1000
        case .score: return 2000
        case .games: return 250
        }
    }
}
