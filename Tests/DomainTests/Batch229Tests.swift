import Testing
@testable import MathKids

@Suite("Batch 229 Tests")
struct Batch229Tests {

    // MARK: - logic-1224: answeredProblemErrorType

    @Test
    func answeredProblemErrorType_none() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemErrorType == "none")
    }

    @Test
    func answeredProblemErrorType_offByOne() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 6)
        #expect(a.answeredProblemErrorType == "off-by-one")
    }

    // MARK: - logic-1225: answeredProblemStreakValue

    @Test
    func answeredProblemStreakValue_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemStreakValue == 1)
    }

    @Test
    func answeredProblemStreakValue_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemStreakValue == 0)
    }

    // MARK: - logic-1226: answeredProblemIsBasicFact

    @Test
    func answeredProblemIsBasicFact_true() {
        let p = MathProblem(operand1: 5, operand2: 7, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsBasicFact == true)
    }

    @Test
    func answeredProblemIsBasicFact_false() {
        let p = MathProblem(operand1: 12, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 15)
        #expect(a.answeredProblemIsBasicFact == false)
    }

    // MARK: - logic-1227: answeredProblemFeedbackSound

    @Test
    func answeredProblemFeedbackSound_perfect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemFeedbackSound == "perfect")
    }

    @Test
    func answeredProblemFeedbackSound_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemFeedbackSound == "wrong")
    }

    // MARK: - logic-1228: answeredProblemAnalyticsEvent

    @Test
    func answeredProblemAnalyticsEvent_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemAnalyticsEvent == "problem_correct")
    }

    @Test
    func answeredProblemAnalyticsEvent_incorrect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemAnalyticsEvent == "problem_incorrect")
    }
}
