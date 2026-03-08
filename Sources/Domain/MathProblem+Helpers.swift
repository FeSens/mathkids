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

extension Operation {
    var requiresOrdering: Bool {
        self == .subtract || self == .divide
    }

    var resultVerb: String {
        switch self {
        case .add: return "sum"
        case .subtract: return "difference"
        case .multiply: return "product"
        case .divide: return "quotient"
        }
    }

    var difficultyWeight: Int {
        switch self {
        case .add: return 1
        case .subtract: return 2
        case .multiply: return 3
        case .divide: return 4
        }
    }

    var helpText: String {
        switch self {
        case .add: return "Add the numbers together"
        case .subtract: return "Take the second from the first"
        case .multiply: return "Multiply the numbers"
        case .divide: return "Divide the first by the second"
        }
    }

    func isInverse(of other: Operation) -> Bool {
        switch (self, other) {
        case (.add, .subtract), (.subtract, .add): return true
        case (.multiply, .divide), (.divide, .multiply): return true
        default: return false
        }
    }
}

extension MathProblem {
    var operandRangeText: String {
        let low = min(operand1, operand2)
        let high = max(operand1, operand2)
        return "\(low)-\(high)"
    }

    var requiresCarrying: Bool {
        guard operation == .add else { return false }
        return (operand1 % 10) + (operand2 % 10) > 9
    }

    var hasLargeOperands: Bool {
        operand1 >= 10 || operand2 >= 10
    }

    var answerChoiceRange: ClosedRange<Int> {
        let answer = correctAnswer
        let spread = max(5, abs(answer) / 2 + 1)
        return (answer - spread)...(answer + spread)
    }
}
