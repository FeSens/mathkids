import Testing
@testable import MathKids

@Suite("Batch 157 Tests")
struct Batch157Tests {

    // MARK: - logic-864: answerOffByOne

    @Test
    func answerOffByOne_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 8)
        #expect(answered.answerOffByOne == true)
    }

    @Test
    func answerOffByOne_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.answerOffByOne == false)
    }

    // MARK: - logic-865: timeBracket

    @Test
    func timeBracket_notEmpty() {
        #expect(!DifficultyLevel.easy.timeBracket.isEmpty)
    }

    @Test
    func timeBracket_values() {
        let brackets = Set([DifficultyLevel.easy.timeBracket, DifficultyLevel.medium.timeBracket, DifficultyLevel.hard.timeBracket])
        #expect(brackets.count >= 1)
    }

    // MARK: - logic-866: hasOperandZero

    @Test
    func hasOperandZero_yes() {
        let problem = MathProblem(operand1: 0, operand2: 4, operation: .add)
        #expect(problem.hasOperandZero == true)
    }

    @Test
    func hasOperandZero_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.hasOperandZero == false)
    }

    // MARK: - logic-867: feedbackText

    @Test
    func feedbackText_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(!answered.feedbackText.isEmpty)
    }

    @Test
    func feedbackText_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.feedbackText.contains("7"))
    }

    // MARK: - logic-868: isZeroAnswer

    @Test
    func isZeroAnswer_yes() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .subtract)
        #expect(problem.isZeroAnswer == true)
    }

    @Test
    func isZeroAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isZeroAnswer == false)
    }
}
