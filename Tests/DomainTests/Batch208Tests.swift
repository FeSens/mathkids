import Testing
@testable import MathKids

@Suite("Batch 208 Tests")
struct Batch208Tests {

    // MARK: - logic-1119: problemShareText

    @Test
    func problemShareText_containsAnswer() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemShareText.contains("5"))
    }

    // MARK: - logic-1120: problemIsIdentityOperation

    @Test
    func problemIsIdentityOperation_addZero() {
        let p = MathProblem(operand1: 0, operand2: 3, operation: .add)
        #expect(p.problemIsIdentityOperation == true)
    }

    @Test
    func problemIsIdentityOperation_addNonZero() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsIdentityOperation == false)
    }

    // MARK: - logic-1121: problemIsLargeAnswer

    @Test
    func problemIsLargeAnswer_true() {
        let p = MathProblem(operand1: 9, operand2: 9, operation: .multiply)
        #expect(p.problemIsLargeAnswer == true)
    }

    @Test
    func problemIsLargeAnswer_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsLargeAnswer == false)
    }

    // MARK: - logic-1122: problemOperandRatio

    @Test
    func problemOperandRatio_value() {
        let p = MathProblem(operand1: 2, operand2: 6, operation: .add)
        #expect(p.problemOperandRatio == 3.0)
    }

    // MARK: - logic-1123: problemEstimatedTimeSeconds

    @Test
    func problemEstimatedTimeSeconds_addFaster() {
        let addP = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let divP = MathProblem(operand1: 6, operand2: 3, operation: .divide)
        #expect(addP.problemEstimatedTimeSeconds <= divP.problemEstimatedTimeSeconds)
    }
}
