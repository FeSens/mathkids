import Testing
@testable import MathKids

@Suite("Batch 128 Tests")
struct Batch128Tests {

    // MARK: - logic-719: needsEncouragement

    @Test
    func needsEncouragement_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        #expect(session.needsEncouragement == true)
    }

    @Test
    func needsEncouragement_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.needsEncouragement == false)
    }

    // MARK: - logic-720: streakProgressText

    @Test
    func streakProgressText_toward3() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.streakProgressText == "2/3 to streak!")
    }

    @Test
    func streakProgressText_atStreak() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.streakProgressText == "5 streak!")
    }

    @Test
    func streakProgressText_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakProgressText == "0/3 to streak!")
    }

    // MARK: - logic-721: roundedAccuracy

    @Test
    func roundedAccuracy_70() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<7 { session.recordAnswer(correct: true) }
        for _ in 0..<3 { session.recordAnswer(correct: false) }
        #expect(session.roundedAccuracy == 70)
    }

    @Test
    func roundedAccuracy_zero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.roundedAccuracy == 0)
    }

    // MARK: - logic-722: scoreDifferenceFromAverage

    @Test
    func scoreDifferenceFromAverage_positive() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.scoreDifferenceFromAverage > 0)
    }

    @Test
    func scoreDifferenceFromAverage_negative() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoreDifferenceFromAverage < 0)
    }

    // MARK: - logic-723: sessionQualityStars

    @Test
    func sessionQualityStars_5() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.sessionQualityStars == "⭐⭐⭐⭐⭐")
    }

    @Test
    func sessionQualityStars_1() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.sessionQualityStars == "⭐")
    }
}
