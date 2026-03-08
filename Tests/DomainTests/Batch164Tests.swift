import Testing
@testable import MathKids

@Suite("Batch 164 Tests")
struct Batch164Tests {

    // MARK: - logic-899: isOperandOneSmaller

    @Test
    func isOperandOneSmaller_yes() {
        let problem = MathProblem(operand1: 3, operand2: 8, operation: .add)
        #expect(problem.isOperandOneSmaller == true)
    }

    @Test
    func isOperandOneSmaller_no() {
        let problem = MathProblem(operand1: 8, operand2: 3, operation: .add)
        #expect(problem.isOperandOneSmaller == false)
    }

    // MARK: - logic-900: difficultyQuickInfo

    @Test
    func difficultyQuickInfo_easy() {
        #expect(DifficultyLevel.easy.difficultyQuickInfo.contains(DifficultyLevel.easy.displayName))
    }

    @Test
    func difficultyQuickInfo_hard() {
        #expect(DifficultyLevel.hard.difficultyQuickInfo.contains(DifficultyLevel.hard.displayName))
    }

    // MARK: - logic-901: isCorrectButSlow

    @Test
    func isCorrectButSlow_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 8.0)
        #expect(answered.isCorrectButSlow == true)
    }

    @Test
    func isCorrectButSlow_fast() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 3.0)
        #expect(answered.isCorrectButSlow == false)
    }

    @Test
    func isCorrectButSlow_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 8.0)
        #expect(answered.isCorrectButSlow == false)
    }

    // MARK: - logic-902: answerPercentageOff

    @Test
    func answerPercentageOff_correct() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 10)
        #expect(answered.answerPercentageOff == 0)
    }

    @Test
    func answerPercentageOff_wrong() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 15)
        #expect(answered.answerPercentageOff == 50)
    }

    // MARK: - logic-903: operationIsCommutative

    @Test
    func operationIsCommutative_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.operationIsCommutative == true)
    }

    @Test
    func operationIsCommutative_subtract() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .subtract)
        #expect(problem.operationIsCommutative == false)
    }
}
