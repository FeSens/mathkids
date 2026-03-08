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

    var answeredProblemEncouragementText: String {
        isCorrect ? "Great job!" : "Try again!"
    }

    var answeredProblemIsFirstAttempt: Bool {
        timeTaken == nil
    }

    var answeredProblemGrade: String {
        guard isCorrect else { return "F" }
        guard let time = timeTaken else { return "B" }
        if time < 3.0 { return "A" }
        if time < 6.0 { return "B" }
        return "C"
    }

    var answeredProblemIsBonus: Bool {
        isCorrect && !problem.operation.isPrimaryOperation
    }

    var answeredProblemSummaryIcon: String {
        isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill"
    }

    var answeredProblemPerformanceLevel: String {
        guard isCorrect else { return "needs practice" }
        if let time = timeTaken, time < 3.0 { return "excellent" }
        return "good"
    }

    var answeredProblemCorrectAnswerText: String {
        "Answer: \(problem.correctAnswer)"
    }

    var answeredProblemIsSlowAnswer: Bool {
        guard let time = timeTaken else { return false }
        return time > 8.0
    }

    var answeredProblemStarCount: Int {
        guard isCorrect else { return 0 }
        guard let time = timeTaken else { return 1 }
        if time < 3.0 { return 3 }
        if time < 6.0 { return 2 }
        return 1
    }

    var answeredProblemNeedsHelp: Bool {
        !isCorrect && answeredProblemAnswerDelta >= 3
    }

    var answeredProblemXpEarned: Int {
        guard isCorrect else { return 0 }
        let base = problem.operation.difficultyWeight * 5
        if let time = timeTaken, time < 3.0 { return base * 2 }
        return base
    }

    var answeredProblemIsAddition: Bool {
        problem.operation == .add
    }

    var answeredProblemIsSubtraction: Bool {
        problem.operation == .subtract
    }

    var answeredProblemIsMultiplication: Bool {
        problem.operation == .multiply
    }

    var answeredProblemIsDivision: Bool {
        problem.operation == .divide
    }

    var answeredProblemAccuracyEmoji: String {
        if isCorrect { return "🎯" }
        if answeredProblemAnswerDelta <= 1 { return "🔶" }
        return "🔴"
    }

    var answeredProblemCompactResult: String {
        let mark = isCorrect ? "✓" : "✗"
        return "\(mark) \(problem.operand1)\(problem.operation.rawValue)\(problem.operand2)=\(userAnswer)"
    }

    var answeredProblemShouldCelebrate: Bool {
        isCorrect && (timeTaken ?? Double.infinity) < 3.0
    }

    var answeredProblemOperationSymbol: String {
        problem.operation.rawValue
    }

    var answeredProblemMaxPoints: Int {
        problem.operation.difficultyWeight * 10
    }

    var answeredProblemTimeCategory: String {
        guard let time = timeTaken else { return "normal" }
        if time < 1.0 { return "instant" }
        if time < 3.0 { return "quick" }
        if time > 8.0 { return "slow" }
        return "normal"
    }

    var answeredProblemScorePercentage: Int {
        isCorrect ? 100 : 0
    }

    var answeredProblemDetailedFeedback: String {
        if isCorrect {
            return "Correct! \(answeredProblemDisplayText)"
        }
        return "Incorrect. The answer is \(problem.correctAnswer), you answered \(userAnswer)."
    }

    var answeredProblemIsEasyProblem: Bool {
        problem.operand1 < 5 && problem.operand2 < 5
    }

    var answeredProblemResponseQuality: String {
        guard isCorrect else { return "incorrect" }
        if let time = timeTaken, time < 3.0 { return "perfect" }
        return "correct"
    }

    var answeredProblemAttemptSummary: String {
        guard isCorrect else { return "Incorrect" }
        if let time = timeTaken {
            return "Correct in \(String(format: "%.1f", time))s"
        }
        return "Correct"
    }

    var answeredProblemIsPerfectScore: Bool {
        isCorrect && (timeTaken ?? Double.infinity) < 3.0
    }

    var answeredProblemWeightedScore: Int {
        guard isCorrect else { return 0 }
        let base = problem.operation.difficultyWeight * 10
        if let time = timeTaken, time < 3.0 { return base * 2 }
        return base
    }

    var answeredProblemHintWouldHelp: Bool {
        !isCorrect && answeredProblemAnswerDelta <= 2
    }

    var answeredProblemLogEntry: String {
        let op = problem.operation.displayName.lowercased()
        let result = isCorrect ? "correct" : "incorrect"
        return "[\(op)] \(problem.operand1)\(problem.operation.rawValue)\(problem.operand2)=\(userAnswer) (\(result))"
    }

    var answeredProblemConfidenceLevel: String {
        guard let time = timeTaken else { return "medium" }
        if time < 3.0 { return "high" }
        if time > 8.0 { return "low" }
        return "medium"
    }

    var answeredProblemIsWorthReview: Bool {
        !isCorrect || answeredProblemIsSlowAnswer
    }

    var answeredProblemProgressColor: String {
        guard isCorrect else { return "red" }
        if let time = timeTaken, time < 3.0 { return "gold" }
        if let time = timeTaken, time < 6.0 { return "green" }
        return "orange"
    }

    var answeredProblemOperandCount: Int { 2 }

    var answeredProblemIsMastered: Bool {
        isCorrect && (timeTaken ?? Double.infinity) < 2.0
    }
}
