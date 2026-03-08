import Foundation

struct ProblemGenerator {
    private var lastProblem: MathProblem?

    mutating func generate(for difficulty: DifficultyLevel, allowedOperations: Set<Operation>? = nil, adaptiveRange: ClosedRange<Int>? = nil, eloRanges: [Operation: ClosedRange<Int>]? = nil) -> MathProblem {
        var problem: MathProblem
        var attempts = 0
        repeat {
            problem = generateProblem(for: difficulty, allowedOperations: allowedOperations, adaptiveRange: adaptiveRange, eloRanges: eloRanges)
            attempts += 1
        } while problem == lastProblem && attempts < 5
        lastProblem = problem
        return problem
    }

    private func generateProblem(for difficulty: DifficultyLevel, allowedOperations: Set<Operation>? = nil, adaptiveRange: ClosedRange<Int>? = nil, eloRanges: [Operation: ClosedRange<Int>]? = nil) -> MathProblem {
        let available = allowedOperations.map { $0.intersection(Set(difficulty.allowedOperations)) } ?? Set(difficulty.allowedOperations)
        let ops = available.isEmpty ? Set(difficulty.allowedOperations) : available
        let operation = ops.randomElement()!

        // Prefer Elo-based range for this operation, fall back to adaptive, then difficulty default
        let range = eloRanges?[operation] ?? adaptiveRange ?? difficulty.operandRange

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
