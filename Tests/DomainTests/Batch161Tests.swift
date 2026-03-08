import Testing
@testable import MathKids

@Suite("Batch 161 Tests")
struct Batch161Tests {

    // MARK: - logic-884: isDoubleDigitUserAnswer

    @Test
    func isDoubleDigitUserAnswer_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 42)
        #expect(answered.isDoubleDigitUserAnswer == true)
    }

    @Test
    func isDoubleDigitUserAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.isDoubleDigitUserAnswer == false)
    }

    // MARK: - logic-885: operandBothEven

    @Test
    func operandBothEven_yes() {
        let problem = MathProblem(operand1: 4, operand2: 6, operation: .add)
        #expect(problem.operandBothEven == true)
    }

    @Test
    func operandBothEven_no() {
        let problem = MathProblem(operand1: 3, operand2: 6, operation: .add)
        #expect(problem.operandBothEven == false)
    }

    // MARK: - logic-886: isAdditionOfEquals

    @Test
    func isAdditionOfEquals_yes() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(problem.isAdditionOfEquals == true)
    }

    @Test
    func isAdditionOfEquals_notAdd() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .subtract)
        #expect(problem.isAdditionOfEquals == false)
    }

    @Test
    func isAdditionOfEquals_different() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.isAdditionOfEquals == false)
    }

    // MARK: - logic-887: problemTypeLabel

    @Test
    func problemTypeLabel_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(!answered.problemTypeLabel.isEmpty)
    }

    @Test
    func problemTypeLabel_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(!answered.problemTypeLabel.isEmpty)
    }

    // MARK: - logic-888: answerWasZero

    @Test
    func answerWasZero_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 0)
        #expect(answered.answerWasZero == true)
    }

    @Test
    func answerWasZero_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerWasZero == false)
    }
}
