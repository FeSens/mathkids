import Testing
@testable import MathKids

@Suite("Batch 207 Tests")
struct Batch207Tests {

    // MARK: - logic-1114: problemIsDoubleDigitAnswer

    @Test
    func problemIsDoubleDigitAnswer_true() {
        let p = MathProblem(operand1: 7, operand2: 8, operation: .add)
        #expect(p.problemIsDoubleDigitAnswer == true)
    }

    @Test
    func problemIsDoubleDigitAnswer_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsDoubleDigitAnswer == false)
    }

    // MARK: - logic-1115: problemOperandsAreConsecutive

    @Test
    func problemOperandsAreConsecutive_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemOperandsAreConsecutive == true)
    }

    @Test
    func problemOperandsAreConsecutive_false() {
        let p = MathProblem(operand1: 2, operand2: 5, operation: .add)
        #expect(p.problemOperandsAreConsecutive == false)
    }

    // MARK: - logic-1116: problemIsEasyByOperands

    @Test
    func problemIsEasyByOperands_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsEasyByOperands == true)
    }

    @Test
    func problemIsEasyByOperands_false() {
        let p = MathProblem(operand1: 7, operand2: 8, operation: .add)
        #expect(p.problemIsEasyByOperands == false)
    }

    // MARK: - logic-1117: problemTotalDigits

    @Test
    func problemTotalDigits_singleDigits() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemTotalDigits == 2)
    }

    // MARK: - logic-1118: problemCategoryLabel

    @Test
    func problemCategoryLabel_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemCategoryLabel.lowercased().contains("addition"))
    }
}
