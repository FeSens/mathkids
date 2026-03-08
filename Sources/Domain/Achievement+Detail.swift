import Foundation

extension Achievement {
    var achievementDetailDescription: String {
        "\(description) — \(category.displayName) achievement"
    }

    var achievementProgressTarget: Int {
        switch category {
        case .mastery: return 100
        case .streak: return 20
        case .score: return 10
        case .games: return 1
        }
    }
}
