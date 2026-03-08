import Testing
@testable import MathKids

@Suite("Batch 209 Tests")
struct Batch209Tests {

    // MARK: - logic-1124: problemSolvedText

    @Test
    func problemSolvedText_containsAnswer() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemSolvedText.contains("= 5"))
    }

    // MARK: - logic-1125: problemIsTrivial

    @Test
    func problemIsTrivial_zeroZero() {
        let p = MathProblem(operand1: 0, operand2: 0, operation: .add)
        #expect(p.problemIsTrivial == true)
    }

    @Test
    func problemIsTrivial_nonTrivial() {
        let p = MathProblem(operand1: 7, operand2: 8, operation: .add)
        #expect(p.problemIsTrivial == false)
    }

    // MARK: - logic-1126: problemOperandAverage

    @Test
    func problemOperandAverage_value() {
        let p = MathProblem(operand1: 2, operand2: 4, operation: .add)
        #expect(p.problemOperandAverage == 3.0)
    }

    // MARK: - logic-1127: problemDifficultyLevel

    @Test
    func problemDifficultyLevel_small() {
        let p = MathProblem(operand1: 1, operand2: 2, operation: .add)
        #expect(p.problemDifficultyLevel == "easy")
    }

    // MARK: - logic-1128: problemIsCommutative

    @Test
    func problemIsCommutative_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(p.problemIsCommutative == true)
    }

    @Test
    func problemIsCommutative_subtract() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(p.problemIsCommutative == false)
    }
}
