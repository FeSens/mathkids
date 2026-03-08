import Testing
@testable import MathKids

@Suite("Batch 212 Tests")
struct Batch212Tests {

    // MARK: - logic-1139: problemIsNearDouble

    @Test
    func problemIsNearDouble_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemIsNearDouble == true)
    }

    @Test
    func problemIsNearDouble_false() {
        let p = MathProblem(operand1: 2, operand2: 5, operation: .add)
        #expect(p.problemIsNearDouble == false)
    }

    // MARK: - logic-1140: problemSummaryLabel

    @Test
    func problemSummaryLabel_containsOperation() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemSummaryLabel.contains("Addition"))
    }

    // MARK: - logic-1141: problemCorrectAnswerIsOdd

    @Test
    func problemCorrectAnswerIsOdd_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemCorrectAnswerIsOdd == true)
    }

    @Test
    func problemCorrectAnswerIsOdd_false() {
        let p = MathProblem(operand1: 2, operand2: 4, operation: .add)
        #expect(p.problemCorrectAnswerIsOdd == false)
    }

    // MARK: - logic-1142: problemNeedsRegrouping

    @Test
    func problemNeedsRegrouping_true() {
        let p = MathProblem(operand1: 7, operand2: 5, operation: .add)
        #expect(p.problemNeedsRegrouping == true)
    }

    @Test
    func problemNeedsRegrouping_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemNeedsRegrouping == false)
    }

    // MARK: - logic-1143: problemIsMakingTen

    @Test
    func problemIsMakingTen_true() {
        let p = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(p.problemIsMakingTen == true)
    }

    @Test
    func problemIsMakingTen_false() {
        let p = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(p.problemIsMakingTen == false)
    }
}
