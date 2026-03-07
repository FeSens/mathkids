import Foundation

struct ProblemGenerator: Sendable {
    func generate(for difficulty: DifficultyLevel) -> MathProblem {
        let operation = difficulty.allowedOperations.randomElement()!
        let range = difficulty.operandRange

        switch operation {
        case .add:
            let a = Int.random(in: range)
            let b = Int.random(in: range)
            return MathProblem(operand1: a, operand2: b, operation: .add)

        case .subtract:
            var a = Int.random(in: range)
            var b = Int.random(in: range)
            if difficulty == .easy && a < b {
                swap(&a, &b)
            }
            return MathProblem(operand1: a, operand2: b, operation: .subtract)

        case .multiply:
            let a = Int.random(in: 1...min(12, range.upperBound))
            let b = Int.random(in: 1...min(12, range.upperBound))
            return MathProblem(operand1: a, operand2: b, operation: .multiply)

        case .divide:
            let divisor = Int.random(in: 1...min(12, range.upperBound))
            let quotient = Int.random(in: 1...min(12, range.upperBound))
            let dividend = divisor * quotient
            return MathProblem(operand1: dividend, operand2: divisor, operation: .divide)
        }
    }
}
