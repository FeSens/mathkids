import Testing
@testable import MathKids

@Suite("Batch 121 Tests")
struct Batch121Tests {

    // MARK: - logic-684: timeLimitText

    @Test
    func timeLimitText() {
        let session = GameSession(difficulty: .easy)
        #expect(session.timeLimitText == "60s total")
    }

    // MARK: - logic-685: isSlowPace

    @Test
    func isSlowPace_yes() {
        var session = GameSession(difficulty: .easy)
        // Easy recommended is 6s per problem. Tick 20s, answer 1 = 20s avg (slow)
        for _ in 0..<20 { session.tick() }
        session.recordAnswer(correct: true)
        #expect(session.isSlowPace == true)
    }

    @Test
    func isSlowPace_no() {
        var session = GameSession(difficulty: .easy)
        // 2s per answer is fast
        for _ in 0..<2 { session.tick() }
        session.recordAnswer(correct: true)
        #expect(session.isSlowPace == false)
    }

    // MARK: - logic-686: streakStatusDescription

    @Test
    func streakStatusDescription_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.streakStatusDescription.contains("Amazing"))
    }

    @Test
    func streakStatusDescription_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakStatusDescription == "No streak")
    }

    // MARK: - logic-687: totalAnsweredDisplay

    @Test
    func totalAnsweredDisplay() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.totalAnsweredDisplay == "5 answers")
    }

    // MARK: - logic-688: isEndOfGame

    @Test
    func isEndOfGame_no() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isEndOfGame == false)
    }

    @Test
    func isEndOfGame_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.isEndOfGame == true)
    }
}
