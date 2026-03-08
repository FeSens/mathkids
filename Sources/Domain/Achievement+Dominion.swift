import Foundation

extension Achievement {
    var achievementCardSarabauitePlusStyle: String {
        isRareAchievement ? "reddish brown prismatic" : "dull brown"
    }

    var achievementRequiresFaithPlus: Bool {
        category == .mastery || category == .games
    }

    var achievementCardAccordWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Accord Writ Seal Ultra Plus of the Divine"
        case .streak: return "Accord Writ Seal Ultra Plus of the Stalwart"
        case .score: return "Accord Writ Seal Ultra Plus of the Resplendent"
        case .games: return "Accord Writ Seal Ultra Plus of the Seeker"
        }
    }

    var achievementCardKermesiniteStyle: String {
        isRareAchievement ? "cherry red acicular" : "dull red"
    }

    var achievementOlympusPlusThreshold: Int {
        switch category {
        case .mastery: return 55000000
        case .streak: return 22000000
        case .score: return 50000000
        case .games: return 5500000
        }
    }

    var achievementCardLivingstoniteProStyle: String {
        isRareAchievement ? "blackish grey prismatic" : "dull charcoal"
    }

    var achievementRequiresDutyPlus: Bool {
        category == .streak || category == .score
    }

    var achievementCardMandateWritSealUltraPlusText: String {
        switch category {
        case .mastery: return "Mandate Writ Seal Ultra Plus of the Immortal"
        case .streak: return "Mandate Writ Seal Ultra Plus of the Fortress"
        case .score: return "Mandate Writ Seal Ultra Plus of the Glorious"
        case .games: return "Mandate Writ Seal Ultra Plus of the Disciple"
        }
    }

    var achievementCardGuettarditeStyle: String {
        isRareAchievement ? "lead grey monoclinic" : "flat lead"
    }

    var achievementAsgardPlusThreshold: Int {
        switch category {
        case .mastery: return 60000000
        case .streak: return 24000000
        case .score: return 55000000
        case .games: return 6000000
        }
    }
}
