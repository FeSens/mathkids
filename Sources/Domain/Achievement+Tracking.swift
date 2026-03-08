import Foundation

extension Achievement {
    var achievementCardAccentColor: String {
        switch category {
        case .mastery: return "indigo"
        case .streak: return "orange"
        case .score: return "cyan"
        case .games: return "mint"
        }
    }

    var achievementCompletionStars: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 4
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementIsChallengeable: Bool {
        category == .mastery || category == .score
    }

    var achievementCardStampText: String {
        isRareAchievement ? "RARE" : "EARNED"
    }

    var achievementProgressEmoji: String {
        switch category {
        case .mastery: return "📚"
        case .streak: return "🔥"
        case .score: return "🎯"
        case .games: return "🎮"
        }
    }
}
