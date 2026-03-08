import Testing
@testable import MathKids

@Suite("Batch 169 Tests")
struct Batch169Tests {

    // MARK: - logic-924: answerMatchesOperand

    @Test
    func answerMatchesOperand_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 3)
        #expect(answered.answerMatchesOperand == true)
    }

    @Test
    func answerMatchesOperand_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerMatchesOperand == false)
    }

    // MARK: - logic-925: difficultyAllowsDivide

    @Test
    func difficultyAllowsDivide_hard() {
        #expect(DifficultyLevel.hard.difficultyAllowsDivide == true)
    }

    @Test
    func difficultyAllowsDivide_check() {
        let _ = DifficultyLevel.easy.difficultyAllowsDivide
    }

    // MARK: - logic-926: isWrongAnswer

    @Test
    func isWrongAnswer_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.isWrongAnswer == true)
    }

    @Test
    func isWrongAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.isWrongAnswer == false)
    }

    // MARK: - logic-927: problemHasCarrying

    @Test
    func problemHasCarrying_yes() {
        let problem = MathProblem(operand1: 8, operand2: 5, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 13)
        #expect(answered.problemHasCarrying == true)
    }

    @Test
    func problemHasCarrying_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.problemHasCarrying == false)
    }

    // MARK: - logic-928: difficultyPointsLabel

    @Test
    func difficultyPointsLabel_easy() {
        #expect(!DifficultyLevel.easy.difficultyPointsLabel.isEmpty)
    }

    @Test
    func difficultyPointsLabel_hard() {
        #expect(!DifficultyLevel.hard.difficultyPointsLabel.isEmpty)
    }
}
