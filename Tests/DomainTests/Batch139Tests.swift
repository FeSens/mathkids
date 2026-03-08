import Testing
@testable import MathKids

@Suite("Batch 139 Tests")
struct Batch139Tests {

    // MARK: - logic-774: answerIsPositive

    @Test
    func answerIsPositive_yes() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.answerIsPositive == true)
    }

    @Test
    func answerIsPositive_zero() {
        let problem = MathProblem(operand1: 3, operand2: 3, operation: .subtract)
        #expect(problem.answerIsPositive == false)
    }

    // MARK: - logic-775: operandAverage

    @Test
    func operandAverage() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.operandAverage == 4.0)
    }

    @Test
    func operandAverage_odd() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.operandAverage == 3.5)
    }

    // MARK: - logic-776: isLargeAnswer

    @Test
    func isLargeAnswer_yes() {
        let problem = MathProblem(operand1: 30, operand2: 25, operation: .add)
        #expect(problem.isLargeAnswer == true)
    }

    @Test
    func isLargeAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isLargeAnswer == false)
    }

    // MARK: - logic-777: operandSumText

    @Test
    func operandSumText() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(problem.operandSumText == "8")
    }

    // MARK: - logic-778: hasEvenAnswer

    @Test
    func hasEvenAnswer_yes() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        // 3 + 5 = 8 (even)
        #expect(problem.hasEvenAnswer == true)
    }

    @Test
    func hasEvenAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        // 3 + 4 = 7 (odd)
        #expect(problem.hasEvenAnswer == false)
    }
}
