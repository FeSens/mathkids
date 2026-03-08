import Testing
@testable import MathKids

@Suite("Batch 124 Tests")
struct Batch124Tests {

    // MARK: - logic-699: averageTimePerAnswerText

    @Test
    func averageTimePerAnswerText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() }
        for _ in 0..<4 { session.recordAnswer(correct: true) }
        #expect(session.averageTimePerAnswerText == "5s/answer")
    }

    @Test
    func averageTimePerAnswerText_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.averageTimePerAnswerText == "0s/answer")
    }

    // MARK: - logic-700: isAboveAverageScore

    @Test
    func isAboveAverageScore_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.isAboveAverageScore == true)
    }

    @Test
    func isAboveAverageScore_no() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.isAboveAverageScore == false)
    }

    // MARK: - logic-701: timeRemainingPercent

    @Test
    func timeRemainingPercent_half() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.timeRemainingPercent == 50)
    }

    @Test
    func timeRemainingPercent_full() {
        let session = GameSession(difficulty: .easy)
        #expect(session.timeRemainingPercent == 100)
    }

    // MARK: - logic-702: streakMultiplierText

    @Test
    func streakMultiplierText_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.streakMultiplierText == "x3")
    }

    @Test
    func streakMultiplierText_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakMultiplierText == "x1")
    }

    @Test
    func streakMultiplierText_medium() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.streakMultiplierText == "x2")
    }

    // MARK: - logic-703: performanceRating

    @Test
    func performanceRating_perfect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.performanceRating == 5)
    }

    @Test
    func performanceRating_low() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        #expect(session.performanceRating == 1)
    }
}
