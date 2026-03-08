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

    var answeredProblemCardColor: String {
        isCorrect ? "green" : "red"
    }

    var answeredProblemPointsEarned: Int {
        isCorrect ? problem.operation.difficultyWeight * 10 : 0
    }

    var answeredProblemReviewPriority: Int {
        guard isCorrect else { return 1 }
        if let time = timeTaken, time < 3.0 { return 3 }
        return 2
    }

    var answeredProblemStreakEligible: Bool {
        isCorrect
    }

    var answeredProblemBadgeEmoji: String {
        guard isCorrect else { return "✗" }
        if let time = timeTaken, time < 3.0 { return "⭐" }
        return "✓"
    }

    var answeredProblemDifficultyTag: String {
        problem.operation.difficultyWeight >= 3 ? "hard" : "easy"
    }

    var answeredProblemTimeBonusEligible: Bool {
        guard isCorrect, let time = timeTaken else { return false }
        return time < 2.0
    }

    var answeredProblemMissedByLabel: String {
        guard !isCorrect else { return "" }
        return "Missed by \(answeredProblemAnswerDelta)"
    }

    var answeredProblemIsMultiDigitProblem: Bool {
        problem.operand1 >= 10 || problem.operand2 >= 10
    }

    var answeredProblemRetryRecommended: Bool {
        if !isCorrect { return true }
        if let time = timeTaken, time > 8.0 { return true }
        return false
    }
}
