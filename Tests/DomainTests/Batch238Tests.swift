import Testing
@testable import MathKids

@Suite("Batch 238 Tests")
struct Batch238Tests {

    // MARK: - logic-1269: answeredProblemLevelUpEligible

    @Test
    func answeredProblemLevelUpEligible_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemLevelUpEligible == true)
    }

    @Test
    func answeredProblemLevelUpEligible_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemLevelUpEligible == false)
    }

    // MARK: - logic-1270: answeredProblemSpeedBonus

    @Test
    func answeredProblemSpeedBonus_instant() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemSpeedBonus == 5)
    }

    @Test
    func answeredProblemSpeedBonus_normal() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemSpeedBonus == 0)
    }

    // MARK: - logic-1271: answeredProblemAccuracyScore

    @Test
    func answeredProblemAccuracyScore_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemAccuracyScore == 100)
    }

    @Test
    func answeredProblemAccuracyScore_offByOne() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 6)
        #expect(a.answeredProblemAccuracyScore == 80)
    }

    // MARK: - logic-1272: answeredProblemChallengeTier

    @Test
    func answeredProblemChallengeTier_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemChallengeTier == "tier1")
    }

    @Test
    func answeredProblemChallengeTier_divide() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemChallengeTier == "tier4")
    }

    // MARK: - logic-1273: answeredProblemPenaltyPoints

    @Test
    func answeredProblemPenaltyPoints_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemPenaltyPoints == 0)
    }

    @Test
    func answeredProblemPenaltyPoints_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 8)
        #expect(a.answeredProblemPenaltyPoints == 6)
    }
}
