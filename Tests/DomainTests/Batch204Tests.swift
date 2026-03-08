import Testing
@testable import MathKids

@Suite("Batch 204 Tests")
struct Batch204Tests {

    // MARK: - logic-1099: problemDisplayText

    @Test
    func problemDisplayText_containsOperands() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemDisplayText.contains("3"))
        #expect(p.problemDisplayText.contains("4"))
    }

    // MARK: - logic-1100: problemAnswerChoices

    @Test
    func problemAnswerChoices_containsCorrect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemAnswerChoices.contains(p.correctAnswer))
    }

    @Test
    func problemAnswerChoices_hasFourItems() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemAnswerChoices.count == 4)
    }

    // MARK: - logic-1101: problemOperandSum

    @Test
    func problemOperandSum_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemOperandSum == 5)
    }

    // MARK: - logic-1102: problemMaxOperand

    @Test
    func problemMaxOperand_value() {
        let p = MathProblem(operand1: 2, operand2: 5, operation: .add)
        #expect(p.problemMaxOperand == 5)
    }

    // MARK: - logic-1103: problemMinOperand

    @Test
    func problemMinOperand_value() {
        let p = MathProblem(operand1: 2, operand2: 5, operation: .add)
        #expect(p.problemMinOperand == 2)
    }
}
