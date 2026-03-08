import Testing
@testable import MathKids

@Suite("Batch 223 Tests")
struct Batch223Tests {

    // MARK: - logic-1194: answeredProblemAccuracyEmoji

    @Test
    func answeredProblemAccuracyEmoji_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemAccuracyEmoji == "🎯")
    }

    @Test
    func answeredProblemAccuracyEmoji_close() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 6)
        #expect(a.answeredProblemAccuracyEmoji == "🔶")
    }

    @Test
    func answeredProblemAccuracyEmoji_far() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 10)
        #expect(a.answeredProblemAccuracyEmoji == "🔴")
    }

    // MARK: - logic-1195: answeredProblemCompactResult

    @Test
    func answeredProblemCompactResult_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemCompactResult.contains("✓"))
    }

    // MARK: - logic-1196: answeredProblemShouldCelebrate

    @Test
    func answeredProblemShouldCelebrate_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemShouldCelebrate == true)
    }

    @Test
    func answeredProblemShouldCelebrate_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemShouldCelebrate == false)
    }

    // MARK: - logic-1197: answeredProblemOperationSymbol

    @Test
    func answeredProblemOperationSymbol_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemOperationSymbol == "+")
    }

    @Test
    func answeredProblemOperationSymbol_multiply() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemOperationSymbol == "x")
    }

    // MARK: - logic-1198: answeredProblemMaxPoints

    @Test
    func answeredProblemMaxPoints_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemMaxPoints == 10)
    }

    @Test
    func answeredProblemMaxPoints_multiply() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemMaxPoints == 30)
    }
}
