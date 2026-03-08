import Testing
@testable import MathKids

@Suite("GameSession Tests")
struct GameSessionTests {
    @Test("Starts with correct initial values")
    func initialValues() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalAnswered == 0)
        #expect(session.totalCorrect == 0)
        #expect(session.currentStreak == 0)
        #expect(session.bestStreak == 0)
        #expect(session.score == 0)
        #expect(session.timeRemaining == 60)
        #expect(!session.isFinished)
    }

    @Test("Records correct answers and increments streak")
    func recordCorrect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.totalAnswered == 1)
        #expect(session.totalCorrect == 1)
        #expect(session.currentStreak == 1)
        #expect(session.score == 10)
    }

    @Test("Records wrong answers and resets streak")
    func recordWrong() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.totalAnswered == 3)
        #expect(session.totalCorrect == 2)
        #expect(session.currentStreak == 0)
        #expect(session.bestStreak == 2)
    }

    @Test("Calculates accuracy")
    func accuracy() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.accuracy == 50.0)
    }

    @Test("Accuracy is zero when no answers")
    func accuracyZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.accuracy == 0)
    }

    @Test("Tick decrements time")
    func tick() {
        var session = GameSession(difficulty: .easy)
        session.tick()
        #expect(session.timeRemaining == 59)
    }

    @Test("Game finishes when time runs out")
    func finishOnTimeout() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 {
            session.tick()
        }
        #expect(session.isFinished)
        #expect(session.timeRemaining == 0)
    }

    @Test("Best streak tracks highest streak")
    func bestStreak() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        #expect(session.bestStreak == 3)
        #expect(session.currentStreak == 1)
    }

    @Test("Bonus points are added to score")
    func bonusPoints() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        #expect(session.score == 15) // 10 base + 5 bonus
    }

    // MARK: - Total Time Played (ui-151)

    @Test("Total time played starts at 0")
    func totalTimePlayedStartsAt0() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalTimePlayed == 0)
    }

    @Test("Total time played increases as timer ticks")
    func totalTimePlayedIncreasesWithTicks() {
        var session = GameSession(difficulty: .easy)
        session.tick()
        session.tick()
        session.tick()
        #expect(session.totalTimePlayed == 3)
    }

    // MARK: - Problems Per Minute (logic-206)

    @Test("Problems per minute returns 0 when no time elapsed")
    func problemsPerMinuteZeroTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.problemsPerMinute == 0)
    }

    @Test("Problems per minute calculates correctly")
    func problemsPerMinuteCalculation() {
        var session = GameSession(difficulty: .easy)
        // Simulate 30 seconds elapsed
        for _ in 0..<30 { session.tick() }
        // Answer 10 problems
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        // 10 problems in 0.5 minutes = 20 per minute
        #expect(session.problemsPerMinute == 20.0)
    }

    // MARK: - Best Streak Operation (logic-212)

    @Test("Best streak operation nil when no answers")
    func bestStreakOperationNil() {
        let session = GameSession(difficulty: .easy)
        #expect(session.bestStreakOperation == nil)
    }

    @Test("Best streak operation tracks correctly")
    func bestStreakOperationTracks() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, operation: .add)
        session.recordAnswer(correct: true, operation: .add)
        session.recordAnswer(correct: true, operation: .add)
        session.recordAnswer(correct: false, operation: .add)
        session.recordAnswer(correct: true, operation: .multiply)
        session.recordAnswer(correct: true, operation: .multiply)
        #expect(session.bestStreakOperation == .add)
    }

    // MARK: - Accuracy Per Operation (logic-215)

    @Test("Accuracy for operation returns 0 when none answered")
    func accuracyForOperationZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.accuracyForOperation(.add) == 0)
    }

    @Test("Accuracy for operation calculates correctly")
    func accuracyForOperationCalculation() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, operation: .add)
        session.recordAnswer(correct: true, operation: .add)
        session.recordAnswer(correct: false, operation: .add)
        session.recordAnswer(correct: true, operation: .subtract)
        #expect(session.accuracyForOperation(.add) > 66)
        #expect(session.accuracyForOperation(.add) < 67)
        #expect(session.accuracyForOperation(.subtract) == 100)
    }

    // MARK: - Streak Milestone Check (logic-225)

    @Test("Streak milestone at 5")
    func streakMilestoneAt5() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.streakMilestoneReached == 5)
    }

    @Test("No milestone at 6")
    func noMilestoneAt6() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<6 { session.recordAnswer(correct: true) }
        #expect(session.streakMilestoneReached == nil)
    }

    @Test("Milestone at 10")
    func milestoneAt10() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.streakMilestoneReached == 10)
    }

    // MARK: - Total Bonus Points (logic-230)

    @Test("Total bonus points starts at 0")
    func totalBonusStartsAt0() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalBonusPoints == 0)
    }

    @Test("Total bonus points accumulates")
    func totalBonusAccumulates() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        session.recordAnswer(correct: true, bonusPoints: 3)
        #expect(session.totalBonusPoints == 8)
    }

    // MARK: - Base Score (logic-235)

    @Test("Base score without bonuses")
    func baseScoreWithoutBonuses() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        session.recordAnswer(correct: true, bonusPoints: 3)
        session.recordAnswer(correct: true, bonusPoints: 0)
        // 3 correct * 10 pts = 30 base, total score = 30 + 8 = 38
        #expect(session.baseScore == 30)
        #expect(session.score == 38)
    }

    // MARK: - Total Wrong (logic-240)

    @Test("Total wrong count")
    func totalWrongCount() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.totalWrong == 2)
    }

    // MARK: - Score Per Correct (logic-245)

    @Test("Score per correct returns 0 when none correct")
    func scorePerCorrectZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scorePerCorrect == 0)
    }

    @Test("Score per correct calculates average")
    func scorePerCorrectAverage() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5) // 15
        session.recordAnswer(correct: true, bonusPoints: 3) // 13
        session.recordAnswer(correct: true, bonusPoints: 0) // 10
        // total score = 38, 3 correct = 12.67 avg
        #expect(session.scorePerCorrect > 12)
        #expect(session.scorePerCorrect < 13)
    }

    // MARK: - Time Bonus (logic-249)

    @Test("Time bonus is 0 when no time remains")
    func timeBonusNoTimeRemaining() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.timeBonus == 0)
    }

    @Test("Time bonus increases with more remaining time")
    func timeBonusIncreasesWithTime() {
        var session1 = GameSession(difficulty: .easy)
        for _ in 0..<50 { session1.tick() } // 10s left
        var session2 = GameSession(difficulty: .easy)
        for _ in 0..<30 { session2.tick() } // 30s left
        #expect(session2.timeBonus > session1.timeBonus)
    }

    @Test("Time bonus scales with difficulty")
    func timeBonusScalesWithDifficulty() {
        var easySession = GameSession(difficulty: .easy)
        for _ in 0..<30 { easySession.tick() } // 30s left
        var hardSession = GameSession(difficulty: .hard)
        for _ in 0..<15 { hardSession.tick() } // 15s left (half of 30)
        #expect(hardSession.timeBonus > 0)
        #expect(easySession.timeBonus > 0)
    }

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
}
