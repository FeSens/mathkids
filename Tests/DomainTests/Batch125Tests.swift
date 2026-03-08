import Testing
@testable import MathKids

@Suite("Batch 125 Tests")
struct Batch125Tests {

    // MARK: - logic-704: correctStreakCount

    @Test
    func correctStreakCount() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.correctStreakCount == "3")
    }

    @Test
    func correctStreakCount_broken() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.correctStreakCount == "0")
    }

    // MARK: - logic-705: isWarmingUp

    @Test
    func isWarmingUp_yes() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.isWarmingUp == true)
    }

    @Test
    func isWarmingUp_no_tooMany() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isWarmingUp == false)
    }

    @Test
    func isWarmingUp_no_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isWarmingUp == false)
    }

    // MARK: - logic-706: sessionStatusEmoji

    @Test
    func sessionStatusEmoji_new() {
        let session = GameSession(difficulty: .easy)
        #expect(session.sessionStatusEmoji == "🆕")
    }

    @Test
    func sessionStatusEmoji_fire() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.sessionStatusEmoji == "🔥")
    }

    @Test
    func sessionStatusEmoji_struggling() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.sessionStatusEmoji == "💪")
    }

    // MARK: - logic-707: totalWrongDisplay

    @Test
    func totalWrongDisplay() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.totalWrongDisplay == "2 wrong")
    }

    @Test
    func totalWrongDisplay_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalWrongDisplay == "0 wrong")
    }

    // MARK: - logic-708: pointsSummaryText

    @Test
    func pointsSummaryText_withBonus() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 10)
        let text = session.pointsSummaryText
        #expect(text.contains("base"))
        #expect(text.contains("bonus"))
    }

    @Test
    func pointsSummaryText_noBonus() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        let text = session.pointsSummaryText
        #expect(text.contains("pts"))
        #expect(!text.contains("bonus"))
    }
}
