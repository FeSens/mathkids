import Foundation

extension Achievement {
    var achievementCardParchmentStyle: String {
        isRareAchievement ? "aged" : "fresh"
    }

    var achievementRequiresEndurance: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardDictumText: String {
        switch category {
        case .mastery: return "To know is to conquer"
        case .streak: return "To persist is to prevail"
        case .score: return "To score is to succeed"
        case .games: return "To play is to begin"
        }
    }

    var achievementCardJadeStyle: String {
        isRareAchievement ? "imperial" : "rough"
    }

    var achievementCheckpointCount: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }
}
