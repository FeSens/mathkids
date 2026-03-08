import Foundation

extension Achievement {
    var achievementCardPietersiteStyle: String {
        isRareAchievement ? "tempest" : "calm"
    }

    var achievementRequiresStamina: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardResolutionText: String {
        switch category {
        case .mastery: return "Resolution of the Learned"
        case .streak: return "Resolution of the Devoted"
        case .score: return "Resolution of the Skilled"
        case .games: return "Resolution of the Eager"
        }
    }

    var achievementCardAventurineStyle: String {
        isRareAchievement ? "sparkling" : "dull"
    }

    var achievementApexThreshold: Int {
        switch category {
        case .mastery: return 100000
        case .streak: return 25000
        case .score: return 75000
        case .games: return 10000
        }
    }

    var achievementCardSerpentineStyle: String {
        isRareAchievement ? "veined" : "smooth"
    }

    var achievementRequiresPersistence: Bool {
        category == .streak
    }

    var achievementCardDecreeWritText: String {
        switch category {
        case .mastery: return "Decree Writ of the Academy"
        case .streak: return "Decree Writ of the Order"
        case .score: return "Decree Writ of the Arena"
        case .games: return "Decree Writ of the Commons"
        }
    }

    var achievementCardRhodochrositeStyle: String {
        isRareAchievement ? "banded pink" : "pale"
    }

    var achievementSummitThreshold: Int {
        switch category {
        case .mastery: return 150000
        case .streak: return 30000
        case .score: return 100000
        case .games: return 15000
        }
    }

    var achievementCardKyaniteStyle: String {
        isRareAchievement ? "blade" : "flat"
    }

    var achievementRequiresWillpower: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardEdictSealText: String {
        switch category {
        case .mastery: return "Edict Seal of the Sage"
        case .streak: return "Edict Seal of the Sentinel"
        case .score: return "Edict Seal of the Champion"
        case .games: return "Edict Seal of the Novice"
        }
    }

    var achievementCardThuliteStyle: String {
        isRareAchievement ? "rose" : "faint"
    }

    var achievementCrestThreshold: Int {
        switch category {
        case .mastery: return 200000
        case .streak: return 50000
        case .score: return 150000
        case .games: return 20000
        }
    }
}
