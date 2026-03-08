import Testing
@testable import MathKids

@Suite("GameSession Extended Tests")
struct GameSessionExtendedTests {

    // MARK: - Accuracy By Half (logic-256)

    @Test("First half accuracy from first half of answers")
    func firstHalfAccuracy() {
        var session = GameSession(difficulty: .easy)
        // First half: 3 correct, 1 wrong = 75%
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        // Second half: all wrong
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.firstHalfAccuracy == 75.0)
    }

    @Test("Second half accuracy from second half of answers")
    func secondHalfAccuracy() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.secondHalfAccuracy == 100.0)
    }

    @Test("Returns 0 for empty session")
    func halfAccuracyEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.firstHalfAccuracy == 0)
        #expect(session.secondHalfAccuracy == 0)
    }

    // MARK: - Efficiency Score (logic-259)

    @Test("Efficiency returns 0 with no answers")
    func efficiencyNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.efficiencyScore == 0)
    }

    @Test("Efficiency is between 0 and 100")
    func efficiencyInRange() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(session.efficiencyScore >= 0)
        #expect(session.efficiencyScore <= 100)
    }

    @Test("Higher accuracy produces higher efficiency")
    func efficiencyHigherWithAccuracy() {
        var session1 = GameSession(difficulty: .easy)
        for _ in 0..<10 { session1.tick() }
        for _ in 0..<5 { session1.recordAnswer(correct: true) }
        for _ in 0..<5 { session1.recordAnswer(correct: false) }

        var session2 = GameSession(difficulty: .easy)
        for _ in 0..<10 { session2.tick() }
        for _ in 0..<9 { session2.recordAnswer(correct: true) }
        session2.recordAnswer(correct: false)

        #expect(session2.efficiencyScore > session1.efficiencyScore)
    }

    // MARK: - Answer Speed Classification (logic-265)

    @Test("Fast when under 3 seconds per answer")
    func answerSpeedFast() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.tick() } // 5 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 1s per answer
        #expect(session.answerSpeedClass == .fast)
    }

    @Test("Normal between 3-6 seconds per answer")
    func answerSpeedNormal() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() } // 20 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 4s per answer
        #expect(session.answerSpeedClass == .normal)
    }

    @Test("Slow over 6 seconds per answer")
    func answerSpeedSlow() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<35 { session.tick() } // 35 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 7s per answer
        #expect(session.answerSpeedClass == .slow)
    }

    @Test("Returns nil when no time played")
    func answerSpeedNil() {
        let session = GameSession(difficulty: .easy)
        #expect(session.answerSpeedClass == nil)
    }

    // MARK: - Wrong Answer Penalty (logic-270)

    @Test("No penalty with all correct")
    func noPenaltyAllCorrect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.penaltyPoints == 0)
    }

    @Test("Penalty equals wrong count times penalty amount")
    func penaltyCalculation() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.penaltyPoints == 3 * session.difficulty.penaltyPerWrong)
    }
}
