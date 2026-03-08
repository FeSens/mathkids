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
}
