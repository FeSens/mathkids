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

    var achievementCardSpectroliteStyle: String {
        isRareAchievement ? "iridescent" : "dark"
    }

    var achievementRequiresDrive: Bool {
        category == .score || category == .mastery
    }

    var achievementCardCovenantSealText: String {
        switch category {
        case .mastery: return "Covenant Seal of Wisdom"
        case .streak: return "Covenant Seal of Loyalty"
        case .score: return "Covenant Seal of Honor"
        case .games: return "Covenant Seal of Welcome"
        }
    }

    var achievementCardChrysoberylStyle: String {
        isRareAchievement ? "cats eye" : "yellow"
    }

    var achievementCrownThreshold: Int {
        switch category {
        case .mastery: return 250000
        case .streak: return 75000
        case .score: return 200000
        case .games: return 25000
        }
    }

    var achievementCardApatiteStyle: String {
        isRareAchievement ? "neon" : "faded"
    }

    var achievementRequiresDevotion: Bool {
        category == .mastery
    }

    var achievementCardCharterSealText: String {
        switch category {
        case .mastery: return "Charter Seal of the Academy"
        case .streak: return "Charter Seal of the Order"
        case .score: return "Charter Seal of the Guild"
        case .games: return "Charter Seal of the Commons"
        }
    }

    var achievementCardZoisiteStyle: String {
        isRareAchievement ? "vivid green" : "dull"
    }

    var achievementThroneThreshold: Int {
        switch category {
        case .mastery: return 300000
        case .streak: return 100000
        case .score: return 250000
        case .games: return 30000
        }
    }

    var achievementCardMoldaviteStyle: String {
        isRareAchievement ? "etched" : "rough"
    }

    var achievementRequiresInitiative: Bool {
        category == .games
    }

    var achievementCardCompactSealText: String {
        switch category {
        case .mastery: return "Compact Seal of Scholars"
        case .streak: return "Compact Seal of Guardians"
        case .score: return "Compact Seal of Warriors"
        case .games: return "Compact Seal of Adventurers"
        }
    }

    var achievementCardDanburiteStyle: String {
        isRareAchievement ? "prismatic" : "cloudy"
    }

    var achievementScepterThreshold: Int {
        switch category {
        case .mastery: return 400000
        case .streak: return 150000
        case .score: return 300000
        case .games: return 40000
        }
    }

    var achievementCardHiddeniteStyle: String {
        isRareAchievement ? "luminous" : "pale"
    }

    var achievementRequiresFortitudePlus: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardAccordSealText: String {
        switch category {
        case .mastery: return "Accord Seal of Wisdom"
        case .streak: return "Accord Seal of Loyalty"
        case .score: return "Accord Seal of Honor"
        case .games: return "Accord Seal of Welcome"
        }
    }

    var achievementCardBenitoiteStyle: String {
        isRareAchievement ? "sapphire" : "grey"
    }

    var achievementRegaliaThreshold: Int {
        switch category {
        case .mastery: return 500000
        case .streak: return 200000
        case .score: return 400000
        case .games: return 50000
        }
    }
}
