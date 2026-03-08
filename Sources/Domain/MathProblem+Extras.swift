import Foundation

extension MathProblem {
    var wrongAnswerChoices: [Int] {
        let answer = correctAnswer
        var choices: Set<Int> = []
        let offsets = [-2, -1, 1, 2, 3, -3, 5, -5]
        for offset in offsets {
            let wrong = answer + offset
            if wrong != answer && wrong >= 0 {
                choices.insert(wrong)
            }
            if choices.count >= 3 { break }
        }
        while choices.count < 3 {
            choices.insert(answer + choices.count + 10)
        }
        return Array(choices.prefix(3))
    }

    var answerDigitCount: Int {
        let answer = abs(correctAnswer)
        if answer == 0 { return 1 }
        return String(answer).count
    }

    var isSingleDigitResult: Bool {
        correctAnswer >= 0 && correctAnswer <= 9
    }

    var answerChoices: [Int] {
        var choices = wrongAnswerChoices
        choices.append(correctAnswer)
        return choices.shuffled()
    }

    var requiresCarryOrBorrow: Bool {
        switch operation {
        case .add:
            let onesSum = (operand1 % 10) + (operand2 % 10)
            return onesSum >= 10
        case .subtract:
            let onesDigit1 = operand1 % 10
            let onesDigit2 = operand2 % 10
            return onesDigit1 < onesDigit2
        case .multiply, .divide:
            return false
        }
    }

    enum NumberLinePosition: Sendable {
        case negative, zero, small, medium, large
    }

    var numberLinePosition: NumberLinePosition {
        let answer = correctAnswer
        if answer < 0 { return .negative }
        if answer == 0 { return .zero }
        if answer < 20 { return .small }
        if answer < 100 { return .medium }
        return .large
    }

    var difficultyScore: Int {
        let opScore = operation.difficultyRank
        let sizeScore = (operand1 + operand2) / 10
        let raw = opScore + sizeScore
        return min(max(raw, 1), 10)
    }

    var operandSum: Int {
        operand1 + operand2
    }

    var operandProduct: Int {
        operand1 * operand2
    }

    var isDoubleFact: Bool {
        operation == .add && operand1 == operand2
    }

    var isEasyProblem: Bool {
        abs(operand1) <= 5 && abs(operand2) <= 5
    }

    var answerMagnitude: AnswerMagnitude {
        let answer = abs(correctAnswer)
        if answer < 20 { return .small }
        if answer < 100 { return .medium }
        return .large
    }

    var isDivisionExact: Bool {
        guard operation == .divide, operand2 != 0 else { return false }
        return operand1 % operand2 == 0
    }

    var isAdditionTen: Bool {
        operation == .add && (operand1 == 10 || operand2 == 10)
    }

    var isMultiplicationByOne: Bool {
        operation == .multiply && (operand1 == 1 || operand2 == 1)
    }

    var isSubtractionToZero: Bool {
        operation == .subtract && operand1 == operand2
    }

    var isCommutativeProblem: Bool {
        operation.isCommutative
    }

    var answerRange: (min: Int, max: Int) {
        let answer = correctAnswer
        let spread = max(abs(answer) / 2, 5)
        return (answer - spread, answer + spread)
    }

    var isLargeResult: Bool {
        abs(correctAnswer) > 100
    }

    var operandDifference: Int {
        abs(operand1 - operand2)
    }

    var isZeroResult: Bool {
        correctAnswer == 0
    }

    var isMakesTen: Bool {
        operation == .add && correctAnswer == 10
    }

    var isTablesFact: Bool {
        operation == .multiply && abs(operand1) <= 12 && abs(operand2) <= 12
    }

    var minOperand: Int {
        min(abs(operand1), abs(operand2))
    }

    var maxOperand: Int {
        max(abs(operand1), abs(operand2))
    }

    var isNearDoubleFact: Bool {
        operation == .add && abs(operand1 - operand2) == 1
    }

    var isNegativeResult: Bool {
        correctAnswer < 0
    }

    var isPositiveResult: Bool {
        correctAnswer > 0
    }

    var isZeroOperand: Bool {
        operand1 == 0 || operand2 == 0
    }

    var operandRatio: Double {
        guard operand2 != 0 else { return 0.0 }
        return Double(operand1) / Double(operand2)
    }

    var bothOperandsEqual: Bool {
        operand1 == operand2
    }

    var largerOperand: Int {
        max(operand1, operand2)
    }

    var smallerOperand: Int {
        min(operand1, operand2)
    }

    var operandAbsDifference: Int {
        abs(operand1 - operand2)
    }

    var isSingleDigitOperands: Bool {
        operand1 >= 0 && operand1 <= 9 && operand2 >= 0 && operand2 <= 9
    }

    var isIdentityOperation: Bool {
        switch operation {
        case .add, .subtract: operand2 == 0
        case .multiply, .divide: operand2 == 1
        }
    }

    var stepByStepHint: String {
        switch operation {
        case .add:
            return "Start at \(operand1), count up \(operand2)"
        case .subtract:
            return "Start at \(operand1), count down \(operand2)"
        case .multiply:
            let terms = Array(repeating: "\(operand2)", count: operand1).joined(separator: " + ")
            return "\(operand1) × \(operand2) = \(terms)"
        case .divide:
            return "How many groups of \(operand2) fit in \(operand1)?"
        }
    }
}

enum AnswerMagnitude: Sendable {
    case small, medium, large
}
