import Foundation

enum DifficultyLevel: String, CaseIterable, Codable, Sendable {
    case easy
    case medium
    case hard

    var displayName: String {
        rawValue.capitalized
    }

    var operandRange: ClosedRange<Int> {
        switch self {
        case .easy: 1...10
        case .medium: 1...20
        case .hard: 1...50
        }
    }

    var allowedOperations: [Operation] {
        switch self {
        case .easy: [.add, .subtract]
        case .medium: [.add, .subtract, .multiply]
        case .hard: Operation.allCases
        }
    }

    var timeLimitSeconds: Int {
        switch self {
        case .easy: 60
        case .medium: 45
        case .hard: 30
        }
    }

    var pointsPerCorrect: Int {
        switch self {
        case .easy: 10
        case .medium: 20
        case .hard: 30
        }
    }

    var emoji: String {
        switch self {
        case .easy: "🌱"
        case .medium: "⚡"
        case .hard: "🔥"
        }
    }

    var color: String {
        switch self {
        case .easy: "green"
        case .medium: "orange"
        case .hard: "red"
        }
    }

    var previousDifficulty: DifficultyLevel? {
        switch self {
        case .easy: nil
        case .medium: .easy
        case .hard: .medium
        }
    }

    var nextDifficulty: DifficultyLevel? {
        switch self {
        case .easy: .medium
        case .medium: .hard
        case .hard: nil
        }
    }

    var operandDescription: String {
        "\(operandRange.lowerBound) to \(operandRange.upperBound)"
    }

    var emojiDescription: String {
        "\(emoji) \(displayName)"
    }

    var maxPossibleScore: Int {
        let maxProblems = timeLimitSeconds / recommendedSecondsPerProblem
        return maxProblems * pointsPerCorrect
    }

    var penaltyPerWrong: Int {
        switch self {
        case .easy: 2
        case .medium: 5
        case .hard: 10
        }
    }

    var recommendedSecondsPerProblem: Int {
        switch self {
        case .easy: 6
        case .medium: 4
        case .hard: 3
        }
    }

    var streakBonusMultiplier: Double {
        switch self {
        case .easy: 1.0
        case .medium: 1.5
        case .hard: 2.0
        }
    }

    var briefDescription: String {
        let ops = allowedOperations.map(\.rawValue).joined(separator: " ")
        return "1-\(operandRange.upperBound) \(ops) \(timeLimitSeconds)s"
    }
}
