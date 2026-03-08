import Testing
@testable import MathKids

@Suite("Batch 206 Tests")
struct Batch206Tests {

    // MARK: - logic-1109: problemHintText

    @Test
    func problemHintText_notEmpty() {
        for op in [Operation.add, .subtract, .multiply, .divide] {
            let p = MathProblem(operand1: 3, operand2: 2, operation: op)
            #expect(!p.problemHintText.isEmpty)
        }
    }

    // MARK: - logic-1110: problemBothOperandsSingleDigit

    @Test
    func problemBothOperandsSingleDigit_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemBothOperandsSingleDigit == true)
    }

    // MARK: - logic-1111: problemHasZeroOperand

    @Test
    func problemHasZeroOperand_true() {
        let p = MathProblem(operand1: 0, operand2: 3, operation: .add)
        #expect(p.problemHasZeroOperand == true)
    }

    @Test
    func problemHasZeroOperand_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemHasZeroOperand == false)
    }

    // MARK: - logic-1112: problemHasOneOperand

    @Test
    func problemHasOneOperand_true() {
        let p = MathProblem(operand1: 1, operand2: 3, operation: .add)
        #expect(p.problemHasOneOperand == true)
    }

    @Test
    func problemHasOneOperand_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemHasOneOperand == false)
    }

    // MARK: - logic-1113: problemAccessibilityHint

    @Test
    func problemAccessibilityHint_containsOperation() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemAccessibilityHint.contains("Addition"))
    }
}
