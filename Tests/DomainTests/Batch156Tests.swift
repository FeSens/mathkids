import Testing
@testable import MathKids

@Suite("Batch 156 Tests")
struct Batch156Tests {

    // MARK: - logic-859: answerWasNegative

    @Test
    func answerWasNegative_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: -3)
        #expect(answered.answerWasNegative == true)
    }

    @Test
    func answerWasNegative_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerWasNegative == false)
    }

    // MARK: - logic-860: isSimpleOperation

    @Test
    func isSimpleOperation_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isSimpleOperation == true)
    }

    @Test
    func isSimpleOperation_multiply() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(problem.isSimpleOperation == false)
    }

    // MARK: - logic-861: timeLimitDescription

    @Test
    func timeLimitDescription_easy() {
        #expect(!DifficultyLevel.easy.timeLimitDescription.isEmpty)
    }

    @Test
    func timeLimitDescription_containsTime() {
        let desc = DifficultyLevel.hard.timeLimitDescription
        #expect(desc.contains("\(DifficultyLevel.hard.timeLimitSeconds)"))
    }

    // MARK: - logic-862: problemSummary

    @Test
    func problemSummary_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.problemSummary.contains("7"))
    }

    @Test
    func problemSummary_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.problemSummary.contains("7"))
    }

    // MARK: - logic-863: difficultyTag

    @Test
    func difficultyTag_short() {
        #expect(DifficultyLevel.easy.difficultyTag.count <= 10)
    }

    @Test
    func difficultyTag_unique() {
        #expect(DifficultyLevel.easy.difficultyTag != DifficultyLevel.hard.difficultyTag)
    }
}
