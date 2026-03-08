import Testing
@testable import MathKids

@Suite("GameSession Extended Tests")
struct GameSessionExtendedTests {

    // MARK: - Accuracy By Half (logic-256)

    @Test("First half accuracy from first half of answers")
    func firstHalfAccuracy() {
        var session = GameSession(difficulty: .easy)
        // First half: 3 correct, 1 wrong = 75%
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        // Second half: all wrong
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.firstHalfAccuracy == 75.0)
    }

    @Test("Second half accuracy from second half of answers")
    func secondHalfAccuracy() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.secondHalfAccuracy == 100.0)
    }

    @Test("Returns 0 for empty session")
    func halfAccuracyEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.firstHalfAccuracy == 0)
        #expect(session.secondHalfAccuracy == 0)
    }

    // MARK: - Efficiency Score (logic-259)

    @Test("Efficiency returns 0 with no answers")
    func efficiencyNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.efficiencyScore == 0)
    }

    @Test("Efficiency is between 0 and 100")
    func efficiencyInRange() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(session.efficiencyScore >= 0)
        #expect(session.efficiencyScore <= 100)
    }

    @Test("Higher accuracy produces higher efficiency")
    func efficiencyHigherWithAccuracy() {
        var session1 = GameSession(difficulty: .easy)
        for _ in 0..<10 { session1.tick() }
        for _ in 0..<5 { session1.recordAnswer(correct: true) }
        for _ in 0..<5 { session1.recordAnswer(correct: false) }

        var session2 = GameSession(difficulty: .easy)
        for _ in 0..<10 { session2.tick() }
        for _ in 0..<9 { session2.recordAnswer(correct: true) }
        session2.recordAnswer(correct: false)

        #expect(session2.efficiencyScore > session1.efficiencyScore)
    }

    // MARK: - Answer Speed Classification (logic-265)

    @Test("Fast when under 3 seconds per answer")
    func answerSpeedFast() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.tick() } // 5 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 1s per answer
        #expect(session.answerSpeedClass == .fast)
    }

    @Test("Normal between 3-6 seconds per answer")
    func answerSpeedNormal() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() } // 20 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 4s per answer
        #expect(session.answerSpeedClass == .normal)
    }

    @Test("Slow over 6 seconds per answer")
    func answerSpeedSlow() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<35 { session.tick() } // 35 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 7s per answer
        #expect(session.answerSpeedClass == .slow)
    }

    @Test("Returns nil when no time played")
    func answerSpeedNil() {
        let session = GameSession(difficulty: .easy)
        #expect(session.answerSpeedClass == nil)
    }

    // MARK: - Wrong Answer Penalty (logic-270)

    @Test("No penalty with all correct")
    func noPenaltyAllCorrect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.penaltyPoints == 0)
    }

    @Test("Penalty equals wrong count times penalty amount")
    func penaltyCalculation() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.penaltyPoints == 3 * session.difficulty.penaltyPerWrong)
    }

    // MARK: - Comeback Detection (logic-274)

    @Test("isComeback true when second half much better")
    func comebackTrue() {
        var session = GameSession(difficulty: .easy)
        // First half: 1/4 correct = 25%
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        // Second half: 4/4 correct = 100%
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.isComeback == true)
    }

    @Test("isComeback false when accuracies similar")
    func comebackFalse() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.isComeback == false)
    }

    @Test("isComeback false with too few answers")
    func comebackFewAnswers() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.isComeback == false)
    }

    // MARK: - Final Score With Time Bonus (logic-280)

    @Test("Final score with bonus equals score plus time bonus")
    func finalScoreWithBonus() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() } // 50s remaining
        session.recordAnswer(correct: true)
        #expect(session.finalScoreWithTimeBonus == session.score + session.timeBonus)
    }

    @Test("Final score with bonus is higher than base score")
    func finalScoreHigherThanBase() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        session.recordAnswer(correct: true)
        #expect(session.finalScoreWithTimeBonus > session.score)
    }

    // MARK: - Improvement Rate (logic-284)

    @Test("Positive improvement rate when improving")
    func improvementRatePositive() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.improvementRate > 0)
    }

    @Test("Negative improvement rate when declining")
    func improvementRateNegative() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.improvementRate < 0)
    }

    @Test("Zero improvement rate with no answers")
    func improvementRateZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.improvementRate == 0)
    }

    // MARK: - Answer Distribution (logic-290)

    @Test("All correct returns 100% correct")
    func allCorrectDistribution() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.correctPercentage == 100)
        #expect(session.wrongPercentage == 0)
    }

    @Test("Half and half returns 50/50")
    func halfDistribution() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        #expect(session.correctPercentage == 50)
        #expect(session.wrongPercentage == 50)
    }

    @Test("No answers returns 0/0")
    func noAnswersDistribution() {
        let session = GameSession(difficulty: .easy)
        #expect(session.correctPercentage == 0)
        #expect(session.wrongPercentage == 0)
    }

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
}
