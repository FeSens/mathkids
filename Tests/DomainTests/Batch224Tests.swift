import Testing
@testable import MathKids

@Suite("Batch 224 Tests")
struct Batch224Tests {

    // MARK: - logic-1199: answeredProblemTimeCategory

    @Test
    func answeredProblemTimeCategory_instant() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemTimeCategory == "instant")
    }

    @Test
    func answeredProblemTimeCategory_slow() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 10.0)
        #expect(a.answeredProblemTimeCategory == "slow")
    }

    // MARK: - logic-1200: answeredProblemScorePercentage

    @Test
    func answeredProblemScorePercentage_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemScorePercentage == 100)
    }

    @Test
    func answeredProblemScorePercentage_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemScorePercentage == 0)
    }

    // MARK: - logic-1201: answeredProblemDetailedFeedback

    @Test
    func answeredProblemDetailedFeedback_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDetailedFeedback.contains("Correct"))
    }

    @Test
    func answeredProblemDetailedFeedback_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemDetailedFeedback.contains("5"))
    }

    // MARK: - logic-1202: answeredProblemIsEasyProblem

    @Test
    func answeredProblemIsEasyProblem_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsEasyProblem == true)
    }

    @Test
    func answeredProblemIsEasyProblem_false() {
        let p = MathProblem(operand1: 8, operand2: 7, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 15)
        #expect(a.answeredProblemIsEasyProblem == false)
    }

    // MARK: - logic-1203: answeredProblemResponseQuality

    @Test
    func answeredProblemResponseQuality_perfect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemResponseQuality == "perfect")
    }

    @Test
    func answeredProblemResponseQuality_incorrect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemResponseQuality == "incorrect")
    }
}
