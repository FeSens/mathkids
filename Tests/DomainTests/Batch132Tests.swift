import Testing
@testable import MathKids

@Suite("Batch 132 Tests")
struct Batch132Tests {

    // MARK: - logic-739: streakBonusLabel

    @Test
    func streakBonusLabel_withStreak() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.streakBonusLabel.contains("streak bonus"))
    }

    @Test
    func streakBonusLabel_noStreak() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakBonusLabel == "No streak bonus")
    }

    // MARK: - logic-740: isEndGameRush

    @Test
    func isEndGameRush_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<55 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isEndGameRush == true)
    }

    @Test
    func isEndGameRush_no() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isEndGameRush == false)
    }

    // MARK: - logic-741: remainingTimeFormatted

    @Test
    func remainingTimeFormatted_full() {
        let session = GameSession(difficulty: .easy)
        #expect(session.remainingTimeFormatted == "1:00")
    }

    @Test
    func remainingTimeFormatted_partial() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<25 { session.tick() }
        #expect(session.remainingTimeFormatted == "0:35")
    }

    // MARK: - logic-742: correctRatePerMinute

    @Test
    func correctRatePerMinute_withData() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        for _ in 0..<6 { session.recordAnswer(correct: true) }
        #expect(session.correctRatePerMinute == "6/min")
    }

    @Test
    func correctRatePerMinute_noData() {
        let session = GameSession(difficulty: .easy)
        #expect(session.correctRatePerMinute == "0/min")
    }

    // MARK: - logic-743: isPersonalBestPace

    @Test
    func isPersonalBestPace_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<2 { session.tick() }
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        // 10 answers in 2s = very fast
        #expect(session.isPersonalBestPace == true)
    }

    @Test
    func isPersonalBestPace_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<50 { session.tick() }
        session.recordAnswer(correct: true)
        // 1 answer in 50s = very slow
        #expect(session.isPersonalBestPace == false)
    }
}
