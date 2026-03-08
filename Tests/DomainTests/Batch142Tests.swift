import Testing
@testable import MathKids

@Suite("Batch 142 Tests")
struct Batch142Tests {

    private func makeAnswered(correct: Bool, time: Double = 2.0) -> AnsweredProblem {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answer = correct ? 7 : 5
        return AnsweredProblem(problem: problem, userAnswer: answer, timeTaken: time)
    }

    // MARK: - logic-789: wasCorrectText

    @Test
    func wasCorrectText_correct() {
        let answered = makeAnswered(correct: true)
        #expect(answered.wasCorrectText == "Correct")
    }

    @Test
    func wasCorrectText_wrong() {
        let answered = makeAnswered(correct: false)
        #expect(answered.wasCorrectText == "Wrong")
    }

    // MARK: - logic-790: resultEmoji

    @Test
    func resultEmoji_correct() {
        let answered = makeAnswered(correct: true)
        #expect(answered.resultEmoji == "✅")
    }

    @Test
    func resultEmoji_wrong() {
        let answered = makeAnswered(correct: false)
        #expect(answered.resultEmoji == "❌")
    }

    // MARK: - logic-791: timeTakenText

    @Test
    func timeTakenText() {
        let answered = makeAnswered(correct: true, time: 3.2)
        #expect(answered.timeTakenText == "3.2s")
    }

    @Test
    func timeTakenText_noTime() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.timeTakenText == "N/A")
    }

    // MARK: - logic-792: wasQuickAnswer

    @Test
    func wasQuickAnswer_yes() {
        let answered = makeAnswered(correct: true, time: 2.0)
        #expect(answered.wasQuickAnswer == true)
    }

    @Test
    func wasQuickAnswer_no() {
        let answered = makeAnswered(correct: true, time: 5.0)
        #expect(answered.wasQuickAnswer == false)
    }

    // MARK: - logic-793: summaryText

    @Test
    func summaryText_correct() {
        let answered = makeAnswered(correct: true)
        #expect(answered.summaryText.contains("✅"))
    }

    @Test
    func summaryText_wrong() {
        let answered = makeAnswered(correct: false)
        #expect(answered.summaryText.contains("❌"))
    }
}
