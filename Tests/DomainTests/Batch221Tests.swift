import Testing
@testable import MathKids

@Suite("Batch 221 Tests")
struct Batch221Tests {

    // MARK: - logic-1184: answeredProblemPerformanceLevel

    @Test
    func answeredProblemPerformanceLevel_excellent() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemPerformanceLevel == "excellent")
    }

    @Test
    func answeredProblemPerformanceLevel_needsPractice() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemPerformanceLevel == "needs practice")
    }

    // MARK: - logic-1185: answeredProblemCorrectAnswerText

    @Test
    func answeredProblemCorrectAnswerText() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemCorrectAnswerText.contains("5"))
    }

    // MARK: - logic-1186: answeredProblemIsSlowAnswer

    @Test
    func answeredProblemIsSlowAnswer_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 10.0)
        #expect(a.answeredProblemIsSlowAnswer == true)
    }

    @Test
    func answeredProblemIsSlowAnswer_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 2.0)
        #expect(a.answeredProblemIsSlowAnswer == false)
    }

    // MARK: - logic-1187: answeredProblemStarCount

    @Test
    func answeredProblemStarCount_correctFast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemStarCount == 3)
    }

    @Test
    func answeredProblemStarCount_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemStarCount == 0)
    }

    // MARK: - logic-1188: answeredProblemNeedsHelp

    @Test
    func answeredProblemNeedsHelp_farOff() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 10)
        #expect(a.answeredProblemNeedsHelp == true)
    }

    @Test
    func answeredProblemNeedsHelp_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemNeedsHelp == false)
    }
}
