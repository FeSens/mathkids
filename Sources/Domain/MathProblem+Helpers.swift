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

    var actionWord: String {
        switch self {
        case .add: return "adding"
        case .subtract: return "subtracting"
        case .multiply: return "multiplying"
        case .divide: return "dividing"
        }
    }

    var isPrimaryOperation: Bool {
        self == .add || self == .subtract
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

    var isBasicFact: Bool {
        operand1 <= 12 && operand2 <= 12
    }

    var estimatedDifficulty: Int {
        let maxOp = max(operand1, operand2)
        let opWeight = operation.difficultyWeight
        if maxOp <= 5 && opWeight <= 2 { return 1 }
        if maxOp <= 10 && opWeight <= 2 { return 2 }
        if maxOp <= 10 { return 3 }
        if opWeight >= 3 { return 4 }
        return 5
    }

    var isMultiDigitResult: Bool {
        abs(correctAnswer) >= 10
    }

    var operandGap: Int {
        abs(operand1 - operand2)
    }

    var isMultiDigitProblem: Bool {
        operand1 >= 10 || operand2 >= 10
    }

    var problemDifficultyStars: Int {
        estimatedDifficulty
    }

    var operandMax: Int {
        max(operand1, operand2)
    }

    var problemDescription: String {
        "\(operand1) \(operation.displayName.lowercased()) \(operand2) equals \(correctAnswer)"
    }

    var isSimpleOperation: Bool {
        operation.isPrimaryOperation
    }

    var hasOperandZero: Bool {
        operand1 == 0 || operand2 == 0
    }

    var isZeroAnswer: Bool {
        correctAnswer == 0
    }

    var isSymmetric: Bool {
        operand1 == operand2
    }

    var isHardOperation: Bool {
        !operation.isPrimaryOperation
    }

    var operandSumIsEven: Bool {
        (operand1 + operand2) % 2 == 0
    }

    var problemLabel: String {
        "\(operation.displayName): \(operand1) \(operation.rawValue) \(operand2)"
    }

    var isLargeOperandGap: Bool {
        operandGap > 5
    }

    var hasNegativeAnswer: Bool {
        correctAnswer < 0
    }

    var operandProductIsLarge: Bool {
        operand1 * operand2 >= 50
    }

    var isSubtractionFromSelf: Bool {
        operation == .subtract && operand1 == operand2
    }

    var operandBothEven: Bool {
        operand1 % 2 == 0 && operand2 % 2 == 0
    }

    var isAdditionOfEquals: Bool {
        operation == .add && operand1 == operand2
    }

    var operandBothOdd: Bool {
        operand1 % 2 != 0 && operand2 % 2 != 0
    }

    var isMultiplyByZero: Bool {
        operation == .multiply && (operand1 == 0 || operand2 == 0)
    }

    var isTripleDigitAnswer: Bool {
        abs(correctAnswer) >= 100
    }

    var operandBothSingleDigit: Bool {
        operand1 < 10 && operand2 < 10
    }

    var problemIsEasy: Bool {
        estimatedDifficulty <= 2
    }
}
