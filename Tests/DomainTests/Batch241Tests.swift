import Testing
@testable import MathKids

@Suite("Batch 241 Tests")
struct Batch241Tests {

    // MARK: - logic-1284: answeredProblemLeaderboardScore

    @Test
    func answeredProblemLeaderboardScore_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(Int(a.answeredProblemLeaderboardScore) != nil)
    }

    @Test
    func answeredProblemLeaderboardScore_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemLeaderboardScore == "0")
    }

    // MARK: - logic-1285: answeredProblemIsNewRecord

    @Test
    func answeredProblemIsNewRecord_true() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2, timeTaken: 0.5)
        #expect(a.answeredProblemIsNewRecord == true)
    }

    @Test
    func answeredProblemIsNewRecord_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsNewRecord == false)
    }

    // MARK: - logic-1286: answeredProblemTicketReward

    @Test
    func answeredProblemTicketReward_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemTicketReward == 1)
    }

    @Test
    func answeredProblemTicketReward_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemTicketReward == 0)
    }

    // MARK: - logic-1287: answeredProblemPowerUpCharge

    @Test
    func answeredProblemPowerUpCharge_fast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemPowerUpCharge == 2)
    }

    @Test
    func answeredProblemPowerUpCharge_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemPowerUpCharge == 0)
    }

    // MARK: - logic-1288: answeredProblemQuestProgress

    @Test
    func answeredProblemQuestProgress_correct() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemQuestProgress == 3)
    }

    @Test
    func answeredProblemQuestProgress_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemQuestProgress == 0)
    }
}
