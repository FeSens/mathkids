import Testing
@testable import MathKids

@Suite("Batch 133 Tests")
struct Batch133Tests {

    // MARK: - logic-744: operationBreakdownText

    @Test
    func operationBreakdownText_withOps() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, operation: .add)
        session.recordAnswer(correct: true, operation: .add)
        session.recordAnswer(correct: false, operation: .subtract)
        #expect(session.operationBreakdownText.contains("3 problems"))
    }

    @Test
    func operationBreakdownText_noOps() {
        let session = GameSession(difficulty: .easy)
        #expect(session.operationBreakdownText == "No problems yet")
    }

    // MARK: - logic-745: isPeakPerformance

    @Test
    func isPeakPerformance_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<2 { session.tick() }
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.isPeakPerformance == true)
    }

    @Test
    func isPeakPerformance_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        #expect(session.isPeakPerformance == false)
    }

    // MARK: - logic-746: gamePaceDescription

    @Test
    func gamePaceDescription_fast() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<2 { session.tick() }
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.gamePaceDescription == "fast")
    }

    @Test
    func gamePaceDescription_slow() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<50 { session.tick() }
        session.recordAnswer(correct: true)
        #expect(session.gamePaceDescription == "slow")
    }

    // MARK: - logic-747: totalTimePlayedText

    @Test
    func totalTimePlayedText_secondsOnly() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.totalTimePlayedText == "30s")
    }

    @Test
    func totalTimePlayedText_zero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalTimePlayedText == "0s")
    }

    // MARK: - logic-748: challengeRating

    @Test
    func challengeRating_veryChallenging() {
        var session = GameSession(difficulty: .hard)
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        #expect(session.challengeRating == "very challenging")
    }

    @Test
    func challengeRating_easy() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.challengeRating == "comfortable")
    }
}
