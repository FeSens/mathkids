import Foundation

enum Operation: String, CaseIterable, Codable, Sendable {
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"
}

struct MathProblem: Equatable, Sendable {
    let operand1: Int
    let operand2: Int
    let operation: Operation

    var correctAnswer: Int {
        switch operation {
        case .add: operand1 + operand2
        case .subtract: operand1 - operand2
        case .multiply: operand1 * operand2
        case .divide: operand1 / operand2
        }
    }

    var displayText: String {
        "\(operand1) \(operation.rawValue) \(operand2)"
    }

    func isCorrect(answer: Int) -> Bool {
        answer == correctAnswer
    }

    enum ProblemDifficulty {
        case easy, moderate, hard
    }

    var problemDifficulty: ProblemDifficulty {
        let maxOperand = max(abs(operand1), abs(operand2))
        switch operation {
        case .add, .subtract:
            if maxOperand <= 10 { return .easy }
            if maxOperand <= 25 { return .moderate }
            return .hard
        case .multiply:
            if maxOperand <= 5 { return .easy }
            if maxOperand <= 10 { return .moderate }
            return .hard
        case .divide:
            if abs(correctAnswer) <= 5 { return .easy }
            if abs(correctAnswer) <= 10 { return .moderate }
            return .hard
        }
    }
}
