import Foundation

extension MathProblem {
    var isAddition: Bool {
        operation == .add
    }

    var isSubtraction: Bool {
        operation == .subtract
    }

    var isMultiplication: Bool {
        operation == .multiply
    }

    var isDivision: Bool {
        operation == .divide
    }

    var problemCategoryText: String {
        let maxOp = max(operand1, operand2)
        if operation == .multiply || operation == .divide {
            return maxOp >= 10 ? "advanced" : "intermediate"
        }
        if maxOp <= 5 { return "basic" }
        if maxOp <= 10 { return "intermediate" }
        return "advanced"
    }

    var answerIsPositive: Bool {
        correctAnswer > 0
    }

    var operandAverage: Double {
        Double(operand1 + operand2) / 2.0
    }

    var isLargeAnswer: Bool {
        correctAnswer >= 50
    }

    var operandSumText: String {
        "\(operand1 + operand2)"
    }

    var hasEvenAnswer: Bool {
        correctAnswer % 2 == 0
    }

    var formattedProblem: String {
        "\(operand1) \(operation.rawValue) \(operand2) = ?"
    }

    var isDoubleDigitAnswer: Bool {
        abs(correctAnswer) >= 10
    }

    var operationSymbol: String {
        operation.rawValue
    }

    var hasSmallOperands: Bool {
        operand1 < 10 && operand2 < 10
    }

    var correctAnswerText: String {
        "\(correctAnswer)"
    }
}
