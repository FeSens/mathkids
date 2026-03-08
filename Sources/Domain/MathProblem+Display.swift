import Foundation

extension MathProblem {
    var problemDisplayText: String {
        "\(operand1) \(operation.rawValue) \(operand2) = ?"
    }

    var problemAnswerChoices: [Int] {
        let correct = correctAnswer
        var choices = Set<Int>([correct])
        let offsets = [1, -1, 2, -2, 3, -3, 5, -5, 10, -10]
        for offset in offsets {
            if choices.count >= 4 { break }
            let choice = correct + offset
            if choice >= 0 {
                choices.insert(choice)
            }
        }
        while choices.count < 4 {
            choices.insert(choices.count + correct)
        }
        return Array(choices).sorted()
    }

    var problemOperandSum: Int {
        operand1 + operand2
    }

    var problemMaxOperand: Int {
        max(operand1, operand2)
    }

    var problemMinOperand: Int {
        min(operand1, operand2)
    }

    var problemOperandProduct: Int {
        operand1 * operand2
    }

    var problemOperandDifference: Int {
        abs(operand1 - operand2)
    }

    var problemIsEqualOperands: Bool {
        operand1 == operand2
    }

    var problemReadAloudText: String {
        "\(operand1) \(operation.operationSpokenPhrase) \(operand2)"
    }

    var problemAnswerDigitCount: Int {
        String(abs(correctAnswer)).count
    }

    var problemHintText: String {
        operation.operationTip
    }

    var problemBothOperandsSingleDigit: Bool {
        operand1 < 10 && operand2 < 10
    }

    var problemHasZeroOperand: Bool {
        operand1 == 0 || operand2 == 0
    }

    var problemHasOneOperand: Bool {
        operand1 == 1 || operand2 == 1
    }

    var problemAccessibilityHint: String {
        "\(operation.displayName) problem: \(problemReadAloudText)"
    }

    var problemIsDoubleDigitAnswer: Bool {
        abs(correctAnswer) >= 10
    }

    var problemOperandsAreConsecutive: Bool {
        abs(operand1 - operand2) == 1
    }

    var problemIsEasyByOperands: Bool {
        operand1 <= 5 && operand2 <= 5
    }

    var problemTotalDigits: Int {
        String(operand1).count + String(operand2).count
    }

    var problemCategoryLabel: String {
        operation.displayName
    }

    var problemShareText: String {
        "\(operand1) \(operation.rawValue) \(operand2) = \(correctAnswer)"
    }

    var problemIsIdentityOperation: Bool {
        let identity = operation.operationIdentityElement
        return operand1 == identity || operand2 == identity
    }

    var problemIsLargeAnswer: Bool {
        abs(correctAnswer) >= 50
    }

    var problemOperandRatio: Double {
        let bigger = Double(problemMaxOperand)
        let smaller = Double(max(problemMinOperand, 1))
        return bigger / smaller
    }

    var problemEstimatedTimeSeconds: Int {
        operation.difficultyWeight * 2
    }

    var problemSolvedText: String {
        "\(operand1) \(operation.rawValue) \(operand2) = \(correctAnswer)"
    }

    var problemIsTrivial: Bool {
        problemMaxOperand <= 1
    }

    var problemOperandAverage: Double {
        Double(operand1 + operand2) / 2.0
    }

    var problemDifficultyLevel: String {
        if problemMaxOperand <= 5 { return "easy" }
        if problemMaxOperand <= 7 { return "medium" }
        return "hard"
    }

    var problemIsCommutative: Bool {
        operation.operationIsCommutative
    }

    var problemIsTableFact: Bool {
        operand1 >= 1 && operand1 <= 9 && operand2 >= 1 && operand2 <= 9
    }

    var problemReversedText: String {
        "\(operand2) \(operation.rawValue) \(operand1) = ?"
    }

    var problemIsSquare: Bool {
        operation == .multiply && operand1 == operand2
    }

    var problemBadgeLabel: String {
        "\(operand1)\(operation.rawValue)\(operand2)"
    }

    var problemPointValue: Int {
        operation.difficultyWeight * 5
    }

    var problemIsTensComplement: Bool {
        operand1 + operand2 == 10
    }

    var problemIsDouble: Bool {
        operation == .add && operand1 == operand2
    }

    var problemQuestionMark: String {
        "\(operand1) \(operation.rawValue) \(operand2) = ?"
    }

    var problemOperandParity: Bool {
        operand1 % 2 == operand2 % 2
    }

    var problemNumberBondLabel: String {
        "\(operand1) and \(operand2)"
    }

    var problemIsNearDouble: Bool {
        operation == .add && abs(operand1 - operand2) == 1
    }

    var problemSummaryLabel: String {
        "\(operation.displayName): \(operand1) \(operation.rawValue) \(operand2)"
    }

    var problemCorrectAnswerIsOdd: Bool {
        correctAnswer % 2 != 0
    }

    var problemNeedsRegrouping: Bool {
        operation == .add && correctAnswer >= 10
    }

    var problemIsMakingTen: Bool {
        operation == .add && correctAnswer == 10
    }

    var problemIsPerfectSquareAnswer: Bool {
        let answer = correctAnswer
        guard answer > 0 else { return false }
        let root = Int(Double(answer).squareRoot())
        return root * root == answer
    }

    var problemOperandSumIsEven: Bool {
        (operand1 + operand2) % 2 == 0
    }

    var problemFlashcardFront: String {
        "\(operand1) \(operation.rawValue) \(operand2)"
    }

    var problemFlashcardBack: String {
        "\(correctAnswer)"
    }

    var problemIsMultiplyByTwo: Bool {
        operation == .multiply && (operand1 == 2 || operand2 == 2)
    }
}
