import Foundation

extension AnsweredProblem {
    var answeredProblemSessionTag: String {
        problem.operation.isPrimaryOperation ? "practice" : "quiz"
    }

    var answeredProblemIsNaturalNumber: Bool {
        problem.correctAnswer > 0
    }

    var answeredProblemEfficiencyRatio: Double {
        isCorrect ? 1.0 : 0.0
    }

    var answeredProblemReactionSpeed: String {
        guard let time = timeTaken else { return "normal" }
        if time < 1.0 { return "lightning" }
        if time < 3.0 { return "fast" }
        if time > 8.0 { return "deliberate" }
        return "normal"
    }

    var answeredProblemProblemComplexity: Int {
        let operandScore = problem.operand1 + problem.operand2
        return operandScore * problem.operation.difficultyWeight
    }

    var answeredProblemSkillLevel: String {
        switch problem.operation.difficultyWeight {
        case 1...2: return "beginner"
        case 3: return "intermediate"
        default: return "advanced"
        }
    }

    var answeredProblemIsCommutativeProblem: Bool {
        problem.operation == .add || problem.operation == .multiply
    }

    var answeredProblemMasteryScore: Int {
        guard isCorrect else { return 0 }
        if let time = timeTaken, time < 3.0 { return 100 }
        if let time = timeTaken, time < 6.0 { return 75 }
        return 50
    }

    var answeredProblemAnswerWasHigher: Bool {
        userAnswer > problem.correctAnswer
    }

    var answeredProblemAnswerWasLower: Bool {
        userAnswer < problem.correctAnswer
    }

    var answeredProblemErrorType: String {
        guard !isCorrect else { return "none" }
        if abs(userAnswer - problem.correctAnswer) == 1 { return "off-by-one" }
        return "random"
    }

    var answeredProblemStreakValue: Int {
        isCorrect ? 1 : 0
    }

    var answeredProblemIsBasicFact: Bool {
        problem.operand1 <= 10 && problem.operand2 <= 10
    }

    var answeredProblemFeedbackSound: String {
        guard isCorrect else { return "wrong" }
        if let time = timeTaken, time < 3.0 { return "perfect" }
        return "correct"
    }

    var answeredProblemAnalyticsEvent: String {
        isCorrect ? "problem_correct" : "problem_incorrect"
    }

    var answeredProblemDifficultyRank: Int {
        problem.operation.difficultyWeight
    }

    var answeredProblemIsTimedOut: Bool {
        guard let time = timeTaken else { return false }
        return time > 15.0
    }

    var answeredProblemAnswerLength: Int {
        String(abs(userAnswer)).count
    }

    var answeredProblemProblemKey: String {
        let op: String
        switch problem.operation {
        case .add: op = "add"
        case .subtract: op = "sub"
        case .multiply: op = "mul"
        case .divide: op = "div"
        }
        return "\(op)_\(problem.operand1)_\(problem.operand2)"
    }

    var answeredProblemIsRepeatMistake: Bool {
        !isCorrect && (userAnswer == problem.operand1 || userAnswer == problem.operand2)
    }

    var answeredProblemCoinReward: Int {
        isCorrect ? problem.operation.difficultyWeight : 0
    }

    var answeredProblemIsSingleDigitAnswer: Bool {
        problem.correctAnswer >= 0 && problem.correctAnswer <= 9
    }

    var answeredProblemLearningPhase: String {
        guard isCorrect else { return "memorizing" }
        guard let time = timeTaken else { return "practicing" }
        if time < 3.0 { return "mastered" }
        if time < 6.0 { return "practicing" }
        return "memorizing"
    }

    var answeredProblemOperandRange: String {
        (problem.operand1 >= 10 || problem.operand2 >= 10) ? "multi-digit" : "single-digit"
    }

    var answeredProblemTimeBucket: String {
        guard let time = timeTaken else { return "unknown" }
        if time < 2.0 { return "0-2s" }
        if time < 5.0 { return "2-5s" }
        if time < 10.0 { return "5-10s" }
        return "10s+"
    }

    var answeredProblemIsTableFactProblem: Bool {
        problem.operand1 >= 1 && problem.operand1 <= 12 &&
        problem.operand2 >= 1 && problem.operand2 <= 12
    }

    var answeredProblemGradeEmoji: String {
        guard isCorrect else { return "❌" }
        if let time = timeTaken, time < 3.0 { return "🏆" }
        if let time = timeTaken, time < 6.0 { return "⭐" }
        return "👍"
    }

    var answeredProblemPracticeCount: Int {
        guard isCorrect else { return 5 }
        if let time = timeTaken, time < 3.0 { return 0 }
        if let time = timeTaken, time < 6.0 { return 2 }
        return 3
    }

    var answeredProblemIsHardProblem: Bool {
        answeredProblemProblemComplexity > 20
    }

    var answeredProblemFlashcardStatus: String {
        guard isCorrect else { return "new" }
        if let time = timeTaken, time < 3.0 { return "learned" }
        return "learning"
    }

    var answeredProblemQuizWeight: Int {
        guard isCorrect else { return 3 }
        if let time = timeTaken, time < 3.0 { return 1 }
        return 2
    }

    var answeredProblemIsPerfectResponse: Bool {
        isCorrect && (timeTaken ?? Double.infinity) < 1.0
    }

    var answeredProblemParentReport: String {
        let eq = "\(problem.operand1) \(problem.operation.rawValue) \(problem.operand2)"
        if isCorrect {
            return "Correct: \(eq) = \(userAnswer)"
        }
        return "Incorrect: \(eq) — answered \(userAnswer), correct answer is \(problem.correctAnswer)"
    }

    var answeredProblemDifficultyLabel: String {
        answeredProblemIsHardProblem ? "Hard" : "Easy"
    }

    var answeredProblemIsBelowExpectation: Bool {
        !isCorrect || (timeTaken ?? 0) > 10.0
    }

    var answeredProblemTeacherNote: String {
        guard isCorrect else { return "Student needs review on this problem" }
        if let time = timeTaken, time < 3.0 { return "Student has mastered this fact" }
        return "Student practiced this fact"
    }

    var answeredProblemIsCountingProblem: Bool {
        (problem.operation == .add || problem.operation == .subtract) &&
        (problem.operand1 == 1 || problem.operand2 == 1)
    }

    var answeredProblemAbilityIndicator: String {
        guard isCorrect else { return "weak" }
        if let time = timeTaken, time < 3.0 { return "strong" }
        return "average"
    }

    var answeredProblemHapticType: String {
        isCorrect ? "success" : "error"
    }

    var answeredProblemNextStepSuggestion: String {
        guard isCorrect else { return "Let's practice this one more" }
        if let time = timeTaken, time < 3.0 { return "Great! Try the next challenge" }
        return "Good, keep practicing for speed"
    }

    var answeredProblemAccessibilityAction: String {
        isCorrect ? "Answer was correct" : "Answer was incorrect, correct answer is \(problem.correctAnswer)"
    }

    var answeredProblemIsDoubleDigitProblem: Bool {
        problem.operand1 >= 10 && problem.operand2 >= 10
    }

    var answeredProblemRetentionScore: Int {
        guard isCorrect else { return 0 }
        if let time = timeTaken, time < 3.0 { return 10 }
        if let time = timeTaken, time < 6.0 { return 7 }
        return 4
    }

    var answeredProblemAnimationType: String {
        guard isCorrect else { return "shake" }
        if let time = timeTaken, time < 3.0 { return "confetti" }
        return "none"
    }

    var answeredProblemSessionContribution: String {
        isCorrect ? "100%" : "0%"
    }

    var answeredProblemReviewCategory: String {
        guard isCorrect else { return "critical" }
        if let time = timeTaken, time < 3.0 { return "mastered" }
        return "needs-work"
    }

    var answeredProblemIsFluent: Bool {
        isCorrect && (timeTaken ?? Double.infinity) < 2.0
    }

    var answeredProblemDailyGoalPoints: Int {
        isCorrect ? problem.operation.difficultyWeight * 5 : 1
    }

    var answeredProblemProblemDescription: String {
        "\(problem.operand1) \(problem.operation.rawValue) \(problem.operand2) = \(userAnswer) (\(isCorrect ? "correct" : "incorrect, answer: \(problem.correctAnswer)"))"
    }

    var answeredProblemMistakePattern: String {
        guard !isCorrect else { return "none" }
        if userAnswer == problem.operand1 || userAnswer == problem.operand2 {
            return "operand-confusion"
        }
        if abs(userAnswer - problem.correctAnswer) <= 1 { return "near-miss" }
        return "random-guess"
    }
}
