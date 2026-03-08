import Testing
@testable import MathKids

@Suite("Batch 240 Tests")
struct Batch240Tests {

    // MARK: - logic-1279: answeredProblemMilestoneProgress

    @Test
    func answeredProblemMilestoneProgress_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemMilestoneProgress.contains("%"))
    }

    @Test
    func answeredProblemMilestoneProgress_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemMilestoneProgress == "0%")
    }

    // MARK: - logic-1280: answeredProblemIsGoldStar

    @Test
    func answeredProblemIsGoldStar_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemIsGoldStar == true)
    }

    @Test
    func answeredProblemIsGoldStar_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsGoldStar == false)
    }

    // MARK: - logic-1281: answeredProblemScoreLabel

    @Test
    func answeredProblemScoreLabel_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemScoreLabel.hasPrefix("+"))
    }

    @Test
    func answeredProblemScoreLabel_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemScoreLabel == "+0")
    }

    // MARK: - logic-1282: answeredProblemDifficultyBonus

    @Test
    func answeredProblemDifficultyBonus_hard() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemDifficultyBonus > 0)
    }

    @Test
    func answeredProblemDifficultyBonus_easy() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDifficultyBonus == 0)
    }

    // MARK: - logic-1283: answeredProblemProgressPoints

    @Test
    func answeredProblemProgressPoints_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemProgressPoints == 1)
    }

    @Test
    func answeredProblemProgressPoints_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemProgressPoints == 0)
    }
}
