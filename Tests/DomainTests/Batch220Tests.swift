import Testing
@testable import MathKids

@Suite("Batch 220 Tests")
struct Batch220Tests {

    // MARK: - logic-1179: answeredProblemEncouragementText

    @Test
    func answeredProblemEncouragementText_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemEncouragementText.contains("Great"))
    }

    @Test
    func answeredProblemEncouragementText_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemEncouragementText.contains("Try again"))
    }

    // MARK: - logic-1180: answeredProblemIsFirstAttempt

    @Test
    func answeredProblemIsFirstAttempt_noTime() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsFirstAttempt == true)
    }

    @Test
    func answeredProblemIsFirstAttempt_withTime() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 3.0)
        #expect(a.answeredProblemIsFirstAttempt == false)
    }

    // MARK: - logic-1181: answeredProblemGrade

    @Test
    func answeredProblemGrade_correctFast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemGrade == "A")
    }

    @Test
    func answeredProblemGrade_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemGrade == "F")
    }

    // MARK: - logic-1182: answeredProblemIsBonus

    @Test
    func answeredProblemIsBonus_correctMultiply() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsBonus == true)
    }

    @Test
    func answeredProblemIsBonus_correctAdd() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsBonus == false)
    }

    // MARK: - logic-1183: answeredProblemSummaryIcon

    @Test
    func answeredProblemSummaryIcon_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemSummaryIcon == "checkmark.circle.fill")
    }

    @Test
    func answeredProblemSummaryIcon_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemSummaryIcon == "xmark.circle.fill")
    }
}
