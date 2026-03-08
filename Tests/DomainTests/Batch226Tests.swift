import Testing
@testable import MathKids

@Suite("Batch 226 Tests")
struct Batch226Tests {

    // MARK: - logic-1209: answeredProblemConfidenceLevel

    @Test
    func answeredProblemConfidenceLevel_high() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemConfidenceLevel == "high")
    }

    @Test
    func answeredProblemConfidenceLevel_low() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 9.0)
        #expect(a.answeredProblemConfidenceLevel == "low")
    }

    // MARK: - logic-1210: answeredProblemIsWorthReview

    @Test
    func answeredProblemIsWorthReview_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemIsWorthReview == true)
    }

    @Test
    func answeredProblemIsWorthReview_correctFast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemIsWorthReview == false)
    }

    // MARK: - logic-1211: answeredProblemProgressColor

    @Test
    func answeredProblemProgressColor_gold() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemProgressColor == "gold")
    }

    @Test
    func answeredProblemProgressColor_red() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemProgressColor == "red")
    }

    // MARK: - logic-1212: answeredProblemOperandCount

    @Test
    func answeredProblemOperandCount() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemOperandCount == 2)
    }

    // MARK: - logic-1213: answeredProblemIsMastered

    @Test
    func answeredProblemIsMastered_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemIsMastered == true)
    }

    @Test
    func answeredProblemIsMastered_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsMastered == false)
    }
}
