import Testing
@testable import MathKids

@Suite("Batch 159 Tests")
struct Batch159Tests {

    // MARK: - logic-874: userAnswerIsEven

    @Test
    func userAnswerIsEven_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 8)
        #expect(answered.userAnswerIsEven == true)
    }

    @Test
    func userAnswerIsEven_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.userAnswerIsEven == false)
    }

    // MARK: - logic-875: isHardOperation

    @Test
    func isHardOperation_multiply() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(problem.isHardOperation == true)
    }

    @Test
    func isHardOperation_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isHardOperation == false)
    }

    // MARK: - logic-876: operandSumIsEven

    @Test
    func operandSumIsEven_yes() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.operandSumIsEven == true)
    }

    @Test
    func operandSumIsEven_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.operandSumIsEven == false)
    }

    // MARK: - logic-877: problemLabel

    @Test
    func problemLabel_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(!problem.problemLabel.isEmpty)
    }

    @Test
    func problemLabel_multiply() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(!problem.problemLabel.isEmpty)
    }

    // MARK: - logic-878: isLargeOperandGap

    @Test
    func isLargeOperandGap_yes() {
        let problem = MathProblem(operand1: 12, operand2: 3, operation: .add)
        #expect(problem.isLargeOperandGap == true)
    }

    @Test
    func isLargeOperandGap_no() {
        let problem = MathProblem(operand1: 4, operand2: 5, operation: .add)
        #expect(problem.isLargeOperandGap == false)
    }
}
