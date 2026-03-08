import Testing
@testable import MathKids

@Suite("Batch 235 Tests")
struct Batch235Tests {

    // MARK: - logic-1254: answeredProblemAccessibilityAction

    @Test
    func answeredProblemAccessibilityAction_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemAccessibilityAction.contains("correct"))
    }

    @Test
    func answeredProblemAccessibilityAction_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemAccessibilityAction.contains("incorrect"))
    }

    // MARK: - logic-1255: answeredProblemIsDoubleDigitProblem

    @Test
    func answeredProblemIsDoubleDigitProblem_true() {
        let p = MathProblem(operand1: 12, operand2: 15, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 27)
        #expect(a.answeredProblemIsDoubleDigitProblem == true)
    }

    @Test
    func answeredProblemIsDoubleDigitProblem_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsDoubleDigitProblem == false)
    }

    // MARK: - logic-1256: answeredProblemRetentionScore

    @Test
    func answeredProblemRetentionScore_perfect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemRetentionScore == 10)
    }

    @Test
    func answeredProblemRetentionScore_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemRetentionScore == 0)
    }

    // MARK: - logic-1257: answeredProblemAnimationType

    @Test
    func answeredProblemAnimationType_confetti() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemAnimationType == "confetti")
    }

    @Test
    func answeredProblemAnimationType_shake() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemAnimationType == "shake")
    }

    // MARK: - logic-1258: answeredProblemSessionContribution

    @Test
    func answeredProblemSessionContribution_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemSessionContribution.contains("100%"))
    }

    @Test
    func answeredProblemSessionContribution_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemSessionContribution.contains("0%"))
    }
}
