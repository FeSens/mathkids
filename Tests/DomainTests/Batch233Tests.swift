import Testing
@testable import MathKids

@Suite("Batch 233 Tests")
struct Batch233Tests {

    // MARK: - logic-1244: answeredProblemQuizWeight

    @Test
    func answeredProblemQuizWeight_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemQuizWeight == 3)
    }

    @Test
    func answeredProblemQuizWeight_correctFast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemQuizWeight == 1)
    }

    // MARK: - logic-1245: answeredProblemIsPerfectResponse

    @Test
    func answeredProblemIsPerfectResponse_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemIsPerfectResponse == true)
    }

    @Test
    func answeredProblemIsPerfectResponse_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 3.0)
        #expect(a.answeredProblemIsPerfectResponse == false)
    }

    // MARK: - logic-1246: answeredProblemParentReport

    @Test
    func answeredProblemParentReport_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemParentReport.contains("Correct"))
    }

    @Test
    func answeredProblemParentReport_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemParentReport.contains("5"))
    }

    // MARK: - logic-1247: answeredProblemDifficultyLabel

    @Test
    func answeredProblemDifficultyLabel_easy() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDifficultyLabel == "Easy")
    }

    @Test
    func answeredProblemDifficultyLabel_hard() {
        let p = MathProblem(operand1: 9, operand2: 8, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 72)
        #expect(a.answeredProblemDifficultyLabel == "Hard")
    }

    // MARK: - logic-1248: answeredProblemIsBelowExpectation

    @Test
    func answeredProblemIsBelowExpectation_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemIsBelowExpectation == true)
    }

    @Test
    func answeredProblemIsBelowExpectation_correctFast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemIsBelowExpectation == false)
    }
}
