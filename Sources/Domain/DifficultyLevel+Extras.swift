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
}
