import Testing
@testable import MathKids

@Suite("Batch 211 Tests")
struct Batch211Tests {

    // MARK: - logic-1134: problemIsTensComplement

    @Test
    func problemIsTensComplement_true() {
        let p = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(p.problemIsTensComplement == true)
    }

    @Test
    func problemIsTensComplement_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsTensComplement == false)
    }

    // MARK: - logic-1135: problemIsDouble

    @Test
    func problemIsDouble_true() {
        let p = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(p.problemIsDouble == true)
    }

    @Test
    func problemIsDouble_false() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemIsDouble == false)
    }

    // MARK: - logic-1136: problemQuestionMark

    @Test
    func problemQuestionMark_containsQuestionMark() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemQuestionMark.contains("?"))
    }

    // MARK: - logic-1137: problemOperandParity

    @Test
    func problemOperandParity_sameParity() {
        let p = MathProblem(operand1: 2, operand2: 4, operation: .add)
        #expect(p.problemOperandParity == true)
    }

    @Test
    func problemOperandParity_differentParity() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemOperandParity == false)
    }

    // MARK: - logic-1138: problemNumberBondLabel

    @Test
    func problemNumberBondLabel_containsOperands() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemNumberBondLabel.contains("3"))
        #expect(p.problemNumberBondLabel.contains("4"))
    }
}
