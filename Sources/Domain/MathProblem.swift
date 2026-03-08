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
