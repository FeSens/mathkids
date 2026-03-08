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
}
