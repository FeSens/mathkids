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

    var difficultyShareText: String {
        "Playing on \(displayName) difficulty!"
    }

    var difficultyIsAdvanced: Bool {
        self == .hard
    }

    var difficultyRewardMultiplier: Int {
        progressionIndex
    }

    var difficultyIconName: String {
        switch self {
        case .easy: return "tortoise"
        case .medium: return "hare"
        case .hard: return "bolt"
        }
    }

    var difficultyCompletionMessage: String {
        switch self {
        case .easy: return "Well done! Keep practicing!"
        case .medium: return "Great work on medium!"
        case .hard: return "Amazing! You conquered hard mode!"
        }
    }

    var difficultyTargetScore: Int {
        switch self {
        case .easy: return 50
        case .medium: return 100
        case .hard: return 150
        }
    }

    var difficultyIsIntermediate: Bool {
        self == .medium
    }

    var difficultyDescriptionText: String {
        switch self {
        case .easy: return "Simple problems with plenty of time"
        case .medium: return "Moderate challenge with all operations"
        case .hard: return "Tough problems under time pressure"
        }
    }

    var difficultyThemeColor: String {
        switch self {
        case .easy: return "green"
        case .medium: return "orange"
        case .hard: return "red"
        }
    }

    var difficultyMinAccuracyForMastery: Int {
        switch self {
        case .easy: return 80
        case .medium: return 85
        case .hard: return 90
        }
    }

    var difficultyTimerWarningThreshold: Int {
        switch self {
        case .easy: return 30
        case .medium: return 20
        case .hard: return 15
        }
    }

    var difficultyStarString: String {
        String(repeating: "★", count: progressionIndex)
    }

    var difficultyShortDescription: String {
        switch self {
        case .easy: return "Simple"
        case .medium: return "Moderate"
        case .hard: return "Challenging"
        }
    }

    var difficultyHasTimePressure: Bool {
        self == .hard
    }

    var difficultyNextLevelName: String? {
        nextDifficulty?.displayName
    }
}
