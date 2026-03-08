import Testing
@testable import MathKids

@Suite("Batch 147 Tests")
struct Batch147Tests {

    // MARK: - logic-814: practiceRecommendation

    @Test
    func practiceRecommendation_easy() {
        let text = DifficultyLevel.easy.practiceRecommendation
        #expect(!text.isEmpty)
    }

    @Test
    func practiceRecommendation_hard() {
        let text = DifficultyLevel.hard.practiceRecommendation
        #expect(!text.isEmpty)
    }

    // MARK: - logic-815: iconName

    @Test
    func iconName_easy() {
        #expect(DifficultyLevel.easy.iconName == "star")
    }

    @Test
    func iconName_hard() {
        #expect(DifficultyLevel.hard.iconName == "star.fill")
    }

    // MARK: - logic-816: isNegativeResult

    @Test
    func isNegativeResult_yes() {
        let problem = MathProblem(operand1: 3, operand2: 7, operation: .subtract)
        #expect(problem.isNegativeResult == true)
    }

    @Test
    func isNegativeResult_no() {
        let problem = MathProblem(operand1: 7, operand2: 3, operation: .subtract)
        #expect(problem.isNegativeResult == false)
    }

    // MARK: - logic-817: isZeroResult

    @Test
    func isZeroResult_yes() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .subtract)
        #expect(problem.isZeroResult == true)
    }

    @Test
    func isZeroResult_no() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(problem.isZeroResult == false)
    }

    // MARK: - logic-818: accuracyImpact

    @Test
    func accuracyImpact_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.accuracyImpact == "boost")
    }

    @Test
    func accuracyImpact_wrong() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.accuracyImpact == "drop")
    }
}
