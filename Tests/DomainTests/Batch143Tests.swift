import Testing
@testable import MathKids

@Suite("Batch 143 Tests")
struct Batch143Tests {

    private func makeAnswered(correct: Bool) -> AnsweredProblem {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answer = correct ? 7 : 5
        return AnsweredProblem(problem: problem, userAnswer: answer, timeTaken: 2.0)
    }

    // MARK: - logic-794: pointsEarned

    @Test
    func pointsEarned_correct() {
        let answered = makeAnswered(correct: true)
        #expect(answered.pointsEarned > 0)
    }

    @Test
    func pointsEarned_wrong() {
        let answered = makeAnswered(correct: false)
        #expect(answered.pointsEarned <= 0)
    }

    // MARK: - logic-795: userAnswerText

    @Test
    func userAnswerText() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 1.0)
        #expect(answered.userAnswerText == "5")
    }

    // MARK: - logic-796: correctAnswerDisplay

    @Test
    func correctAnswerDisplay() {
        let answered = makeAnswered(correct: true)
        #expect(answered.correctAnswerDisplay == "7")
    }

    // MARK: - logic-797: mistakeDescription

    @Test
    func mistakeDescription_wrong() {
        let answered = makeAnswered(correct: false)
        #expect(!answered.mistakeDescription.isEmpty)
        #expect(answered.mistakeDescription.contains("7"))
    }

    @Test
    func mistakeDescription_correct() {
        let answered = makeAnswered(correct: true)
        #expect(answered.mistakeDescription.isEmpty)
    }

    // MARK: - logic-798: difficultyLabel

    @Test
    func difficultyLabel() {
        let answered = makeAnswered(correct: true)
        #expect(!answered.difficultyLabel.isEmpty)
    }
}
