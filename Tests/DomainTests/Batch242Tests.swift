import Testing
@testable import MathKids

@Suite("Batch 242 Tests")
struct Batch242Tests {

    // MARK: - logic-1289: answeredProblemStaminaCost

    @Test
    func answeredProblemStaminaCost_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemStaminaCost == 1)
    }

    @Test
    func answeredProblemStaminaCost_multiply() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemStaminaCost == 3)
    }

    // MARK: - logic-1290: answeredProblemChallengeRating

    @Test
    func answeredProblemChallengeRating_S() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 0.5)
        #expect(a.answeredProblemChallengeRating == "S")
    }

    @Test
    func answeredProblemChallengeRating_D() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemChallengeRating == "D")
    }

    // MARK: - logic-1291: answeredProblemUnlockValue

    @Test
    func answeredProblemUnlockValue_correct() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemUnlockValue == 4)
    }

    @Test
    func answeredProblemUnlockValue_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemUnlockValue == 0)
    }

    // MARK: - logic-1292: answeredProblemIsCriticalHit

    @Test
    func answeredProblemIsCriticalHit_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 0.5)
        #expect(a.answeredProblemIsCriticalHit == true)
    }

    @Test
    func answeredProblemIsCriticalHit_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsCriticalHit == false)
    }

    // MARK: - logic-1293: answeredProblemEnergyGain

    @Test
    func answeredProblemEnergyGain_fast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemEnergyGain == 3)
    }

    @Test
    func answeredProblemEnergyGain_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemEnergyGain == 0)
    }
}
