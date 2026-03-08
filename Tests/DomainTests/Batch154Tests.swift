import Testing
@testable import MathKids

@Suite("Batch 154 Tests")
struct Batch154Tests {

    // MARK: - logic-849: isAdditionProblem

    @Test
    func isAdditionProblem_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.isAdditionProblem == true)
    }

    @Test
    func isAdditionProblem_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let answered = AnsweredProblem(problem: problem, userAnswer: 12)
        #expect(answered.isAdditionProblem == false)
    }

    // MARK: - logic-850: problemDifficultyStars

    @Test
    func problemDifficultyStars_simple() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.problemDifficultyStars <= 2)
    }

    @Test
    func problemDifficultyStars_complex() {
        let problem = MathProblem(operand1: 12, operand2: 8, operation: .multiply)
        #expect(problem.problemDifficultyStars >= 3)
    }

    // MARK: - logic-851: wasTimedOut

    @Test
    func wasTimedOut_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.wasTimedOut == true)
    }

    @Test
    func wasTimedOut_noWithTime() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 8.0)
        #expect(answered.wasTimedOut == false)
    }

    @Test
    func wasTimedOut_noWhenCorrect() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.wasTimedOut == false)
    }

    // MARK: - logic-852: operandMax

    @Test
    func operandMax_different() {
        let problem = MathProblem(operand1: 8, operand2: 3, operation: .add)
        #expect(problem.operandMax == 8)
    }

    @Test
    func operandMax_same() {
        let problem = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(problem.operandMax == 4)
    }

    // MARK: - logic-853: isMultiplicationProblem

    @Test
    func isMultiplicationProblem_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let answered = AnsweredProblem(problem: problem, userAnswer: 12)
        #expect(answered.isMultiplicationProblem == true)
    }

    @Test
    func isMultiplicationProblem_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.isMultiplicationProblem == false)
    }
}
