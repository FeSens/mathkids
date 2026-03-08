import Testing
@testable import MathKids

@Suite("Batch 146 Tests")
struct Batch146Tests {

    // MARK: - logic-809: numberOfOperations

    @Test
    func numberOfOperations_easy() {
        let text = DifficultyLevel.easy.numberOfOperations
        #expect(text.contains("operation"))
    }

    // MARK: - logic-810: difficultyPercentage

    @Test
    func difficultyPercentage_easy() {
        #expect(DifficultyLevel.easy.difficultyPercentage == 33)
    }

    @Test
    func difficultyPercentage_hard() {
        #expect(DifficultyLevel.hard.difficultyPercentage == 100)
    }

    // MARK: - logic-811: operandRangeText

    @Test
    func operandRangeText() {
        let problem = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(problem.operandRangeText == "3-7")
    }

    @Test
    func operandRangeText_reversed() {
        let problem = MathProblem(operand1: 9, operand2: 2, operation: .subtract)
        #expect(problem.operandRangeText == "2-9")
    }

    // MARK: - logic-812: requiresCarrying

    @Test
    func requiresCarrying_yes() {
        let problem = MathProblem(operand1: 7, operand2: 8, operation: .add)
        #expect(problem.requiresCarrying == true)
    }

    @Test
    func requiresCarrying_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.requiresCarrying == false)
    }

    @Test
    func requiresCarrying_notAddition() {
        let problem = MathProblem(operand1: 7, operand2: 8, operation: .subtract)
        #expect(problem.requiresCarrying == false)
    }

    // MARK: - logic-813: responseTime

    @Test
    func responseTime_fast() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 1.0)
        #expect(answered.responseTime == "fast")
    }

    @Test
    func responseTime_slow() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 8.0)
        #expect(answered.responseTime == "slow")
    }

    @Test
    func responseTime_noTime() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.responseTime == "unknown")
    }
}
