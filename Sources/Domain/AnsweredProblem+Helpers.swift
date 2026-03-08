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

    var pointsEarned: Int {
        isCorrect ? 10 : -5
    }

    var userAnswerText: String {
        "\(userAnswer)"
    }

    var correctAnswerDisplay: String {
        "\(problem.correctAnswer)"
    }

    var mistakeDescription: String {
        guard !isCorrect else { return "" }
        return "You answered \(userAnswer), correct answer is \(problem.correctAnswer)"
    }

    var difficultyLabel: String {
        problem.problemCategoryText
    }

    var responseTime: String {
        guard let time = timeTaken else { return "unknown" }
        if time < 3.0 { return "fast" }
        if time < 6.0 { return "normal" }
        return "slow"
    }

    var accuracyImpact: String {
        isCorrect ? "boost" : "drop"
    }

    var reviewText: String {
        if isCorrect {
            return "\(problem.formattedProblem) → \(userAnswer) ✅"
        }
        return "\(problem.formattedProblem) → \(userAnswer) (correct: \(problem.correctAnswer)) ❌"
    }

    var operationName: String {
        problem.operation.displayName
    }

    var answerDifference: Int {
        abs(userAnswer - problem.correctAnswer)
    }

    var wasClose: Bool {
        !isCorrect && answerDifference <= 2
    }

    var wasOverTime: Bool {
        guard let time = timeTaken else { return false }
        return time > 10.0
    }

    var wasNilTime: Bool {
        timeTaken == nil
    }

    var isSubtractionProblem: Bool {
        problem.operation == .subtract
    }

    var isAdditionProblem: Bool {
        problem.operation == .add
    }

    var wasTimedOut: Bool {
        !isCorrect && timeTaken == nil
    }

    var isMultiplicationProblem: Bool {
        problem.operation == .multiply
    }

    var isDivisionProblem: Bool {
        problem.operation == .divide
    }

    var isCorrectAndFast: Bool {
        isCorrect && wasQuickAnswer
    }

    var answerWasNegative: Bool {
        userAnswer < 0
    }

    var problemSummary: String {
        if isCorrect {
            return "\(problem.formattedProblem) → \(userAnswer) ✓"
        }
        return "\(problem.formattedProblem) → \(userAnswer) (answer: \(problem.correctAnswer))"
    }

    var answerOffByOne: Bool {
        answerDifference == 1
    }

    var feedbackText: String {
        if isCorrect {
            return "Well done!"
        }
        return "The correct answer was \(problem.correctAnswer)"
    }
}
