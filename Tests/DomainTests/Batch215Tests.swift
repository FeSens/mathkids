import Testing
@testable import MathKids

@Suite("Batch 215 Tests")
struct Batch215Tests {

    // MARK: - logic-1154: answeredProblemFeedbackEmoji

    @Test
    func answeredProblemFeedbackEmoji_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemFeedbackEmoji == "✅")
    }

    @Test
    func answeredProblemFeedbackEmoji_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemFeedbackEmoji == "❌")
    }

    // MARK: - logic-1155: answeredProblemScoreContribution

    @Test
    func answeredProblemScoreContribution_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemScoreContribution > 0)
    }

    @Test
    func answeredProblemScoreContribution_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemScoreContribution == 0)
    }

    // MARK: - logic-1156: answeredProblemDisplayText

    @Test
    func answeredProblemDisplayText_containsUserAnswer() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDisplayText.contains("5"))
    }

    // MARK: - logic-1157: answeredProblemTimeTakenLabel

    @Test
    func answeredProblemTimeTakenLabel_containsSeconds() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 3.5)
        #expect(a.answeredProblemTimeTakenLabel.contains("s"))
    }

    // MARK: - logic-1158: answeredProblemAccessibilityResult

    @Test
    func answeredProblemAccessibilityResult_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemAccessibilityResult.contains("Correct"))
    }
}
