import Testing
@testable import MathKids

@Suite("Batch 155 Tests")
struct Batch155Tests {

    // MARK: - logic-854: isDivisionProblem

    @Test
    func isDivisionProblem_yes() {
        let problem = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let answered = AnsweredProblem(problem: problem, userAnswer: 2)
        #expect(answered.isDivisionProblem == true)
    }

    @Test
    func isDivisionProblem_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.isDivisionProblem == false)
    }

    // MARK: - logic-855: isCorrectAndFast

    @Test
    func isCorrectAndFast_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 2.0)
        #expect(answered.isCorrectAndFast == true)
    }

    @Test
    func isCorrectAndFast_slow() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 5.0)
        #expect(answered.isCorrectAndFast == false)
    }

    @Test
    func isCorrectAndFast_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 2.0)
        #expect(answered.isCorrectAndFast == false)
    }

    // MARK: - logic-856: problemDescription

    @Test
    func problemDescription_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.problemDescription.contains("3"))
        #expect(problem.problemDescription.contains("4"))
    }

    @Test
    func problemDescription_multiply() {
        let problem = MathProblem(operand1: 6, operand2: 2, operation: .multiply)
        #expect(problem.problemDescription.contains("6"))
        #expect(problem.problemDescription.contains("2"))
    }

    // MARK: - logic-857: requiredOperationCount

    @Test
    func requiredOperationCount_easy() {
        #expect(!DifficultyLevel.easy.requiredOperationCount.isEmpty)
    }

    @Test
    func requiredOperationCount_hard() {
        #expect(!DifficultyLevel.hard.requiredOperationCount.isEmpty)
    }

    // MARK: - logic-858: difficultyColorName

    @Test
    func difficultyColorName_easy() {
        #expect(DifficultyLevel.easy.difficultyColorName == "green")
    }

    @Test
    func difficultyColorName_hard() {
        #expect(DifficultyLevel.hard.difficultyColorName == "red")
    }
}
