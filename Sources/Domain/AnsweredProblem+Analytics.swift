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
}
