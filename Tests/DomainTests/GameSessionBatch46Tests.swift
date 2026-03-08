import Testing
@testable import MathKids

@Suite("GameSession Batch 46 Tests")
struct GameSessionBatch46Tests {

    // MARK: - Streak To Points (logic-294)

    @Test("No streak returns 0 bonus")
    func streakBonusZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakBonusPoints == 0)
    }

    @Test("Streak of 5 returns correct bonus")
    func streakBonusForFive() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true, bonusPoints: 5) }
        #expect(session.streakBonusPoints == session.totalBonusPoints)
    }

    // MARK: - Answer Consistency (logic-299)

    @Test("Consistency is 100 for all correct")
    func consistencyAllCorrect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.answerConsistency == 100)
    }

    @Test("Consistency is 0 for no answers")
    func consistencyNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.answerConsistency == 0)
    }

    @Test("Mixed answers give intermediate consistency")
    func consistencyMixed() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        let c = session.answerConsistency
        #expect(c > 0 && c < 100)
    }

    // MARK: - Time Usage Percentage (logic-310)

    @Test("Time usage 0 with no time played")
    func timeUsageZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.timeUsagePercentage == 0)
    }

    @Test("Time usage correct after ticks")
    func timeUsageAfterTicks() {
        var session = GameSession(difficulty: .easy) // 60s total
        for _ in 0..<30 { session.tick() }
        #expect(session.timeUsagePercentage == 50)
    }

    @Test("Time usage 100 when time runs out")
    func timeUsageFull() {
        var session = GameSession(difficulty: .easy) // 60s
        for _ in 0..<60 { session.tick() }
        #expect(session.timeUsagePercentage == 100)
    }

    // MARK: - Score Breakdown Text (logic-314)

    @Test("Score breakdown includes base score")
    func scoreBreakdownIncludesBase() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        #expect(session.scoreBreakdownText.contains("Base"))
    }

    @Test("Score breakdown includes bonus if any")
    func scoreBreakdownIncludesBonus() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        #expect(session.scoreBreakdownText.contains("Bonus"))
    }

    @Test("Score breakdown empty for zero score")
    func scoreBreakdownEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoreBreakdownText.isEmpty)
    }
}
