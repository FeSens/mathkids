import Testing
@testable import MathKids

@Suite("Batch 127 Tests")
struct Batch127Tests {

    // MARK: - logic-714: scorePercentOfMax

    @Test
    func scorePercentOfMax_zero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scorePercentOfMax == 0)
    }

    @Test
    func scorePercentOfMax_some() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.scorePercentOfMax > 0)
    }

    // MARK: - logic-715: hasReachedHalfTime

    @Test
    func hasReachedHalfTime_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        #expect(session.hasReachedHalfTime == false)
    }

    @Test
    func hasReachedHalfTime_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<31 { session.tick() }
        #expect(session.hasReachedHalfTime == true)
    }

    // MARK: - logic-716: efficiencyRating

    @Test
    func efficiencyRating_excellent() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<2 { session.tick() }
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.efficiencyRating == "excellent")
    }

    @Test
    func efficiencyRating_poor() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<50 { session.tick() }
        session.recordAnswer(correct: false)
        #expect(session.efficiencyRating == "poor")
    }

    // MARK: - logic-717: currentMomentumText

    @Test
    func currentMomentumText_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.currentMomentumText == "On fire!")
    }

    @Test
    func currentMomentumText_none() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        #expect(session.currentMomentumText == "Building momentum")
    }

    // MARK: - logic-718: sessionCompletionEstimate

    @Test
    func sessionCompletionEstimate_noData() {
        let session = GameSession(difficulty: .easy)
        #expect(session.sessionCompletionEstimate == 0)
    }

    @Test
    func sessionCompletionEstimate_withData() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        // 5 answers in 10s = 0.5/s, 50s remaining → ~25 more
        #expect(session.sessionCompletionEstimate == 25)
    }
}
