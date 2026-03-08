import Testing
@testable import MathKids

@Suite("Batch 115 Tests")
struct Batch115Tests {

    // MARK: - logic-654: GameSession+Display.sessionGrade

    @Test
    func sessionGrade_perfect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.sessionGrade == "⭐ A+")
    }

    @Test
    func sessionGrade_low() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.sessionGrade == "F")
    }

    // MARK: - logic-655: GameSession+Display.questionsPerMinute

    @Test
    func questionsPerMinute_noTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.questionsPerMinute == 0)
    }

    @Test
    func questionsPerMinute_withTime() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.questionsPerMinute == 2)
    }

    // MARK: - logic-656: GameSession+Display.correctStreakEmoji

    @Test
    func correctStreakEmoji_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.correctStreakEmoji == "🔥")
    }

    @Test
    func correctStreakEmoji_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.correctStreakEmoji == "")
    }

    // MARK: - logic-657: GameSession+Display.timeUsedPercentText

    @Test
    func timeUsedPercentText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.timeUsedPercentText == "50%")
    }

    // MARK: - logic-658: GameSession+Display.hasAnsweredAny

    @Test
    func hasAnsweredAny_no() {
        let session = GameSession(difficulty: .easy)
        #expect(session.hasAnsweredAny == false)
    }

    @Test
    func hasAnsweredAny_yes() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.hasAnsweredAny == true)
    }
}
