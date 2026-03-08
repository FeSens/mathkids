import Testing
@testable import MathKids

@Suite("Batch 153 Tests")
struct Batch153Tests {

    // MARK: - logic-844: wasNilTime

    @Test
    func wasNilTime_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.wasNilTime == true)
    }

    @Test
    func wasNilTime_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 5.0)
        #expect(answered.wasNilTime == false)
    }

    // MARK: - logic-845: sessionMoodEmoji

    @Test
    func sessionMoodEmoji_happy() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<9 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(!session.sessionMoodEmoji.isEmpty)
    }

    @Test
    func sessionMoodEmoji_different() {
        var good = GameSession(difficulty: .easy)
        for _ in 0..<9 { good.recordAnswer(correct: true) }
        good.recordAnswer(correct: false)

        var bad = GameSession(difficulty: .easy)
        for _ in 0..<2 { bad.recordAnswer(correct: true) }
        for _ in 0..<8 { bad.recordAnswer(correct: false) }

        #expect(good.sessionMoodEmoji != bad.sessionMoodEmoji)
    }

    // MARK: - logic-846: isSubtractionProblem

    @Test
    func isSubtractionProblem_yes() {
        let problem = MathProblem(operand1: 8, operand2: 3, operation: .subtract)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(answered.isSubtractionProblem == true)
    }

    @Test
    func isSubtractionProblem_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.isSubtractionProblem == false)
    }

    // MARK: - logic-847: totalPointsDisplay

    @Test
    func totalPointsDisplay_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalPointsDisplay.contains("0"))
    }

    @Test
    func totalPointsDisplay_withScore() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(!session.totalPointsDisplay.isEmpty)
    }

    // MARK: - logic-848: isMultiDigitProblem

    @Test
    func isMultiDigitProblem_yes() {
        let problem = MathProblem(operand1: 12, operand2: 3, operation: .add)
        #expect(problem.isMultiDigitProblem == true)
    }

    @Test
    func isMultiDigitProblem_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isMultiDigitProblem == false)
    }
}
