import Testing
@testable import MathKids

@Suite("Batch 163 Tests")
struct Batch163Tests {

    // MARK: - logic-894: operandBothSingleDigit

    @Test
    func operandBothSingleDigit_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.operandBothSingleDigit == true)
    }

    @Test
    func operandBothSingleDigit_no() {
        let problem = MathProblem(operand1: 12, operand2: 4, operation: .add)
        #expect(problem.operandBothSingleDigit == false)
    }

    // MARK: - logic-895: isDoubleCorrectAnswer

    @Test
    func isDoubleCorrectAnswer_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 14)
        #expect(answered.isDoubleCorrectAnswer == true)
    }

    @Test
    func isDoubleCorrectAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 8)
        #expect(answered.isDoubleCorrectAnswer == false)
    }

    // MARK: - logic-896: difficultyScoreLabel

    @Test
    func difficultyScoreLabel_easy() {
        #expect(!DifficultyLevel.easy.difficultyScoreLabel.isEmpty)
    }

    @Test
    func difficultyScoreLabel_hard() {
        #expect(!DifficultyLevel.hard.difficultyScoreLabel.isEmpty)
    }

    // MARK: - logic-897: answerWasDoubled

    @Test
    func answerWasDoubled_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 6)
        #expect(answered.answerWasDoubled == true)
    }

    @Test
    func answerWasDoubled_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.answerWasDoubled == false)
    }

    // MARK: - logic-898: problemIsEasy

    @Test
    func problemIsEasy_yes() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.problemIsEasy == true)
    }

    @Test
    func problemIsEasy_no() {
        let problem = MathProblem(operand1: 12, operand2: 8, operation: .multiply)
        #expect(problem.problemIsEasy == false)
    }
}
