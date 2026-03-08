import Testing
@testable import MathKids

@Suite("Batch 152 Tests")
struct Batch152Tests {

    // MARK: - logic-839: isNearPerfect

    @Test
    func isNearPerfect_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<9 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(session.isNearPerfect == true)
    }

    @Test
    func isNearPerfect_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<7 { session.recordAnswer(correct: true) }
        for _ in 0..<3 { session.recordAnswer(correct: false) }
        #expect(session.isNearPerfect == false)
    }

    // MARK: - logic-840: questionNumberText

    @Test
    func questionNumberText_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.questionNumberText.contains("1"))
    }

    @Test
    func questionNumberText_afterAnswers() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.questionNumberText.contains("4"))
    }

    // MARK: - logic-841: wasOverTime

    @Test
    func wasOverTime_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 12.0)
        #expect(answered.wasOverTime == true)
    }

    @Test
    func wasOverTime_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 5.0)
        #expect(answered.wasOverTime == false)
    }

    // MARK: - logic-842: operandGap

    @Test
    func operandGap_different() {
        let problem = MathProblem(operand1: 8, operand2: 3, operation: .add)
        #expect(problem.operandGap == 5)
    }

    @Test
    func operandGap_same() {
        let problem = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(problem.operandGap == 0)
    }

    // MARK: - logic-843: isPassing

    @Test
    func isPassing_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<7 { session.recordAnswer(correct: true) }
        for _ in 0..<3 { session.recordAnswer(correct: false) }
        #expect(session.isPassing == true)
    }

    @Test
    func isPassing_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        for _ in 0..<7 { session.recordAnswer(correct: false) }
        #expect(session.isPassing == false)
    }
}
