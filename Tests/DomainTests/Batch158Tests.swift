import Testing
@testable import MathKids

@Suite("Batch 158 Tests")
struct Batch158Tests {

    // MARK: - logic-869: difficultyAbbreviation

    @Test
    func difficultyAbbreviation_short() {
        #expect(DifficultyLevel.easy.difficultyAbbreviation.count <= 3)
    }

    @Test
    func difficultyAbbreviation_unique() {
        #expect(DifficultyLevel.easy.difficultyAbbreviation != DifficultyLevel.hard.difficultyAbbreviation)
    }

    // MARK: - logic-870: answerDigits

    @Test
    func answerDigits_single() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerDigits == 1)
    }

    @Test
    func answerDigits_double() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 42)
        #expect(answered.answerDigits == 2)
    }

    // MARK: - logic-871: isBonusEligible

    @Test
    func isBonusEligible_easy() {
        #expect(DifficultyLevel.easy.isBonusEligible == false)
    }

    @Test
    func isBonusEligible_hard() {
        #expect(DifficultyLevel.hard.isBonusEligible == true)
    }

    // MARK: - logic-872: isSymmetric

    @Test
    func isSymmetric_yes() {
        let problem = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(problem.isSymmetric == true)
    }

    @Test
    func isSymmetric_no() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.isSymmetric == false)
    }

    // MARK: - logic-873: correctAnswerIsEven

    @Test
    func correctAnswerIsEven_yes() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 8)
        #expect(answered.correctAnswerIsEven == true)
    }

    @Test
    func correctAnswerIsEven_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.correctAnswerIsEven == false)
    }
}
