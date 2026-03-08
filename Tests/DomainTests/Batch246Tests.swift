import Testing
@testable import MathKids

@Suite("Batch 246 Tests")
struct Batch246Tests {

    // MARK: - logic-1309: answeredProblemLootDrop

    @Test
    func answeredProblemLootDrop_rare() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 0.5)
        #expect(a.answeredProblemLootDrop == "rare")
    }

    @Test
    func answeredProblemLootDrop_none() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemLootDrop == "none")
    }

    // MARK: - logic-1310: answeredProblemScoreColor

    @Test
    func answeredProblemScoreColor_gold() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemScoreColor == "gold")
    }

    @Test
    func answeredProblemScoreColor_gray() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemScoreColor == "gray")
    }

    // MARK: - logic-1311: answeredProblemIsBonusRound

    @Test
    func answeredProblemIsBonusRound_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsBonusRound == true)
    }

    @Test
    func answeredProblemIsBonusRound_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsBonusRound == false)
    }

    // MARK: - logic-1312: answeredProblemTrophyCount

    @Test
    func answeredProblemTrophyCount_two() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemTrophyCount == 2)
    }

    @Test
    func answeredProblemTrophyCount_zero() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemTrophyCount == 0)
    }

    // MARK: - logic-1313: answeredProblemFinalVerdict

    @Test
    func answeredProblemFinalVerdict_perfect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemFinalVerdict == "perfect")
    }

    @Test
    func answeredProblemFinalVerdict_fail() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemFinalVerdict == "fail")
    }
}
