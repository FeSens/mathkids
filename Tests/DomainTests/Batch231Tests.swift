import Testing
@testable import MathKids

@Suite("Batch 231 Tests")
struct Batch231Tests {

    // MARK: - logic-1234: answeredProblemCoinReward

    @Test
    func answeredProblemCoinReward_correct() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemCoinReward == 3)
    }

    @Test
    func answeredProblemCoinReward_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemCoinReward == 0)
    }

    // MARK: - logic-1235: answeredProblemIsSingleDigitAnswer

    @Test
    func answeredProblemIsSingleDigitAnswer_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsSingleDigitAnswer == true)
    }

    @Test
    func answeredProblemIsSingleDigitAnswer_false() {
        let p = MathProblem(operand1: 5, operand2: 7, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsSingleDigitAnswer == false)
    }

    // MARK: - logic-1236: answeredProblemLearningPhase

    @Test
    func answeredProblemLearningPhase_mastered() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemLearningPhase == "mastered")
    }

    @Test
    func answeredProblemLearningPhase_memorizing() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 10.0)
        #expect(a.answeredProblemLearningPhase == "memorizing")
    }

    // MARK: - logic-1237: answeredProblemOperandRange

    @Test
    func answeredProblemOperandRange_singleDigit() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemOperandRange == "single-digit")
    }

    @Test
    func answeredProblemOperandRange_multiDigit() {
        let p = MathProblem(operand1: 12, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 15)
        #expect(a.answeredProblemOperandRange == "multi-digit")
    }

    // MARK: - logic-1238: answeredProblemTimeBucket

    @Test
    func answeredProblemTimeBucket_fast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemTimeBucket == "0-2s")
    }

    @Test
    func answeredProblemTimeBucket_medium() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 7.0)
        #expect(a.answeredProblemTimeBucket == "5-10s")
    }
}
