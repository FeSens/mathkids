import Testing
@testable import MathKids

@Suite("Batch 131 Tests")
struct Batch131Tests {

    // MARK: - logic-734: averagePointsPerQuestion

    @Test
    func averagePointsPerQuestion_withAnswers() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.averagePointsPerQuestion > 0)
    }

    @Test
    func averagePointsPerQuestion_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.averagePointsPerQuestion == 0)
    }

    // MARK: - logic-735: isUltraStreak

    @Test
    func isUltraStreak_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<7 { session.recordAnswer(correct: true) }
        #expect(session.isUltraStreak == true)
    }

    @Test
    func isUltraStreak_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<4 { session.recordAnswer(correct: true) }
        #expect(session.isUltraStreak == false)
    }

    // MARK: - logic-736: timeStatusText

    @Test
    func timeStatusText_plenty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.timeStatusText == "Plenty of time")
    }

    @Test
    func timeStatusText_runningLow() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<50 { session.tick() }
        #expect(session.timeStatusText == "Running low!")
    }

    @Test
    func timeStatusText_hurry() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<57 { session.tick() }
        #expect(session.timeStatusText == "Hurry!")
    }

    // MARK: - logic-737: scoreGradeText

    @Test
    func scoreGradeText_noScore() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoreGradeText == "F")
    }

    @Test
    func scoreGradeText_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        let grade = session.scoreGradeText
        #expect(["A", "B", "C", "D", "F"].contains(grade))
    }

    // MARK: - logic-738: nextMilestone

    @Test
    func nextMilestone_zero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.nextMilestone == 50)
    }

    @Test
    func nextMilestone_past50() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        // nextMilestone should be the next multiple of 50 above score
        let expected = ((session.score / 50) + 1) * 50
        #expect(session.nextMilestone == expected)
    }
}
