import Testing
@testable import MathKids

@Suite("Batch 210 Tests")
struct Batch210Tests {

    // MARK: - logic-1129: problemIsTableFact

    @Test
    func problemIsTableFact_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(p.problemIsTableFact == true)
    }

    // MARK: - logic-1130: problemReversedText

    @Test
    func problemReversedText_value() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemReversedText.contains("3"))
        #expect(p.problemReversedText.contains("2"))
    }

    // MARK: - logic-1131: problemIsSquare

    @Test
    func problemIsSquare_true() {
        let p = MathProblem(operand1: 3, operand2: 3, operation: .multiply)
        #expect(p.problemIsSquare == true)
    }

    @Test
    func problemIsSquare_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .multiply)
        #expect(p.problemIsSquare == false)
    }

    // MARK: - logic-1132: problemBadgeLabel

    @Test
    func problemBadgeLabel_containsSymbol() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemBadgeLabel.contains("+"))
    }

    // MARK: - logic-1133: problemPointValue

    @Test
    func problemPointValue_addLessThanDivide() {
        let addP = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let divP = MathProblem(operand1: 6, operand2: 3, operation: .divide)
        #expect(addP.problemPointValue <= divP.problemPointValue)
    }
}
