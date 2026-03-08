import Foundation

extension Achievement {
    var achievementCardLarimarStyle: String {
        isRareAchievement ? "volcanic" : "oceanic"
    }

    var achievementRequiresGrowth: Bool {
        category == .mastery || category == .score
    }

    var achievementCardCovenantText: String {
        switch category {
        case .mastery: return "Covenant of Mastery"
        case .streak: return "Covenant of Perseverance"
        case .score: return "Covenant of Valor"
        case .games: return "Covenant of Fellowship"
        }
    }

    var achievementCardSodaliteStyle: String {
        isRareAchievement ? "royal" : "muted"
    }

    var achievementLegendThreshold: Int {
        switch category {
        case .mastery: return 1000
        case .streak: return 365
        case .score: return 500
        case .games: return 100
        }
    }

    var achievementCardHowliteStyle: String {
        isRareAchievement ? "veined" : "smooth"
    }

    var achievementRequiresTenacity: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardCharter: String {
        switch category {
        case .mastery: return "Charter of the Academy"
        case .streak: return "Charter of the Order"
        case .score: return "Charter of the Guild"
        case .games: return "Charter of the Commons"
        }
    }

    var achievementCardChalcedonyStyle: String {
        isRareAchievement ? "banded" : "plain"
    }

    var achievementMythicThreshold: Int {
        switch category {
        case .mastery: return 2000
        case .streak: return 500
        case .score: return 1000
        case .games: return 200
        }
    }

    var achievementCardSunstoneStyle: String {
        isRareAchievement ? "blazing" : "warm"
    }

    var achievementRequiresDetermination: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardAccordText: String {
        switch category {
        case .mastery: return "Accord of Wisdom"
        case .streak: return "Accord of Loyalty"
        case .score: return "Accord of Honor"
        case .games: return "Accord of Welcome"
        }
    }

    var achievementCardPrehniteStyle: String {
        isRareAchievement ? "glowing" : "matte"
    }

    var achievementAscensionThreshold: Int {
        switch category {
        case .mastery: return 5000
        case .streak: return 1000
        case .score: return 2500
        case .games: return 500
        }
    }

    var achievementCardRhodoniteStyle: String {
        isRareAchievement ? "rosy" : "grey"
    }

    var achievementRequiresFortitude: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardCompactText: String {
        switch category {
        case .mastery: return "Compact of Scholars"
        case .streak: return "Compact of Guardians"
        case .score: return "Compact of Warriors"
        case .games: return "Compact of Adventurers"
        }
    }

    var achievementCardChrysopraseStyle: String {
        isRareAchievement ? "vivid" : "pale"
    }

    var achievementTranscendenceThreshold: Int {
        switch category {
        case .mastery: return 10000
        case .streak: return 2000
        case .score: return 5000
        case .games: return 1000
        }
    }

    var achievementCardAmazoniteStyle: String {
        isRareAchievement ? "teal" : "faded"
    }

    var achievementRequiresValor: Bool {
        category == .score || category == .mastery
    }

    var achievementCardStatuteText: String {
        switch category {
        case .mastery: return "Statute of Enlightenment"
        case .streak: return "Statute of Constancy"
        case .score: return "Statute of Triumph"
        case .games: return "Statute of Initiation"
        }
    }

    var achievementCardSeraphiniteStyle: String {
        isRareAchievement ? "chatoyant" : "dull"
    }

    var achievementEnlightenmentThreshold: Int {
        switch category {
        case .mastery: return 15000
        case .streak: return 3000
        case .score: return 7500
        case .games: return 1500
        }
    }

    var achievementCardLarimarFrostStyle: String {
        isRareAchievement ? "crystalline" : "cloudy"
    }

    var achievementRequiresAmbition: Bool {
        category == .mastery || category == .score
    }

    var achievementCardOrdinanceText: String {
        switch category {
        case .mastery: return "Ordinance of Wisdom"
        case .streak: return "Ordinance of Loyalty"
        case .score: return "Ordinance of Merit"
        case .games: return "Ordinance of Welcome"
        }
    }

    var achievementCardLepidoliteStyle: String {
        isRareAchievement ? "shimmering" : "flat"
    }

    var achievementSovereigntyThreshold: Int {
        switch category {
        case .mastery: return 20000
        case .streak: return 5000
        case .score: return 10000
        case .games: return 2000
        }
    }

    var achievementCardFluoriteStyle: String {
        isRareAchievement ? "banded" : "clear"
    }

    var achievementRequiresCourage: Bool {
        category == .score || category == .mastery
    }

    var achievementCardWritText: String {
        switch category {
        case .mastery: return "Writ of Mastery"
        case .streak: return "Writ of Endurance"
        case .score: return "Writ of Excellence"
        case .games: return "Writ of Admission"
        }
    }

    var achievementCardDumortieriteStyle: String {
        isRareAchievement ? "deep blue" : "pale"
    }

    var achievementDominionThreshold: Int {
        switch category {
        case .mastery: return 25000
        case .streak: return 7500
        case .score: return 12500
        case .games: return 2500
        }
    }

    var achievementCardCharoiteStyle: String {
        isRareAchievement ? "swirling" : "muted"
    }

    var achievementRequiresDiligence: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardMandateText: String {
        switch category {
        case .mastery: return "Mandate of the Scholar"
        case .streak: return "Mandate of the Guardian"
        case .score: return "Mandate of the Victor"
        case .games: return "Mandate of the Newcomer"
        }
    }

    var achievementCardSugiliteStyle: String {
        isRareAchievement ? "vibrant" : "dusty"
    }

    var achievementEminenceThreshold: Int {
        switch category {
        case .mastery: return 30000
        case .streak: return 10000
        case .score: return 15000
        case .games: return 3000
        }
    }

    var achievementCardUnakiteStyle: String {
        isRareAchievement ? "mossy" : "plain"
    }

    var achievementRequiresGrit: Bool {
        category == .streak || category == .score
    }

    var achievementCardDirectiveText: String {
        switch category {
        case .mastery: return "Directive of Knowledge"
        case .streak: return "Directive of Persistence"
        case .score: return "Directive of Achievement"
        case .games: return "Directive of Participation"
        }
    }

    var achievementCardBloodstoneStyle: String {
        isRareAchievement ? "spotted" : "dark"
    }

    var achievementPinnacleThreshold: Int {
        switch category {
        case .mastery: return 50000
        case .streak: return 15000
        case .score: return 25000
        case .games: return 5000
        }
    }

    var achievementCardHowliteFrostStyle: String {
        isRareAchievement ? "icy" : "chalky"
    }

    var achievementRequiresResolve: Bool {
        category == .mastery || category == .streak
    }

    var achievementCardInjunctionText: String {
        switch category {
        case .mastery: return "Injunction of the Wise"
        case .streak: return "Injunction of the Steadfast"
        case .score: return "Injunction of the Bold"
        case .games: return "Injunction of the Willing"
        }
    }

    var achievementCardHawkEyeStyle: String {
        isRareAchievement ? "striped" : "grey"
    }

    var achievementZenithThreshold: Int {
        switch category {
        case .mastery: return 75000
        case .streak: return 20000
        case .score: return 50000
        case .games: return 7500
        }
    }
}
