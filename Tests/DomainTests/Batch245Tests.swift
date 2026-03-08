import Testing
@testable import MathKids

@Suite("Batch 245 Tests")
struct Batch245Tests {

    // MARK: - logic-1304: answeredProblemCompletionReward

    @Test
    func answeredProblemCompletionReward_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemCompletionReward.contains("XP"))
    }

    @Test
    func answeredProblemCompletionReward_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemCompletionReward.contains("0"))
    }

    // MARK: - logic-1305: answeredProblemIsHighScore

    @Test
    func answeredProblemIsHighScore_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemIsHighScore == true)
    }

    @Test
    func answeredProblemIsHighScore_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsHighScore == false)
    }

    // MARK: - logic-1306: answeredProblemStreakBonus

    @Test
    func answeredProblemStreakBonus_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemStreakBonus > 0)
    }

    @Test
    func answeredProblemStreakBonus_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemStreakBonus == 0)
    }

    // MARK: - logic-1307: answeredProblemIsMVPAnswer

    @Test
    func answeredProblemIsMVPAnswer_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 0.5)
        #expect(a.answeredProblemIsMVPAnswer == true)
    }

    @Test
    func answeredProblemIsMVPAnswer_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsMVPAnswer == false)
    }

    // MARK: - logic-1308: answeredProblemRewardEmoji

    @Test
    func answeredProblemRewardEmoji_diamond() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 0.5)
        #expect(a.answeredProblemRewardEmoji == "💎")
    }

    @Test
    func answeredProblemRewardEmoji_none() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemRewardEmoji == "")
    }
}
