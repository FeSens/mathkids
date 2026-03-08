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
}
