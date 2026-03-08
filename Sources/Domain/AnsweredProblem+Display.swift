import Foundation

extension AnsweredProblem {
    var answeredProblemFeedbackEmoji: String {
        isCorrect ? "✅" : "❌"
    }

    var answeredProblemScoreContribution: Int {
        isCorrect ? problem.operation.difficultyWeight * 5 : 0
    }

    var answeredProblemDisplayText: String {
        "\(problem.operand1) \(problem.operation.rawValue) \(problem.operand2) = \(userAnswer)"
    }

    var answeredProblemTimeTakenLabel: String {
        guard let time = timeTaken else { return "N/A" }
        return String(format: "%.1fs", time)
    }

    var answeredProblemAccessibilityResult: String {
        isCorrect ? "Correct" : "Wrong, answer was \(problem.correctAnswer)"
    }

    var answeredProblemCorrectionText: String {
        "The correct answer is \(problem.correctAnswer)"
    }

    var answeredProblemIsQuick: Bool {
        guard let time = timeTaken else { return false }
        return time < 3.0
    }

    var answeredProblemShareText: String {
        if isCorrect {
            return "Got it right! \(problem.operand1) \(problem.operation.rawValue) \(problem.operand2) = \(userAnswer)"
        }
        return "Missed this one: \(problem.operand1) \(problem.operation.rawValue) \(problem.operand2)"
    }

    var answeredProblemAnswerDelta: Int {
        abs(userAnswer - problem.correctAnswer)
    }

    var answeredProblemResultLabel: String {
        isCorrect ? "Correct" : "Incorrect"
    }

    var answeredProblemSpeedRating: String {
        guard let time = timeTaken else { return "normal" }
        if time < 2.0 { return "fast" }
        if time > 8.0 { return "slow" }
        return "normal"
    }

    var answeredProblemFullResultText: String {
        "\(answeredProblemFeedbackEmoji) \(answeredProblemDisplayText)"
    }

    var answeredProblemWasClose: Bool {
        !isCorrect && answeredProblemAnswerDelta <= 1
    }

    var answeredProblemOperationName: String {
        problem.operation.displayName
    }

    var answeredProblemIsHardOperation: Bool {
        !problem.operation.isPrimaryOperation
    }
}
