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

    var achievementCardOpalStyle: String {
        isRareAchievement ? "fire" : "common"
    }

    var achievementRequiresPatience: Bool {
        category == .streak
    }

    var achievementCardEdictText: String {
        switch category {
        case .mastery: return "By decree of mastery"
        case .streak: return "By decree of persistence"
        case .score: return "By decree of excellence"
        case .games: return "By decree of participation"
        }
    }

    var achievementCardAmethystStyle: String {
        isRareAchievement ? "royal" : "pale"
    }

    var achievementProgressSteps: Int {
        switch category {
        case .mastery: return 20
        case .streak: return 7
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardTopazStyle: String {
        isRareAchievement ? "imperial" : "plain"
    }

    var achievementRequiresFocus: Bool {
        category == .score || category == .mastery
    }

    var achievementCardDecreeText: String {
        switch category {
        case .mastery: return "Decree of the Grand Master"
        case .streak: return "Decree of the Faithful"
        case .score: return "Decree of the Champion"
        case .games: return "Decree of the Initiate"
        }
    }

    var achievementCardGarnetStyle: String {
        isRareAchievement ? "deep" : "light"
    }

    var achievementRewardTierLevel: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 4
        case .score: return 3
        case .games: return 1
        }
    }
}
