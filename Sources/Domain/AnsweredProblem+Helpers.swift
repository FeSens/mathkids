import Foundation

extension AnsweredProblem {
    var wasCorrectText: String {
        isCorrect ? "Correct" : "Wrong"
    }

    var resultEmoji: String {
        isCorrect ? "✅" : "❌"
    }

    var timeTakenText: String {
        guard let time = timeTaken else { return "N/A" }
        return String(format: "%.1fs", time)
    }

    var wasQuickAnswer: Bool {
        guard let time = timeTaken else { return false }
        return time < 3.0
    }

    var summaryText: String {
        "\(problem.formattedProblem) \(resultEmoji)"
    }
}
