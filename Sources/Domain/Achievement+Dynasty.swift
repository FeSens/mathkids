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

    var achievementCardMusgraviteStyle: String {
        isRareAchievement ? "brilliant" : "dull"
    }

    var achievementRequiresTenacityPlus: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardDirectiveSealText: String {
        switch category {
        case .mastery: return "Directive Seal of Knowledge"
        case .streak: return "Directive Seal of Persistence"
        case .score: return "Directive Seal of Achievement"
        case .games: return "Directive Seal of Participation"
        }
    }

    var achievementCardSerendibiteStyle: String {
        isRareAchievement ? "midnight" : "grey"
    }

    var achievementDominanceThreshold: Int {
        switch category {
        case .mastery: return 2000000
        case .streak: return 1000000
        case .score: return 1500000
        case .games: return 200000
        }
    }

    var achievementCardPoudretteiteStyle: String {
        isRareAchievement ? "pink" : "clear"
    }

    var achievementRequiresVigor: Bool {
        category == .score || category == .mastery
    }

    var achievementCardInjunctionSealText: String {
        switch category {
        case .mastery: return "Injunction Seal of the Wise"
        case .streak: return "Injunction Seal of the Steadfast"
        case .score: return "Injunction Seal of the Bold"
        case .games: return "Injunction Seal of the Willing"
        }
    }

    var achievementCardPezzottaiteStyle: String {
        isRareAchievement ? "raspberry" : "light"
    }

    var achievementSovereigntyPlusThreshold: Int {
        switch category {
        case .mastery: return 3000000
        case .streak: return 1500000
        case .score: return 2000000
        case .games: return 300000
        }
    }

    var achievementCardRedBerylStyle: String {
        isRareAchievement ? "scarlet" : "pink"
    }

    var achievementRequiresSpirit: Bool {
        category == .games
    }

    var achievementCardResolutionSealText: String {
        switch category {
        case .mastery: return "Resolution Seal of the Learned"
        case .streak: return "Resolution Seal of the Devoted"
        case .score: return "Resolution Seal of the Skilled"
        case .games: return "Resolution Seal of the Eager"
        }
    }

    var achievementCardParaibaStyle: String {
        isRareAchievement ? "electric" : "pale"
    }

    var achievementAscendancyThreshold: Int {
        switch category {
        case .mastery: return 5000000
        case .streak: return 2000000
        case .score: return 3000000
        case .games: return 500000
        }
    }

    var achievementCardPadparadschaStyle: String {
        isRareAchievement ? "sunset" : "peach"
    }

    var achievementRequiresMettle: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardDecreeWritSealText: String {
        switch category {
        case .mastery: return "Decree Writ Seal of the Academy"
        case .streak: return "Decree Writ Seal of the Order"
        case .score: return "Decree Writ Seal of the Arena"
        case .games: return "Decree Writ Seal of the Commons"
        }
    }

    var achievementCardDemantoidStyle: String {
        isRareAchievement ? "fire" : "green"
    }

    var achievementSupremacyThreshold: Int {
        switch category {
        case .mastery: return 7500000
        case .streak: return 3000000
        case .score: return 5000000
        case .games: return 750000
        }
    }

    var achievementCardTsavoriteStyle: String {
        isRareAchievement ? "emerald" : "olive"
    }

    var achievementRequiresPassion: Bool {
        category == .score || category == .mastery
    }

    var achievementCardEdictWritText: String {
        switch category {
        case .mastery: return "Edict Writ of the Grand Master"
        case .streak: return "Edict Writ of the Faithful"
        case .score: return "Edict Writ of the Champion"
        case .games: return "Edict Writ of the Initiate"
        }
    }

    var achievementCardChrysoCollaStyle: String {
        isRareAchievement ? "turquoise" : "green"
    }

    var achievementHegemonyThreshold: Int {
        switch category {
        case .mastery: return 10000000
        case .streak: return 5000000
        case .score: return 7500000
        case .games: return 1000000
        }
    }

    var achievementCardKornerupineStyle: String {
        isRareAchievement ? "pleochroic" : "brown"
    }

    var achievementRequiresBackbone: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardCovenantWritText: String {
        switch category {
        case .mastery: return "Covenant Writ of Mastery"
        case .streak: return "Covenant Writ of Perseverance"
        case .score: return "Covenant Writ of Valor"
        case .games: return "Covenant Writ of Fellowship"
        }
    }

    var achievementCardHackmaniteStyle: String {
        isRareAchievement ? "tenebrescent" : "pink"
    }

    var achievementImperiumThreshold: Int {
        switch category {
        case .mastery: return 15000000
        case .streak: return 7500000
        case .score: return 10000000
        case .games: return 1500000
        }
    }

    var achievementCardClinohumiteStyle: String {
        isRareAchievement ? "amber" : "dull"
    }

    var achievementRequiresNerve: Bool {
        category == .score || category == .mastery
    }

    var achievementCardCharterWritText: String {
        switch category {
        case .mastery: return "Charter Writ of the Academy"
        case .streak: return "Charter Writ of the Order"
        case .score: return "Charter Writ of the Guild"
        case .games: return "Charter Writ of the Commons"
        }
    }

    var achievementCardScapoliteStyle: String {
        isRareAchievement ? "golden" : "white"
    }

    var achievementPantheonThreshold: Int {
        switch category {
        case .mastery: return 20000000
        case .streak: return 10000000
        case .score: return 15000000
        case .games: return 2000000
        }
    }
}
