import Foundation

extension Achievement {
    var achievementCardGladiteStyle: String {
        isRareAchievement ? "tin grey acicular" : "pale grey"
    }

    var achievementRequiresCouragePlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardDirectiveWritSealUltraText: String {
        switch category {
        case .mastery: return "Directive Writ Seal Ultra of the Omniscient"
        case .streak: return "Directive Writ Seal Ultra of the Vanguard"
        case .score: return "Directive Writ Seal Ultra of the Apex"
        case .games: return "Directive Writ Seal Ultra of the Novitiate"
        }
    }

    var achievementCardHammariteStyle: String {
        isRareAchievement ? "steel grey monoclinic" : "leaden"
    }

    var achievementOmnipotencePlusThreshold: Int {
        switch category {
        case .mastery: return 10000000
        case .streak: return 4000000
        case .score: return 10000000
        case .games: return 1000000
        }
    }
}
