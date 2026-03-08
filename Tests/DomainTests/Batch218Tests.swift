import Testing
@testable import MathKids

@Suite("Batch 218 Tests")
struct Batch218Tests {

    // MARK: - logic-1169: answeredProblemCardColor

    @Test
    func answeredProblemCardColor_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemCardColor == "green")
    }

    @Test
    func answeredProblemCardColor_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemCardColor == "red")
    }

    // MARK: - logic-1170: answeredProblemPointsEarned

    @Test
    func answeredProblemPointsEarned_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemPointsEarned > 0)
    }

    @Test
    func answeredProblemPointsEarned_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemPointsEarned == 0)
    }

    // MARK: - logic-1171: answeredProblemReviewPriority

    @Test
    func answeredProblemReviewPriority_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemReviewPriority == 1)
    }

    // MARK: - logic-1172: answeredProblemStreakEligible

    @Test
    func answeredProblemStreakEligible_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemStreakEligible == true)
    }

    @Test
    func answeredProblemStreakEligible_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemStreakEligible == false)
    }

    // MARK: - logic-1173: answeredProblemBadgeEmoji

    @Test
    func answeredProblemBadgeEmoji_correctFast() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemBadgeEmoji == "⭐")
    }

    @Test
    func answeredProblemBadgeEmoji_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemBadgeEmoji == "✗")
    }
}
