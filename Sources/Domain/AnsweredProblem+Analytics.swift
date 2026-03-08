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
}
