import Testing
@testable import MathKids

@Suite("Batch 213 Tests")
struct Batch213Tests {

    // MARK: - logic-1144: problemIsPerfectSquareAnswer

    @Test
    func problemIsPerfectSquareAnswer_true() {
        let p = MathProblem(operand1: 3, operand2: 3, operation: .multiply)
        #expect(p.problemIsPerfectSquareAnswer == true)
    }

    @Test
    func problemIsPerfectSquareAnswer_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsPerfectSquareAnswer == false)
    }

    // MARK: - logic-1145: problemOperandSumIsEven

    @Test
    func problemOperandSumIsEven_true() {
        let p = MathProblem(operand1: 2, operand2: 4, operation: .add)
        #expect(p.problemOperandSumIsEven == true)
    }

    @Test
    func problemOperandSumIsEven_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemOperandSumIsEven == false)
    }

    // MARK: - logic-1146: problemFlashcardFront

    @Test
    func problemFlashcardFront_containsOperands() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemFlashcardFront.contains("3"))
        #expect(p.problemFlashcardFront.contains("4"))
    }

    // MARK: - logic-1147: problemFlashcardBack

    @Test
    func problemFlashcardBack_containsAnswer() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemFlashcardBack.contains("7"))
    }

    // MARK: - logic-1148: problemIsMultiplyByTwo

    @Test
    func problemIsMultiplyByTwo_true() {
        let p = MathProblem(operand1: 3, operand2: 2, operation: .multiply)
        #expect(p.problemIsMultiplyByTwo == true)
    }

    @Test
    func problemIsMultiplyByTwo_false() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(p.problemIsMultiplyByTwo == false)
    }
}
