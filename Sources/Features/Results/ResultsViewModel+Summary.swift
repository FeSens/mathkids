import Foundation

extension ResultsViewModel {

    /// Response time percentile (0-100, higher = faster)
    var responseTimePercentile: Int {
        let times = problemHistory.compactMap(\.timeTaken)
        guard !times.isEmpty else { return 50 }
        let avg = times.reduce(0, +) / Double(times.count)
        if avg < 1.0 { return 95 }
        if avg < 2.0 { return 80 }
        if avg < 3.0 { return 60 }
        if avg < 5.0 { return 40 }
        return 20
    }

    /// Description of common mistake patterns
    var mistakePatternText: String? {
        let wrong = problemHistory.filter { !$0.isCorrect }
        guard !wrong.isEmpty else { return nil }
        var opCounts: [Operation: Int] = [:]
        for entry in wrong {
            opCounts[entry.problem.operation, default: 0] += 1
        }
        guard let weakest = opCounts.max(by: { $0.value < $1.value }) else { return nil }
        return "You struggled with \(weakest.key.displayName) (\(weakest.value) mistakes)"
    }

    /// Detailed single-line game summary
    var gameSummaryDescription: String {
        let acc = accuracy
        if acc >= 100 {
            return "Perfect game with \(totalAnswered) problems solved!"
        } else if acc >= 90 {
            return "Excellent session! \(Int(acc))% accuracy with \(totalAnswered) problems."
        } else if acc >= 70 {
            return "Great effort! \(Int(acc))% accuracy across \(totalAnswered) problems."
        } else if acc >= 50 {
            return "Keep practicing! \(Int(acc))% accuracy on \(totalAnswered) problems."
        } else {
            return "Try again! Practice makes perfect - \(totalAnswered) problems attempted."
        }
    }
}
