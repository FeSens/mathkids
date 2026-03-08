import Testing
@testable import MathKids

@Suite("Batch 205 Tests")
struct Batch205Tests {

    // MARK: - logic-1104: problemOperandProduct

    @Test
    func problemOperandProduct_value() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(p.problemOperandProduct == 12)
    }

    // MARK: - logic-1105: problemOperandDifference

    @Test
    func problemOperandDifference_value() {
        let p = MathProblem(operand1: 2, operand2: 5, operation: .add)
        #expect(p.problemOperandDifference == 3)
    }

    // MARK: - logic-1106: problemIsEqualOperands

    @Test
    func problemIsEqualOperands_equal() {
        let p = MathProblem(operand1: 3, operand2: 3, operation: .add)
        #expect(p.problemIsEqualOperands == true)
    }

    @Test
    func problemIsEqualOperands_notEqual() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsEqualOperands == false)
    }

    // MARK: - logic-1107: problemReadAloudText

    @Test
    func problemReadAloudText_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemReadAloudText.contains("plus"))
    }

    // MARK: - logic-1108: problemAnswerDigitCount

    @Test
    func problemAnswerDigitCount_singleDigit() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemAnswerDigitCount == 1)
    }

    @Test
    func problemAnswerDigitCount_doubleDigit() {
        let p = MathProblem(operand1: 7, operand2: 8, operation: .add)
        #expect(p.problemAnswerDigitCount == 2)
    }
}
