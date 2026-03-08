import Testing
@testable import MathKids

@Suite("Batch 116 Tests")
struct Batch116Tests {

    // MARK: - logic-659: GameSession+Display.remainingTimeDisplay

    @Test
    func remainingTimeDisplay() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<15 { session.tick() }
        #expect(session.remainingTimeDisplay == "45s left")
    }

    // MARK: - logic-660: GameSession+Display.isPerfectAccuracy

    @Test
    func isPerfectAccuracy_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isPerfectAccuracy == true)
    }

    @Test
    func isPerfectAccuracy_no() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.isPerfectAccuracy == false)
    }

    @Test
    func isPerfectAccuracy_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isPerfectAccuracy == false)
    }

    // MARK: - logic-661: GameSession+Display.scoreEmoji

    @Test
    func scoreEmoji_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<15 { session.recordAnswer(correct: true, bonusPoints: 10) }
        #expect(session.scoreEmoji == "🏆")
    }

    @Test
    func scoreEmoji_low() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoreEmoji == "📝")
    }

    // MARK: - logic-662: GameSession+Display.bestStreakText

    @Test
    func bestStreakText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(session.bestStreakText == "Best: 5")
    }

    // MARK: - logic-663: GameSession+Display.totalPointsEarned

    @Test
    func totalPointsEarned() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        #expect(session.totalPointsEarned == session.score + session.totalBonusPoints)
    }
}
