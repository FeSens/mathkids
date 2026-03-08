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
}
