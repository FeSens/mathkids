import Testing
@testable import MathKids

@Suite("Batch 217 Tests")
struct Batch217Tests {

    // MARK: - logic-1164: answeredProblemSpeedRating

    @Test
    func answeredProblemSpeedRating_fast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.5)
        #expect(a.answeredProblemSpeedRating == "fast")
    }

    @Test
    func answeredProblemSpeedRating_slow() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 9.0)
        #expect(a.answeredProblemSpeedRating == "slow")
    }

    // MARK: - logic-1165: answeredProblemFullResultText

    @Test
    func answeredProblemFullResultText_containsEmoji() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemFullResultText.contains("✅"))
    }

    // MARK: - logic-1166: answeredProblemWasClose

    @Test
    func answeredProblemWasClose_offByOne() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 6)
        #expect(a.answeredProblemWasClose == true)
    }

    @Test
    func answeredProblemWasClose_offByThree() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 8)
        #expect(a.answeredProblemWasClose == false)
    }

    // MARK: - logic-1167: answeredProblemOperationName

    @Test
    func answeredProblemOperationName_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemOperationName == "Addition")
    }

    // MARK: - logic-1168: answeredProblemIsHardOperation

    @Test
    func answeredProblemIsHardOperation_multiply() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsHardOperation == true)
    }

    @Test
    func answeredProblemIsHardOperation_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsHardOperation == false)
    }
}
