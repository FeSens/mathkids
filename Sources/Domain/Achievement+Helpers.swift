import Foundation

extension Achievement {
    var progressDescription: String {
        "\(title): \(description)"
    }

    var isHidden: Bool {
        isRareAchievement
    }

    var pointValue: Int {
        if isRareAchievement { return 50 }
        switch category {
        case .mastery: return 25
        case .streak, .score: return 15
        case .games: return 10
        }
    }

    var badgeColor: String {
        switch category {
        case .streak: return "orange"
        case .score: return "gold"
        case .games: return "blue"
        case .mastery: return "purple"
        }
    }

    var shareText: String {
        "I earned the \(title) achievement! \(emoji)"
    }
}
