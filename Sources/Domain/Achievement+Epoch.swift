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
}
