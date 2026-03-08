import Testing
@testable import MathKids

@Suite("Batch 167 Tests")
struct Batch167Tests {

    // MARK: - logic-914: answeredInTime

    @Test
    func answeredInTime_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 2.0)
        #expect(answered.answeredInTime == true)
    }

    @Test
    func answeredInTime_noTime() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answeredInTime == false)
    }

    // MARK: - logic-915: difficultyMaxScore

    @Test
    func difficultyMaxScore_easy() {
        #expect(!DifficultyLevel.easy.difficultyMaxScore.isEmpty)
    }

    @Test
    func difficultyMaxScore_hard() {
        #expect(!DifficultyLevel.hard.difficultyMaxScore.isEmpty)
    }

    // MARK: - logic-916: problemOperationWeight

    @Test
    func problemOperationWeight_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.problemOperationWeight == 1)
    }

    @Test
    func problemOperationWeight_multiply() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let answered = AnsweredProblem(problem: problem, userAnswer: 12)
        #expect(answered.problemOperationWeight == 3)
    }

    // MARK: - logic-917: difficultyRecommendedPractice

    @Test
    func difficultyRecommendedPractice_easy() {
        #expect(!DifficultyLevel.easy.difficultyRecommendedPractice.isEmpty)
    }

    @Test
    func difficultyRecommendedPractice_hard() {
        #expect(!DifficultyLevel.hard.difficultyRecommendedPractice.isEmpty)
    }

    // MARK: - logic-918: isCorrectWithTime

    @Test
    func isCorrectWithTime_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 3.0)
        #expect(answered.isCorrectWithTime == true)
    }

    @Test
    func isCorrectWithTime_noTime() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.isCorrectWithTime == false)
    }

    @Test
    func isCorrectWithTime_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 3.0)
        #expect(answered.isCorrectWithTime == false)
    }
}
