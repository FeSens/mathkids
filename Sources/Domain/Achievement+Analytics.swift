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

    var achievementRewardDescription: String {
        "\(achievementCoinValue) coins and \(achievementGemValue) gems"
    }

    var achievementIsTimeLimited: Bool {
        false
    }

    var achievementSortIndex: Int {
        achievementCategoryWeight * 50 + pointValue
    }

    var achievementBadgeRotation: Double {
        isRareAchievement ? 15.0 : 0.0
    }

    var achievementUnlockRequirementCount: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }

    var achievementParentCategory: String {
        switch category {
        case .mastery, .streak: return "performance"
        case .score, .games: return "participation"
        }
    }

    var achievementIsAutoTracked: Bool {
        true
    }

    var achievementMaxLevel: Int {
        switch category {
        case .mastery: return 10
        case .streak: return 5
        case .score: return 3
        case .games: return 1
        }
    }

    var achievementBonusMultiplier: Int {
        isRareAchievement ? 3 : 1
    }

    var achievementCelebrationDuration: Double {
        isRareAchievement ? 5.0 : 1.0
    }

    var achievementIsStackable: Bool {
        category == .mastery || category == .streak
    }

    var achievementAlertBody: String {
        "You earned \(title): \(description)"
    }

    var achievementLeaderboardPoints: Int {
        pointValue * achievementBonusMultiplier
    }

    var achievementProgressStep: Int {
        1
    }

    var achievementShowInProfile: Bool {
        isRareAchievement
    }

    var achievementTierName: String {
        isRareAchievement ? "Legendary" : "Common"
    }

    var achievementAnimationDelay: Double {
        isRareAchievement ? 0.5 : 0
    }

    var achievementRequiresConnection: Bool {
        false
    }

    var achievementPointsPerMinute: Double {
        Double(pointValue) / Double(achievementEstimatedTimeMinutes)
    }

    var achievementCardShadowColor: String {
        isRareAchievement ? "gold" : "gray"
    }

    var achievementUnlockOrder: Int {
        switch category {
        case .games: return 1
        case .score: return 2
        case .streak: return 3
        case .mastery: return 4
        }
    }

    var achievementCardCornerStyle: String {
        isRareAchievement ? "rounded" : "square"
    }

    var achievementCompletionSound: String {
        isRareAchievement ? "fanfare" : "chime"
    }

    var achievementSkillCategory: String {
        switch category {
        case .mastery: return "math"
        case .streak: return "persistence"
        case .score: return "performance"
        case .games: return "engagement"
        }
    }

    var achievementIsShareable: Bool {
        true
    }

    var achievementFlavorDescription: String {
        switch category {
        case .streak: return "On fire! Keep the streak burning!"
        case .score: return "Score champion in the making!"
        case .games: return "Game explorer extraordinaire!"
        case .mastery: return "A true master of mathematics!"
        }
    }

    var achievementWeeklyTarget: Int {
        switch category {
        case .mastery: return 5
        case .streak: return 3
        case .score: return 2
        case .games: return 1
        }
    }

    var achievementChallengeDescription: String {
        "Challenge: Unlock \(title)"
    }

    var achievementIsBonus: Bool {
        isRareAchievement
    }

    var achievementProgressLabel: String {
        switch category {
        case .mastery: return "0% complete"
        case .streak: return "0 days"
        case .score: return "0 points"
        case .games: return "0 count"
        }
    }
}
