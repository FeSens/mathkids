import Testing
@testable import MathKids

@Suite("Batch 227 Tests")
struct Batch227Tests {

    // MARK: - logic-1214: answeredProblemSessionTag

    @Test
    func answeredProblemSessionTag_practice() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemSessionTag == "practice")
    }

    @Test
    func answeredProblemSessionTag_quiz() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemSessionTag == "quiz")
    }

    // MARK: - logic-1215: answeredProblemIsNaturalNumber

    @Test
    func answeredProblemIsNaturalNumber_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsNaturalNumber == true)
    }

    // MARK: - logic-1216: answeredProblemEfficiencyRatio

    @Test
    func answeredProblemEfficiencyRatio_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemEfficiencyRatio == 1.0)
    }

    @Test
    func answeredProblemEfficiencyRatio_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemEfficiencyRatio == 0.0)
    }

    // MARK: - logic-1217: answeredProblemReactionSpeed

    @Test
    func answeredProblemReactionSpeed_lightning() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 0.5)
        #expect(a.answeredProblemReactionSpeed == "lightning")
    }

    @Test
    func answeredProblemReactionSpeed_normal() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemReactionSpeed == "normal")
    }

    // MARK: - logic-1218: answeredProblemProblemComplexity

    @Test
    func answeredProblemProblemComplexity_low() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemProblemComplexity < 10)
    }

    @Test
    func answeredProblemProblemComplexity_high() {
        let p = MathProblem(operand1: 9, operand2: 8, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 72)
        #expect(a.answeredProblemProblemComplexity > 10)
    }
}
