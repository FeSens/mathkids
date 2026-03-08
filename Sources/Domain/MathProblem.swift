import Foundation

enum Operation: String, CaseIterable, Codable, Sendable {
    case add = "+"
    case subtract = "-"
    case multiply = "x"
    case divide = "/"

    var emoji: String {
        switch self {
        case .add: "➕"
        case .subtract: "➖"
        case .multiply: "✖️"
        case .divide: "➗"
        }
    }

    var displayName: String {
        switch self {
        case .add: "Addition"
        case .subtract: "Subtraction"
        case .multiply: "Multiplication"
        case .divide: "Division"
        }
    }

    var colorName: String {
        switch self {
        case .add: "blue"
        case .subtract: "orange"
        case .multiply: "purple"
        case .divide: "green"
        }
    }

    var difficultyRank: Int {
        switch self {
        case .add: 1
        case .subtract: 2
        case .multiply: 3
        case .divide: 4
        }
    }

    var exampleProblem: String {
        switch self {
        case .add: "3 + 2 = 5"
        case .subtract: "7 - 3 = 4"
        case .multiply: "4 x 3 = 12"
        case .divide: "8 / 2 = 4"
        }
    }

    var keyboardHint: String {
        switch self {
        case .add: "A"
        case .subtract: "S"
        case .multiply: "M"
        case .divide: "D"
        }
    }

    var isCommutative: Bool {
        switch self {
        case .add, .multiply: true
        case .subtract, .divide: false
        }
    }

    var inverse: Operation {
        switch self {
        case .add: .subtract
        case .subtract: .add
        case .multiply: .divide
        case .divide: .multiply
        }
    }

    var accessibilityName: String {
        switch self {
        case .add: "plus"
        case .subtract: "minus"
        case .multiply: "times"
        case .divide: "divided by"
        }
    }
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

    var accessibilityText: String {
        "\(operand1) \(operation.accessibilityName) \(operand2)"
    }

    var displayTextWithAnswer: String {
        "\(displayText) = \(correctAnswer)"
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

extension MathProblem {
    var hintText: String {
        switch operation {
        case .add:
            return "Try combining \(operand1) and \(operand2) together"
        case .subtract:
            return "Take away \(operand2) from \(operand1)"
        case .multiply:
            return "Think of \(operand1) groups of \(operand2)"
        case .divide:
            return "Split \(operand1) into \(operand2) equal parts"
        }
    }
}

extension MathProblem {
    var inverseProblem: MathProblem {
        MathProblem(operand1: correctAnswer, operand2: operand2, operation: operation.inverse)
    }
}

extension MathProblem {
    var formattedAnswer: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: correctAnswer)) ?? "\(correctAnswer)"
    }
}

extension MathProblem {
    var estimatedSeconds: Double {
        let baseDifficulty: Double
        switch operation {
        case .add: baseDifficulty = 2.0
        case .subtract: baseDifficulty = 2.5
        case .multiply: baseDifficulty = 4.0
        case .divide: baseDifficulty = 3.5
        }
        let operandFactor = Double(max(abs(operand1), abs(operand2))) / 10.0
        return baseDifficulty + operandFactor
    }
}

extension MathProblem {
    var wrongAnswerChoices: [Int] {
        let answer = correctAnswer
        var choices: Set<Int> = []
        // Generate plausible wrong answers near the correct one
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
}

extension MathProblem {
    var answerDigitCount: Int {
        let answer = abs(correctAnswer)
        if answer == 0 { return 1 }
        return String(answer).count
    }
}

enum AnswerMagnitude: Sendable {
    case small, medium, large
}

extension MathProblem {
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
        let opScore = operation.difficultyRank // 1-4
        let sizeScore = (operand1 + operand2) / 10 // rough operand size
        let raw = opScore + sizeScore
        return min(max(raw, 1), 10)
    }

    var answerMagnitude: AnswerMagnitude {
        let answer = abs(correctAnswer)
        if answer < 20 { return .small }
        if answer < 100 { return .medium }
        return .large
    }
}

struct AnsweredProblem: Identifiable, Sendable {
    let id = UUID()
    let problem: MathProblem
    let userAnswer: Int
    var timeTaken: Double?
    var isCorrect: Bool { problem.isCorrect(answer: userAnswer) }

    var timeLabel: String? {
        guard let time = timeTaken, time > 0 else { return nil }
        return String(format: "%.1fs", time)
    }
}
