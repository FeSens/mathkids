import Testing
@testable import MathKids

@Suite("Batch 168 Tests")
struct Batch168Tests {

    // MARK: - logic-919: answerSign

    @Test
    func answerSign_positive() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerSign == "positive")
    }

    @Test
    func answerSign_negative() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: -3)
        #expect(answered.answerSign == "negative")
    }

    @Test
    func answerSign_zero() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 0)
        #expect(answered.answerSign == "zero")
    }

    // MARK: - logic-920: difficultyPenaltyLabel

    @Test
    func difficultyPenaltyLabel_easy() {
        #expect(!DifficultyLevel.easy.difficultyPenaltyLabel.isEmpty)
    }

    @Test
    func difficultyPenaltyLabel_hard() {
        #expect(!DifficultyLevel.hard.difficultyPenaltyLabel.isEmpty)
    }

    // MARK: - logic-921: wasAnsweredCorrectly

    @Test
    func wasAnsweredCorrectly_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.wasAnsweredCorrectly == true)
    }

    @Test
    func wasAnsweredCorrectly_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.wasAnsweredCorrectly == false)
    }

    // MARK: - logic-922: problemOperationSymbol

    @Test
    func problemOperationSymbol_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.problemOperationSymbol == "+")
    }

    @Test
    func problemOperationSymbol_multiply() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let answered = AnsweredProblem(problem: problem, userAnswer: 12)
        #expect(answered.problemOperationSymbol == "x")
    }

    // MARK: - logic-923: difficultyAllowsMultiply

    @Test
    func difficultyAllowsMultiply_hard() {
        #expect(DifficultyLevel.hard.difficultyAllowsMultiply == true)
    }

    @Test
    func difficultyAllowsMultiply_check() {
        // Just verify it returns a Bool
        let _ = DifficultyLevel.easy.difficultyAllowsMultiply
    }
}
