import Testing
@testable import MathKids

@Suite("Batch 225 Tests")
struct Batch225Tests {

    // MARK: - logic-1204: answeredProblemAttemptSummary

    @Test
    func answeredProblemAttemptSummary_correctWithTime() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 2.0)
        #expect(a.answeredProblemAttemptSummary.contains("2.0"))
    }

    @Test
    func answeredProblemAttemptSummary_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemAttemptSummary == "Incorrect")
    }

    // MARK: - logic-1205: answeredProblemIsPerfectScore

    @Test
    func answeredProblemIsPerfectScore_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemIsPerfectScore == true)
    }

    @Test
    func answeredProblemIsPerfectScore_slow() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsPerfectScore == false)
    }

    // MARK: - logic-1206: answeredProblemWeightedScore

    @Test
    func answeredProblemWeightedScore_correctFast() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemWeightedScore > 0)
    }

    @Test
    func answeredProblemWeightedScore_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemWeightedScore == 0)
    }

    // MARK: - logic-1207: answeredProblemHintWouldHelp

    @Test
    func answeredProblemHintWouldHelp_close() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 6)
        #expect(a.answeredProblemHintWouldHelp == true)
    }

    @Test
    func answeredProblemHintWouldHelp_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemHintWouldHelp == false)
    }

    // MARK: - logic-1208: answeredProblemLogEntry

    @Test
    func answeredProblemLogEntry_containsInfo() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemLogEntry.contains("add"))
        #expect(a.answeredProblemLogEntry.contains("correct"))
    }
}
