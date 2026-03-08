import Testing
@testable import MathKids

@Suite("Batch 123 Tests")
struct Batch123Tests {

    // MARK: - logic-694: xpEarnedDisplay

    @Test
    func xpEarnedDisplay() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.xpEarnedDisplay.contains("XP"))
    }

    // MARK: - logic-695: finalResultEmoji

    @Test
    func finalResultEmoji_great() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.finalResultEmoji == "⭐")
    }

    @Test
    func finalResultEmoji_poor() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.finalResultEmoji == "🤔")
    }

    // MARK: - logic-696: sessionDurationText

    @Test
    func sessionDurationText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.sessionDurationText == "30s")
    }

    // MARK: - logic-697: wrongAnswerPercent

    @Test
    func wrongAnswerPercent() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.wrongAnswerPercent == 75)
    }

    @Test
    func wrongAnswerPercent_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.wrongAnswerPercent == 0)
    }

    // MARK: - logic-698: hasTimedOut

    @Test
    func hasTimedOut_no() {
        let session = GameSession(difficulty: .easy)
        #expect(session.hasTimedOut == false)
    }

    @Test
    func hasTimedOut_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.hasTimedOut == true)
    }
}
