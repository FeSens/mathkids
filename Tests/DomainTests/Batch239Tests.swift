import Testing
@testable import MathKids

@Suite("Batch 239 Tests")
struct Batch239Tests {

    // MARK: - logic-1274: answeredProblemTotalScore

    @Test
    func answeredProblemTotalScore_correctFast() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemTotalScore > 0)
    }

    @Test
    func answeredProblemTotalScore_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemTotalScore == 0)
    }

    // MARK: - logic-1275: answeredProblemAchievementCandidate

    @Test
    func answeredProblemAchievementCandidate_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemAchievementCandidate == true)
    }

    @Test
    func answeredProblemAchievementCandidate_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemAchievementCandidate == false)
    }

    // MARK: - logic-1276: answeredProblemStreakMultiplier

    @Test
    func answeredProblemStreakMultiplier_fast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemStreakMultiplier == 3)
    }

    @Test
    func answeredProblemStreakMultiplier_slow() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemStreakMultiplier == 1)
    }

    // MARK: - logic-1277: answeredProblemGemReward

    @Test
    func answeredProblemGemReward_instant() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemGemReward == 1)
    }

    @Test
    func answeredProblemGemReward_slow() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemGemReward == 0)
    }

    // MARK: - logic-1278: answeredProblemRankPoints

    @Test
    func answeredProblemRankPoints_correct() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemRankPoints > 5)
    }

    @Test
    func answeredProblemRankPoints_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemRankPoints == 0)
    }
}
