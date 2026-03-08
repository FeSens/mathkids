import Testing
@testable import MathKids

@Suite("Batch 118 Tests")
struct Batch118Tests {

    // MARK: - logic-669: GameSession+Display.motivationalMessage

    @Test
    func motivationalMessage_perfect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.motivationalMessage.contains("Amazing"))
    }

    @Test
    func motivationalMessage_low() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.motivationalMessage.contains("Keep trying"))
    }

    // MARK: - logic-670: GameSession+Display.correctCountDisplay

    @Test
    func correctCountDisplay() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.correctCountDisplay.contains("2"))
    }

    // MARK: - logic-671: GameSession+Display.wrongCountDisplay

    @Test
    func wrongCountDisplay() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        #expect(session.wrongCountDisplay.contains("1"))
    }

    // MARK: - logic-672: GameSession+Display.hasStreak

    @Test
    func hasStreak_no() {
        let session = GameSession(difficulty: .easy)
        #expect(session.hasStreak == false)
    }

    @Test
    func hasStreak_yes() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.hasStreak == true)
    }

    // MARK: - logic-673: GameSession+Display.elapsedSeconds

    @Test
    func elapsedSeconds() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<25 { session.tick() }
        #expect(session.elapsedSeconds == 25)
    }
}
