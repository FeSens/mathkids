import Testing
@testable import MathKids

@Suite("Batch 237 Tests")
struct Batch237Tests {

    // MARK: - logic-1264: answeredProblemBonusMultiplier

    @Test
    func answeredProblemBonusMultiplier_fast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemBonusMultiplier == 2)
    }

    @Test
    func answeredProblemBonusMultiplier_slow() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemBonusMultiplier == 1)
    }

    // MARK: - logic-1265: answeredProblemIsStreakBreaker

    @Test
    func answeredProblemIsStreakBreaker_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemIsStreakBreaker == true)
    }

    @Test
    func answeredProblemIsStreakBreaker_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsStreakBreaker == false)
    }

    // MARK: - logic-1266: answeredProblemRewardTier

    @Test
    func answeredProblemRewardTier_platinum() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemRewardTier == "platinum")
    }

    @Test
    func answeredProblemRewardTier_none() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemRewardTier == "none")
    }

    // MARK: - logic-1267: answeredProblemComboValue

    @Test
    func answeredProblemComboValue_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemComboValue == 1)
    }

    @Test
    func answeredProblemComboValue_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemComboValue == -1)
    }

    // MARK: - logic-1268: answeredProblemExperienceCategory

    @Test
    func answeredProblemExperienceCategory_expert() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemExperienceCategory == "expert")
    }

    @Test
    func answeredProblemExperienceCategory_novice() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 10.0)
        #expect(a.answeredProblemExperienceCategory == "novice")
    }
}
