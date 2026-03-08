import Testing
@testable import MathKids

@Suite("Batch 122 Tests")
struct Batch122Tests {

    // MARK: - logic-689: accuracyColor

    @Test
    func accuracyColor_green() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.accuracyColor == "green")
    }

    @Test
    func accuracyColor_red() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.accuracyColor == "red")
    }

    // MARK: - logic-690: bonusDisplay

    @Test
    func bonusDisplay() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 15)
        #expect(session.bonusDisplay == "+15")
    }

    // MARK: - logic-691: scoreProgress

    @Test
    func scoreProgress_zero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoreProgress == 0.0)
    }

    // MARK: - logic-692: isHighStreak

    @Test
    func isHighStreak_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isHighStreak == true)
    }

    @Test
    func isHighStreak_no() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.isHighStreak == false)
    }

    // MARK: - logic-693: answeredPercentage

    @Test
    func answeredPercentage() {
        var session = GameSession(difficulty: .easy)
        // easy: estimatedProblemsPerGame = 60/6 = 10
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.answeredPercentage == 50)
    }
}
