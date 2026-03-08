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

    var achievementCardShadowOpacity: Double {
        isRareAchievement ? 0.4 : 0.1
    }

    var achievementRequiredDays: Int {
        switch category {
        case .mastery: return 30
        case .streak: return 7
        case .score: return 0
        case .games: return 0
        }
    }

    var achievementCardHeaderStyle: String {
        isRareAchievement ? "prominent" : "compact"
    }

    var achievementIsPassive: Bool {
        category == .games
    }

    var achievementRewardLabelText: String {
        "+\(pointValue) pts"
    }

    var achievementCardTagColor: String {
        switch category {
        case .mastery: return "purple"
        case .streak: return "red"
        case .score: return "blue"
        case .games: return "green"
        }
    }

    var achievementMinGamesPlayed: Int {
        switch category {
        case .mastery: return 25
        case .streak: return 5
        case .score: return 5
        case .games: return 1
        }
    }

    var achievementCardLayoutMode: String {
        isRareAchievement ? "expanded" : "compact"
    }

    var achievementIsEnduranceBased: Bool {
        category == .streak || category == .mastery
    }

    var achievementCardSubtitleText: String {
        "\(category.displayName) challenge"
    }

    var achievementCardEmojiOffset: Double {
        isRareAchievement ? -4 : 0
    }

    var achievementStreakMultiplierValue: Double {
        category == .streak ? 1.5 : 1.0
    }

    var achievementCardBorderColor: String {
        switch category {
        case .mastery: return "indigo"
        case .streak: return "orange"
        case .score: return "blue"
        case .games: return "gray"
        }
    }

    var achievementIsGoalOriented: Bool {
        category == .mastery || category == .score
    }

    var achievementCardInfoLabel: String {
        "\(category.displayName) — \(pointValue) pts"
    }
}
