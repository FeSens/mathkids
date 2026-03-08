import Testing
@testable import MathKids

@Suite("Batch 228 Tests")
struct Batch228Tests {

    // MARK: - logic-1219: answeredProblemSkillLevel

    @Test
    func answeredProblemSkillLevel_beginner() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemSkillLevel == "beginner")
    }

    @Test
    func answeredProblemSkillLevel_advanced() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemSkillLevel == "advanced")
    }

    // MARK: - logic-1220: answeredProblemIsCommutativeProblem

    @Test
    func answeredProblemIsCommutativeProblem_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsCommutativeProblem == true)
    }

    @Test
    func answeredProblemIsCommutativeProblem_subtract() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemIsCommutativeProblem == false)
    }

    // MARK: - logic-1221: answeredProblemMasteryScore

    @Test
    func answeredProblemMasteryScore_perfect() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemMasteryScore == 100)
    }

    @Test
    func answeredProblemMasteryScore_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemMasteryScore == 0)
    }

    // MARK: - logic-1222: answeredProblemAnswerWasHigher

    @Test
    func answeredProblemAnswerWasHigher_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 7)
        #expect(a.answeredProblemAnswerWasHigher == true)
    }

    @Test
    func answeredProblemAnswerWasHigher_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 3)
        #expect(a.answeredProblemAnswerWasHigher == false)
    }

    // MARK: - logic-1223: answeredProblemAnswerWasLower

    @Test
    func answeredProblemAnswerWasLower_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 3)
        #expect(a.answeredProblemAnswerWasLower == true)
    }

    @Test
    func answeredProblemAnswerWasLower_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 7)
        #expect(a.answeredProblemAnswerWasLower == false)
    }
}
