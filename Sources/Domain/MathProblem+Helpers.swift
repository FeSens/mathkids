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
}
