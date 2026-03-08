import Testing
@testable import MathKids

@Suite("Batch 166 Tests")
struct Batch166Tests {

    // MARK: - logic-909: answerWasHalf

    @Test
    func answerWasHalf_yes() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.answerWasHalf == true)
    }

    @Test
    func answerWasHalf_no() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerWasHalf == false)
    }

    // MARK: - logic-910: difficultyOperandLabel

    @Test
    func difficultyOperandLabel_easy() {
        #expect(!DifficultyLevel.easy.difficultyOperandLabel.isEmpty)
    }

    @Test
    func difficultyOperandLabel_hard() {
        #expect(!DifficultyLevel.hard.difficultyOperandLabel.isEmpty)
    }

    // MARK: - logic-911: problemComplexityScore

    @Test
    func problemComplexityScore_simple() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.problemComplexityScore <= 4)
    }

    @Test
    func problemComplexityScore_complex() {
        let problem = MathProblem(operand1: 12, operand2: 8, operation: .multiply)
        #expect(problem.problemComplexityScore >= 5)
    }

    // MARK: - logic-912: isWrongByLargeMargin

    @Test
    func isWrongByLargeMargin_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 22)
        #expect(answered.isWrongByLargeMargin == true)
    }

    @Test
    func isWrongByLargeMargin_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 8)
        #expect(answered.isWrongByLargeMargin == false)
    }

    // MARK: - logic-913: difficultyTimerLabel

    @Test
    func difficultyTimerLabel_easy() {
        #expect(!DifficultyLevel.easy.difficultyTimerLabel.isEmpty)
    }

    @Test
    func difficultyTimerLabel_hard() {
        #expect(!DifficultyLevel.hard.difficultyTimerLabel.isEmpty)
    }
}
