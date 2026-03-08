import Testing
@testable import MathKids

@Suite("Batch 216 Tests")
struct Batch216Tests {

    // MARK: - logic-1159: answeredProblemCorrectionText

    @Test
    func answeredProblemCorrectionText_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemCorrectionText.contains("5"))
    }

    // MARK: - logic-1160: answeredProblemIsQuick

    @Test
    func answeredProblemIsQuick_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.5)
        #expect(a.answeredProblemIsQuick == true)
    }

    @Test
    func answeredProblemIsQuick_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsQuick == false)
    }

    // MARK: - logic-1161: answeredProblemShareText

    @Test
    func answeredProblemShareText_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemShareText.contains("Got it right"))
    }

    // MARK: - logic-1162: answeredProblemAnswerDelta

    @Test
    func answeredProblemAnswerDelta_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemAnswerDelta == 0)
    }

    @Test
    func answeredProblemAnswerDelta_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 7)
        #expect(a.answeredProblemAnswerDelta == 2)
    }

    // MARK: - logic-1163: answeredProblemResultLabel

    @Test
    func answeredProblemResultLabel_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemResultLabel == "Correct")
    }

    @Test
    func answeredProblemResultLabel_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemResultLabel == "Incorrect")
    }
}
