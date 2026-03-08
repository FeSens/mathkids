import Foundation

extension Achievement {
    var achievementSocialText: String {
        "I unlocked \(title) in MathKids! \(emoji)"
    }

    var achievementProgressFormat: String {
        switch category {
        case .mastery: return "Progress: %"
        case .streak: return "Progress: days"
        case .score: return "Progress: points"
        case .games: return "Progress: count"
        }
    }

    var achievementUnlockAnimation: String {
        isRareAchievement ? "fireworks" : "fade"
    }

    var achievementAlertTitle: String {
        "Achievement Unlocked: \(title)"
    }

    var achievementXpValue: Int {
        pointValue * achievementChallengeRating
    }

    var achievementIsLegendary: Bool {
        isRareAchievement && category == .mastery
    }

    var achievementProgressPercentage: Int {
        0
    }

    var achievementMotivationalQuote: String {
        switch category {
        case .streak: return "Stay consistent and great things happen!"
        case .score: return "Every point counts on the path to greatness!"
        case .games: return "Every game is a step forward!"
        case .mastery: return "Excellence comes through dedication!"
        }
    }

    var achievementBadgeOpacity: Double {
        0.5
    }

    var achievementDailyGoalContribution: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementStreakMultiplier: Double {
        switch category {
        case .streak: return 2.5
        case .mastery: return 2.0
        case .score: return 1.5
        case .games: return 1.0
        }
    }

    var achievementCategoryEmoji: String {
        switch category {
        case .streak: return "🔥"
        case .score: return "⭐"
        case .games: return "🎮"
        case .mastery: return "👑"
        }
    }

    var achievementChallengeTier: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 3
        case .score: return 2
        case .games: return 1
        }
    }

    var achievementEstimatedTimeMinutes: Int {
        switch category {
        case .mastery: return 120
        case .streak: return 30
        case .score: return 15
        case .games: return 2
        }
    }

    var achievementBorderStyle: String {
        isRareAchievement ? "gold" : "silver"
    }

    var achievementCategoryWeight: Int {
        switch category {
        case .mastery: return 4
        case .streak: return 3
        case .score: return 2
        case .games: return 1
        }
    }

    var achievementAccessibilityValue: String {
        "\(pointValue) points, \(category.displayName) category"
    }
}
