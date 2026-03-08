import Testing
@testable import MathKids

@Suite("Batch 114 Tests")
struct Batch114Tests {

    // MARK: - logic-649: GameSession+Display.difficultyBadge

    @Test
    func difficultyBadge() {
        let session = GameSession(difficulty: .easy)
        #expect(session.difficultyBadge == "🌱 Easy")
    }

    // MARK: - logic-650: GameSession+Display.streakBadge

    @Test
    func streakBadge_onStreak() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.streakBadge == "🔥")
    }

    @Test
    func streakBadge_noStreak() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakBadge == "")
    }

    // MARK: - logic-651: GameSession+Display.timeProgressText

    @Test
    func timeProgressText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() }
        #expect(session.timeProgressText == "20/60s")
    }

    // MARK: - logic-652: GameSession+Display.accuracyBadge

    @Test
    func accuracyBadge_perfect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.accuracyBadge == "A+")
    }

    @Test
    func accuracyBadge_low() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        for _ in 0..<7 { session.recordAnswer(correct: false) }
        #expect(session.accuracyBadge == "F")
    }

    // MARK: - logic-653: GameSession+Display.isGoodPerformance

    @Test
    func isGoodPerformance_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true, bonusPoints: 10) }
        #expect(session.isGoodPerformance == true)
    }

    @Test
    func isGoodPerformance_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.isGoodPerformance == false)
    }
}
