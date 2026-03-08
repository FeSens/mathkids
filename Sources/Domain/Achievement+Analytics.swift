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
}
