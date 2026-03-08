import Testing
@testable import MathKids

@Suite("Batch 219 Tests")
struct Batch219Tests {

    // MARK: - logic-1174: answeredProblemDifficultyTag

    @Test
    func answeredProblemDifficultyTag_easy() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDifficultyTag == "easy")
    }

    @Test
    func answeredProblemDifficultyTag_hard() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemDifficultyTag == "hard")
    }

    // MARK: - logic-1175: answeredProblemTimeBonusEligible

    @Test
    func answeredProblemTimeBonusEligible_fast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.5)
        #expect(a.answeredProblemTimeBonusEligible == true)
    }

    @Test
    func answeredProblemTimeBonusEligible_slow() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemTimeBonusEligible == false)
    }

    // MARK: - logic-1176: answeredProblemMissedByLabel

    @Test
    func answeredProblemMissedByLabel_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 7)
        #expect(a.answeredProblemMissedByLabel.contains("2"))
    }

    @Test
    func answeredProblemMissedByLabel_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemMissedByLabel == "")
    }

    // MARK: - logic-1177: answeredProblemIsMultiDigitProblem

    @Test
    func answeredProblemIsMultiDigitProblem_true() {
        let p = MathProblem(operand1: 12, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 15)
        #expect(a.answeredProblemIsMultiDigitProblem == true)
    }

    @Test
    func answeredProblemIsMultiDigitProblem_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsMultiDigitProblem == false)
    }

    // MARK: - logic-1178: answeredProblemRetryRecommended

    @Test
    func answeredProblemRetryRecommended_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemRetryRecommended == true)
    }

    @Test
    func answeredProblemRetryRecommended_correctFast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemRetryRecommended == false)
    }
}
