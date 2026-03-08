import Foundation

extension Achievement {
    var achievementCompactDescription: String {
        "\(emoji) \(title)"
    }

    var achievementNotificationIcon: String {
        switch category {
        case .mastery: return "trophy.fill"
        case .streak: return "flame.fill"
        case .score: return "star.fill"
        case .games: return "gamecontroller.fill"
        }
    }

    var achievementShowConfetti: Bool {
        isRareAchievement
    }

    var achievementDetailURL: String {
        "/achievements/\(id)"
    }

    var achievementEarnedLabel: String {
        "Not Earned"
    }
}
