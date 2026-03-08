import Testing
@testable import MathKids

@Suite("Batch 151 Tests")
struct Batch151Tests {

    // MARK: - logic-834: expectedProblemsPerMinute

    @Test
    func expectedProblemsPerMinute_easy() {
        #expect(DifficultyLevel.easy.expectedProblemsPerMinute > 0)
    }

    @Test
    func expectedProblemsPerMinute_hardHigher() {
        #expect(DifficultyLevel.hard.expectedProblemsPerMinute >= DifficultyLevel.easy.expectedProblemsPerMinute)
    }

    // MARK: - logic-835: motivationalQuote

    @Test
    func motivationalQuote_easy() {
        #expect(!DifficultyLevel.easy.motivationalQuote.isEmpty)
    }

    @Test
    func motivationalQuote_unique() {
        #expect(DifficultyLevel.easy.motivationalQuote != DifficultyLevel.hard.motivationalQuote)
    }

    // MARK: - logic-836: operationName

    @Test
    func operationName_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.operationName == "Addition")
    }

    // MARK: - logic-837: answerDifference

    @Test
    func answerDifference_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.answerDifference == 2)
    }

    @Test
    func answerDifference_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerDifference == 0)
    }

    // MARK: - logic-838: wasClose

    @Test
    func wasClose_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 8)
        #expect(answered.wasClose == true)
    }

    @Test
    func wasClose_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 20)
        #expect(answered.wasClose == false)
    }
}
