import Foundation

extension Achievement {
    var achievementRotationAngle: Int {
        isRareAchievement ? 2 : 0
    }

    var achievementStatusLabel: String {
        progress != nil ? "In Progress" : "Locked"
    }

    var achievementCategoryColorHex: String {
        switch category {
        case .streak: return "FF8C00"
        case .score: return "007AFF"
        case .games: return "34C759"
        case .mastery: return "AF52DE"
        }
    }

    var achievementPreviewSummary: String {
        "\(title) - \(pointValue) pts"
    }

    var achievementIsPinnable: Bool {
        !achievementIsSecret
    }

    var achievementNotificationSoundName: String {
        isRareAchievement ? "achievement_epic" : "achievement_basic"
    }

    var achievementCategoryIndex: Int {
        switch category {
        case .games: return 0
        case .streak: return 1
        case .score: return 2
        case .mastery: return 3
        }
    }

    var achievementShareImageName: String {
        "share_\(category.displayName.lowercased())"
    }

    var achievementHasCustomBackground: Bool {
        achievementIsPremium
    }

    var achievementGridItemSize: String {
        switch achievementGridColumns {
        case 1: return "full"
        case 2: return "half"
        default: return "third"
        }
    }

    var achievementTimeEstimate: Int {
        switch category {
        case .mastery: return 60
        case .streak: return 30
        case .score: return 20
        case .games: return 10
        }
    }

    var achievementBannerText: String {
        "\(emoji) \(title) Unlocked!"
    }

    var achievementIsDailyChallenge: Bool {
        category == .streak
    }

    var achievementOutlineColor: String {
        if progress != nil {
            return achievementCardColor
        }
        return "gray"
    }

    var achievementXpMultiplier: Double {
        isRareAchievement ? 2.0 : 1.0
    }
}
