import Testing
@testable import MathKids

@Suite("Batch 214 Tests")
struct Batch214Tests {

    // MARK: - logic-1149: problemIsDivideByOne

    @Test
    func problemIsDivideByOne_true() {
        let p = MathProblem(operand1: 6, operand2: 1, operation: .divide)
        #expect(p.problemIsDivideByOne == true)
    }

    @Test
    func problemIsDivideByOne_false() {
        let p = MathProblem(operand1: 6, operand2: 2, operation: .divide)
        #expect(p.problemIsDivideByOne == false)
    }

    // MARK: - logic-1150: problemAnswerIsZero

    @Test
    func problemAnswerIsZero_true() {
        let p = MathProblem(operand1: 3, operand2: 3, operation: .subtract)
        #expect(p.problemAnswerIsZero == true)
    }

    @Test
    func problemAnswerIsZero_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemAnswerIsZero == false)
    }

    // MARK: - logic-1151: problemIsAddToSelf

    @Test
    func problemIsAddToSelf_true() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(p.problemIsAddToSelf == true)
    }

    @Test
    func problemIsAddToSelf_false() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(p.problemIsAddToSelf == false)
    }

    // MARK: - logic-1152: problemAnswerIsMultipleOfFive

    @Test
    func problemAnswerIsMultipleOfFive_true() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .multiply)
        #expect(p.problemAnswerIsMultipleOfFive == true)
    }

    // MARK: - logic-1153: problemIsMultiplyByFive

    @Test
    func problemIsMultiplyByFive_true() {
        let p = MathProblem(operand1: 3, operand2: 5, operation: .multiply)
        #expect(p.problemIsMultiplyByFive == true)
    }

    @Test
    func problemIsMultiplyByFive_false() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(p.problemIsMultiplyByFive == false)
    }
}
