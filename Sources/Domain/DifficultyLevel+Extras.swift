import Foundation

extension DifficultyLevel {
    var detailedOverview: String {
        "\(displayName): \(operandRange.lowerBound)-\(operandRange.upperBound) range, \(timeLimitSeconds)s time limit, \(operationCount) operations"
    }

    func isRecommendedFor(accuracy: Double) -> Bool {
        switch self {
        case .easy: return accuracy < 70
        case .medium: return accuracy >= 60 && accuracy < 85
        case .hard: return accuracy >= 80
        }
    }

    var timeLimitFormatted: String {
        let mins = timeLimitSeconds / 60
        let secs = timeLimitSeconds % 60
        return "\(mins):\(String(format: "%02d", secs))"
    }

    var operationList: String {
        allowedOperations.map(\.displayName).joined(separator: ", ")
    }

    var scoreRangeText: String {
        let low = maxPossibleScore / 4
        let high = maxPossibleScore
        return "\(low)-\(high) pts"
    }

    var maxStreakBonus: Int {
        switch self {
        case .easy: return 10
        case .medium: return 20
        case .hard: return 30
        }
    }

    var difficultyStars: Int {
        progressionIndex
    }

    var problemComplexity: String {
        switch self {
        case .easy: return "simple"
        case .medium: return "moderate"
        case .hard: return "complex"
        }
    }

    var estimatedSessionMinutes: Int {
        timeLimitSeconds / 60
    }

    var recommendedAge: String {
        switch self {
        case .easy: return "5-7"
        case .medium: return "7-9"
        case .hard: return "9-12"
        }
    }

    var penaltyDescription: String {
        "-\(penaltyPerWrong) point penalty per wrong answer"
    }

    var isMultiplicationIncluded: Bool {
        allowedOperations.contains(.multiply)
    }

    var isDivisionIncluded: Bool {
        allowedOperations.contains(.divide)
    }

    var levelUpRequirement: String {
        guard let next = nextDifficulty else { return "Max difficulty reached!" }
        return "Score \(targetAccuracy)% accuracy to unlock \(next.displayName)"
    }

    var averageGameLength: Int {
        estimatedProblemsPerGame
    }

    var maxOperandDisplay: String {
        "Numbers up to \(operandRange.upperBound)"
    }

    var speedRequirement: String {
        "\(recommendedSecondsPerProblem) seconds per problem"
    }

    var bonusPointsAvailable: Int {
        maxStreakBonus + estimatedProblemsPerGame * 2
    }

    var isBeginnerFriendly: Bool {
        self == .easy
    }

    var completionMessage: String {
        switch self {
        case .easy: return "Great practice session!"
        case .medium: return "Nice work on medium difficulty!"
        case .hard: return "Impressive! You tackled hard mode!"
        }
    }

    var numberOfOperations: String {
        let count = operationCount
        return count == 1 ? "1 operation" : "\(count) operations"
    }

    var difficultyPercentage: Int {
        switch self {
        case .easy: return 33
        case .medium: return 66
        case .hard: return 100
        }
    }

    var practiceRecommendation: String {
        switch self {
        case .easy: return "Practice basic addition and subtraction"
        case .medium: return "Work on multiplication tables"
        case .hard: return "Master all four operations with larger numbers"
        }
    }

    var iconName: String {
        switch self {
        case .easy: return "star"
        case .medium: return "star.leadinghalf.filled"
        case .hard: return "star.fill"
        }
    }

    var warmupProblems: Int {
        switch self {
        case .easy: return 0
        case .medium: return 2
        case .hard: return 3
        }
    }

    var hasTimePressure: Bool {
        recommendedSecondsPerProblem <= 4
    }

    var badgeText: String {
        String(displayName.prefix(1))
    }

    var averageAccuracy: Int {
        switch self {
        case .easy: return 85
        case .medium: return 70
        case .hard: return 55
        }
    }

    var expectedProblemsPerMinute: Int {
        60 / recommendedSecondsPerProblem
    }

    var motivationalQuote: String {
        switch self {
        case .easy: return "Every math journey starts here!"
        case .medium: return "You're getting stronger!"
        case .hard: return "Champions play on hard mode!"
        }
    }

    var requiredOperationCount: String {
        "\(operationCount) operation\(operationCount == 1 ? "" : "s") required"
    }

    var difficultyColorName: String {
        switch self {
        case .easy: return "green"
        case .medium: return "orange"
        case .hard: return "red"
        }
    }

    var timeLimitDescription: String {
        "\(timeLimitSeconds) seconds to complete all problems"
    }

    var difficultyTag: String {
        switch self {
        case .easy: return "EASY"
        case .medium: return "MEDIUM"
        case .hard: return "HARD"
        }
    }

    var timeBracket: String {
        if timeLimitSeconds <= 60 { return "short" }
        if timeLimitSeconds <= 120 { return "medium" }
        return "long"
    }

    var difficultyAbbreviation: String {
        switch self {
        case .easy: return "EZ"
        case .medium: return "MED"
        case .hard: return "HRD"
        }
    }

    var isBonusEligible: Bool {
        self != .easy
    }

    var difficultyProgressText: String {
        "Level \(progressionIndex + 1) of 3"
    }

    var difficultyScoreLabel: String {
        "Max score: \(maxPossibleScore) pts"
    }

    var difficultyQuickInfo: String {
        "\(displayName) — \(operationCount) ops, \(timeLimitSeconds)s"
    }

    var difficultyTier: Int {
        progressionIndex
    }

    var difficultyXpLabel: String {
        "\(xpPerCorrectAnswer) XP per correct"
    }

    var difficultyOperandLabel: String {
        "Numbers \(operandRange.lowerBound) to \(operandRange.upperBound)"
    }

    var difficultyTimerLabel: String {
        "Timer: \(timeLimitFormatted)"
    }
}
