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

    var difficultyAccessibilityLabel: String {
        "\(displayName) difficulty"
    }

    var difficultySpeedLabel: String {
        switch self {
        case .easy: return "Relaxed"
        case .medium: return "Moderate"
        case .hard: return "Fast"
        }
    }

    var difficultyUnlockMessage: String {
        switch self {
        case .easy: return "Available from the start!"
        case .medium: return "Unlocked! Ready for more?"
        case .hard: return "Unlocked! Show what you know!"
        }
    }

    var difficultyIsBeginner: Bool {
        self == .easy
    }

    var difficultyBadgeText: String {
        String(displayName.prefix(1))
    }
}
