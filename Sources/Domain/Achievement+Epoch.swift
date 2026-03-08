import Foundation

extension Achievement {
    var achievementCardDiasporeStyle: String {
        isRareAchievement ? "color-shift" : "grey"
    }

    var achievementRequiresPluck: Bool {
        category == .score || category == .mastery
    }

    var achievementCardMandateWritText: String {
        switch category {
        case .mastery: return "Mandate Writ of the Scholar"
        case .streak: return "Mandate Writ of the Guardian"
        case .score: return "Mandate Writ of the Victor"
        case .games: return "Mandate Writ of the Newcomer"
        }
    }

    var achievementCardRhodoliteStyle: String {
        isRareAchievement ? "raspberry" : "rose"
    }

    var achievementInfinityThreshold: Int {
        switch category {
        case .mastery: return 100000000
        case .streak: return 50000000
        case .score: return 75000000
        case .games: return 10000000
        }
    }

    var achievementCardChrysanthemumStyle: String {
        isRareAchievement ? "blooming" : "plain"
    }

    var achievementRequiresGuts: Bool {
        category == .streak
    }

    var achievementCardStatuteWritText: String {
        switch category {
        case .mastery: return "Statute Writ of Enlightenment"
        case .streak: return "Statute Writ of Constancy"
        case .score: return "Statute Writ of Triumph"
        case .games: return "Statute Writ of Initiation"
        }
    }

    var achievementCardSpessartineStyle: String {
        isRareAchievement ? "mandarin" : "orange"
    }

    var achievementApotheosisThreshold: Int {
        switch category {
        case .mastery: return 250000000
        case .streak: return 100000000
        case .score: return 200000000
        case .games: return 25000000
        }
    }

    var achievementCardCupriteStyle: String {
        isRareAchievement ? "ruby" : "copper"
    }

    var achievementRequiresHeart: Bool {
        category == .games
    }

    var achievementCardDirectiveWritText: String {
        switch category {
        case .mastery: return "Directive Writ of Knowledge"
        case .streak: return "Directive Writ of Persistence"
        case .score: return "Directive Writ of Achievement"
        case .games: return "Directive Writ of Participation"
        }
    }

    var achievementCardEnstatiteStyle: String {
        isRareAchievement ? "bronze" : "grey"
    }

    var achievementOmnipotenceThreshold: Int {
        switch category {
        case .mastery: return 500000000
        case .streak: return 250000000
        case .score: return 350000000
        case .games: return 50000000
        }
    }

    var achievementCardCassiteriteStyle: String {
        isRareAchievement ? "adamantine" : "dark"
    }

    var achievementRequiresSpine: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardInjunctionWritText: String {
        switch category {
        case .mastery: return "Injunction Writ of the Wise"
        case .streak: return "Injunction Writ of the Steadfast"
        case .score: return "Injunction Writ of the Bold"
        case .games: return "Injunction Writ of the Willing"
        }
    }

    var achievementCardSillimaniteStyle: String {
        isRareAchievement ? "fibrous" : "white"
    }

    var achievementParagonThreshold: Int {
        switch category {
        case .mastery: return 750000000
        case .streak: return 500000000
        case .score: return 600000000
        case .games: return 75000000
        }
    }
}
