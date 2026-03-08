import Testing
@testable import MathKids

@Suite("Batch 148 Tests")
struct Batch148Tests {

    // MARK: - logic-819: warmupProblems

    @Test
    func warmupProblems_easy() {
        #expect(DifficultyLevel.easy.warmupProblems == 0)
    }

    @Test
    func warmupProblems_hard() {
        #expect(DifficultyLevel.hard.warmupProblems == 3)
    }

    // MARK: - logic-820: hasTimePressure

    @Test
    func hasTimePressure_easy() {
        #expect(DifficultyLevel.easy.hasTimePressure == false)
    }

    @Test
    func hasTimePressure_hard() {
        #expect(DifficultyLevel.hard.hasTimePressure == true)
    }

    // MARK: - logic-821: hasLargeOperands

    @Test
    func hasLargeOperands_yes() {
        let problem = MathProblem(operand1: 12, operand2: 3, operation: .add)
        #expect(problem.hasLargeOperands == true)
    }

    @Test
    func hasLargeOperands_no() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.hasLargeOperands == false)
    }

    // MARK: - logic-822: answerChoiceRange

    @Test
    func answerChoiceRange_containsAnswer() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let range = problem.answerChoiceRange
        #expect(range.contains(7))
    }

    @Test
    func answerChoiceRange_hasWidth() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let range = problem.answerChoiceRange
        #expect(range.count > 5)
    }

    // MARK: - logic-823: reviewText

    @Test
    func reviewText_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        let text = answered.reviewText
        #expect(text.contains("5"))
        #expect(text.contains("7"))
    }

    @Test
    func reviewText_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        let text = answered.reviewText
        #expect(text.contains("7"))
    }
}
