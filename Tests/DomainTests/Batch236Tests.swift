import Testing
@testable import MathKids

@Suite("Batch 236 Tests")
struct Batch236Tests {

    // MARK: - logic-1259: answeredProblemReviewCategory

    @Test
    func answeredProblemReviewCategory_mastered() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemReviewCategory == "mastered")
    }

    @Test
    func answeredProblemReviewCategory_critical() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemReviewCategory == "critical")
    }

    // MARK: - logic-1260: answeredProblemIsFluent

    @Test
    func answeredProblemIsFluent_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemIsFluent == true)
    }

    @Test
    func answeredProblemIsFluent_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsFluent == false)
    }

    // MARK: - logic-1261: answeredProblemDailyGoalPoints

    @Test
    func answeredProblemDailyGoalPoints_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDailyGoalPoints > 0)
    }

    @Test
    func answeredProblemDailyGoalPoints_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemDailyGoalPoints == 1)
    }

    // MARK: - logic-1262: answeredProblemProblemDescription

    @Test
    func answeredProblemProblemDescription() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        let desc = a.answeredProblemProblemDescription
        #expect(desc.contains("2"))
        #expect(desc.contains("3"))
        #expect(desc.contains("5"))
    }

    // MARK: - logic-1263: answeredProblemMistakePattern

    @Test
    func answeredProblemMistakePattern_none() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemMistakePattern == "none")
    }

    @Test
    func answeredProblemMistakePattern_operandConfusion() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemMistakePattern == "operand-confusion")
    }
}
