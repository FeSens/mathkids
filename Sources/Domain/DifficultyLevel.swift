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
}
