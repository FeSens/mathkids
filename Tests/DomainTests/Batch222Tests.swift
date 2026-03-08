import Testing
@testable import MathKids

@Suite("Batch 222 Tests")
struct Batch222Tests {

    // MARK: - logic-1189: answeredProblemXpEarned

    @Test
    func answeredProblemXpEarned_correctFast() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemXpEarned > 0)
    }

    @Test
    func answeredProblemXpEarned_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemXpEarned == 0)
    }

    // MARK: - logic-1190: answeredProblemIsAddition

    @Test
    func answeredProblemIsAddition_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsAddition == true)
    }

    @Test
    func answeredProblemIsAddition_false() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsAddition == false)
    }

    // MARK: - logic-1191: answeredProblemIsSubtraction

    @Test
    func answeredProblemIsSubtraction_true() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemIsSubtraction == true)
    }

    @Test
    func answeredProblemIsSubtraction_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsSubtraction == false)
    }

    // MARK: - logic-1192: answeredProblemIsMultiplication

    @Test
    func answeredProblemIsMultiplication_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsMultiplication == true)
    }

    @Test
    func answeredProblemIsMultiplication_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsMultiplication == false)
    }

    // MARK: - logic-1193: answeredProblemIsDivision

    @Test
    func answeredProblemIsDivision_true() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemIsDivision == true)
    }

    @Test
    func answeredProblemIsDivision_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsDivision == false)
    }
}
