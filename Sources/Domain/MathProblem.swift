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
}
