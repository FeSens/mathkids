import Foundation

extension Achievement {
    var achievementCardTaaffeiteStyle: String {
        isRareAchievement ? "mauve" : "grey"
    }

    var achievementRequiresZeal: Bool {
        category == .score || category == .mastery
    }

    var achievementCardWritSealText: String {
        switch category {
        case .mastery: return "Writ Seal of Mastery"
        case .streak: return "Writ Seal of Endurance"
        case .score: return "Writ Seal of Excellence"
        case .games: return "Writ Seal of Admission"
        }
    }

    var achievementCardJeremejeviteStyle: String {
        isRareAchievement ? "crystal" : "frosted"
    }

    var achievementRealmThreshold: Int {
        switch category {
        case .mastery: return 1500000
        case .streak: return 750000
        case .score: return 1000000
        case .games: return 150000
        }
    }
}
