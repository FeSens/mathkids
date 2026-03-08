import Testing
@testable import MathKids

@Suite("Batch 165 Tests")
struct Batch165Tests {

    // MARK: - logic-904: answerConfidence

    @Test
    func answerConfidence_high() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 2.0)
        #expect(answered.answerConfidence == "high")
    }

    @Test
    func answerConfidence_low() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 8.0)
        #expect(answered.answerConfidence == "low")
    }

    // MARK: - logic-905: difficultyTier

    @Test
    func difficultyTier_easy() {
        #expect(DifficultyLevel.easy.difficultyTier == 1)
    }

    @Test
    func difficultyTier_hard() {
        #expect(DifficultyLevel.hard.difficultyTier == 3)
    }

    // MARK: - logic-906: isSlowWrongAnswer

    @Test
    func isSlowWrongAnswer_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 8.0)
        #expect(answered.isSlowWrongAnswer == true)
    }

    @Test
    func isSlowWrongAnswer_fast() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 3.0)
        #expect(answered.isSlowWrongAnswer == false)
    }

    @Test
    func isSlowWrongAnswer_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 8.0)
        #expect(answered.isSlowWrongAnswer == false)
    }

    // MARK: - logic-907: correctAnswerDigitCount

    @Test
    func correctAnswerDigitCount_single() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.correctAnswerDigitCount == 1)
    }

    @Test
    func correctAnswerDigitCount_double() {
        let problem = MathProblem(operand1: 7, operand2: 5, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 12)
        #expect(answered.correctAnswerDigitCount == 2)
    }

    // MARK: - logic-908: difficultyXpLabel

    @Test
    func difficultyXpLabel_easy() {
        #expect(!DifficultyLevel.easy.difficultyXpLabel.isEmpty)
    }

    @Test
    func difficultyXpLabel_hard() {
        #expect(!DifficultyLevel.hard.difficultyXpLabel.isEmpty)
    }
}
