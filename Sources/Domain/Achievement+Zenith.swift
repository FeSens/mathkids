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

    var achievementCardValentiniteStyle: String {
        isRareAchievement ? "pearlescent" : "chalky"
    }

    var achievementRequiresSpinePlus: Bool {
        category == .mastery || category == .score
    }

    var achievementCardStatuteWritSealText: String {
        switch category {
        case .mastery: return "Statute Writ Seal of the Sage"
        case .streak: return "Statute Writ Seal of the Vigilant"
        case .score: return "Statute Writ Seal of the Valiant"
        case .games: return "Statute Writ Seal of the Seeker"
        }
    }

    var achievementCardArsenopyriteStyle: String {
        isRareAchievement ? "steel lustre" : "tin"
    }

    var achievementDominionPlusThreshold: Int {
        switch category {
        case .mastery: return 3500
        case .streak: return 1500
        case .score: return 3000
        case .games: return 350
        }
    }

    var achievementCardCobaltiteStyle: String {
        isRareAchievement ? "cobalt blue" : "grey blue"
    }

    var achievementRequiresHeartPlus: Bool {
        category == .games || category == .streak
    }

    var achievementCardDirectiveWritSealText: String {
        switch category {
        case .mastery: return "Directive Writ Seal of the Oracle"
        case .streak: return "Directive Writ Seal of the Protector"
        case .score: return "Directive Writ Seal of the Champion"
        case .games: return "Directive Writ Seal of the Wanderer"
        }
    }

    var achievementCardSkutteruditeStyle: String {
        isRareAchievement ? "bright silver" : "dull silver"
    }

    var achievementEminencePlusThreshold: Int {
        switch category {
        case .mastery: return 5000
        case .streak: return 2000
        case .score: return 4000
        case .games: return 500
        }
    }

    var achievementCardLoellingiteStyle: String {
        isRareAchievement ? "silver white" : "pewter"
    }

    var achievementRequiresGutsPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardInjunctionWritSealText: String {
        switch category {
        case .mastery: return "Injunction Writ Seal of the Patriarch"
        case .streak: return "Injunction Writ Seal of the Defender"
        case .score: return "Injunction Writ Seal of the Gladiator"
        case .games: return "Injunction Writ Seal of the Recruit"
        }
    }

    var achievementCardGersdorffiteStyle: String {
        isRareAchievement ? "nickel sheen" : "dull grey"
    }

    var achievementPinnaclePlusThreshold: Int {
        switch category {
        case .mastery: return 7500
        case .streak: return 3000
        case .score: return 6000
        case .games: return 750
        }
    }

    var achievementCardUllmanniteStyle: String {
        isRareAchievement ? "steel grey lustre" : "charcoal"
    }

    var achievementRequiresPluckPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardResolutionWritSealText: String {
        switch category {
        case .mastery: return "Resolution Writ Seal of the Sovereign"
        case .streak: return "Resolution Writ Seal of the Faithful"
        case .score: return "Resolution Writ Seal of the Triumphant"
        case .games: return "Resolution Writ Seal of the Aspirant"
        }
    }

    var achievementCardRammelsbergiteStyle: String {
        isRareAchievement ? "tin white" : "ash"
    }

    var achievementZenithPlusPlusThreshold: Int {
        switch category {
        case .mastery: return 10000
        case .streak: return 4000
        case .score: return 8000
        case .games: return 1000
        }
    }
}
