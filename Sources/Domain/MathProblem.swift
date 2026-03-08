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

    var isAdvanced: Bool {
        switch self {
        case .multiply, .divide: true
        case .add, .subtract: false
        }
    }

    var isBasicOperation: Bool {
        switch self {
        case .add, .subtract: true
        case .multiply, .divide: false
        }
    }

    var descriptionWithExample: String {
        "\(displayName) (\(exampleProblem))"
    }

    var precedence: Int {
        switch self {
        case .add, .subtract: 1
        case .multiply, .divide: 2
        }
    }

    var symbolWithSpaces: String {
        " \(rawValue) "
    }

    static var sortedByDifficulty: [Operation] {
        allCases.sorted { $0.difficultyRank < $1.difficultyRank }
    }

    static var allPairs: [(Operation, Operation)] {
        var pairs: [(Operation, Operation)] = []
        let ops = allCases
        for i in 0..<ops.count {
            for j in (i + 1)..<ops.count {
                pairs.append((ops[i], ops[j]))
            }
        }
        return pairs
    }

    static func pairDescription(_ a: Operation, _ b: Operation) -> String {
        if a == b { return a.displayName }
        return "\(a.displayName) & \(b.displayName)"
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
