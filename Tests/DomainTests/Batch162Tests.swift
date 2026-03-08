import Testing
@testable import MathKids

@Suite("Batch 162 Tests")
struct Batch162Tests {

    // MARK: - logic-889: operandBothOdd

    @Test
    func operandBothOdd_yes() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.operandBothOdd == true)
    }

    @Test
    func operandBothOdd_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.operandBothOdd == false)
    }

    // MARK: - logic-890: isMultiplyByZero

    @Test
    func isMultiplyByZero_yes() {
        let problem = MathProblem(operand1: 0, operand2: 5, operation: .multiply)
        #expect(problem.isMultiplyByZero == true)
    }

    @Test
    func isMultiplyByZero_no() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .multiply)
        #expect(problem.isMultiplyByZero == false)
    }

    // MARK: - logic-891: timeTakenCategory

    @Test
    func timeTakenCategory_fast() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 2.0)
        #expect(answered.timeTakenCategory == "fast")
    }

    @Test
    func timeTakenCategory_nil() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.timeTakenCategory == "unknown")
    }

    // MARK: - logic-892: answerErrorMargin

    @Test
    func answerErrorMargin_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerErrorMargin == 0)
    }

    @Test
    func answerErrorMargin_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.answerErrorMargin > 0)
    }

    // MARK: - logic-893: isTripleDigitAnswer

    @Test
    func isTripleDigitAnswer_yes() {
        let problem = MathProblem(operand1: 50, operand2: 3, operation: .multiply)
        #expect(problem.isTripleDigitAnswer == true)
    }

    @Test
    func isTripleDigitAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isTripleDigitAnswer == false)
    }
}
