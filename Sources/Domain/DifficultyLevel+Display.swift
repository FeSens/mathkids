import Foundation

extension DifficultyLevel {
    var difficultyEmoji: String {
        switch self {
        case .easy: return "🟢"
        case .medium: return "🟡"
        case .hard: return "🔴"
        }
    }

    var difficultyStarRating: Int {
        progressionIndex
    }

    var difficultyCardLabel: String {
        "\(difficultyEmoji) \(displayName)"
    }

    var difficultyMotivationText: String {
        switch self {
        case .easy: return "Perfect for warming up!"
        case .medium: return "Challenge yourself!"
        case .hard: return "Push your limits!"
        }
    }

    var difficultyIsDefault: Bool {
        self == .easy
    }
}
