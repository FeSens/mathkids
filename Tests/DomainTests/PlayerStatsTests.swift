import Testing
import Foundation
@testable import MathKids

@Suite("PlayerStats Tests")
struct PlayerStatsTests {
    @Test("Initial values are zero")
    func initialValues() {
        let stats = PlayerStats()
        #expect(stats.totalSolved == 0)
        #expect(stats.totalCorrect == 0)
        #expect(stats.bestStreak == 0)
        #expect(stats.dailyStreak == 0)
        #expect(stats.lastPlayedDate == nil)
    }

    @Test("Accuracy calculation")
    func accuracy() {
        let stats = PlayerStats()
        stats.totalSolved = 10
        stats.totalCorrect = 7
        #expect(stats.accuracy == 70.0)
    }

    @Test("Accuracy is zero when no problems solved")
    func accuracyZero() {
        let stats = PlayerStats()
        #expect(stats.accuracy == 0)
    }

    @Test("First play sets daily streak to 1")
    func firstPlay() {
        let stats = PlayerStats()
        stats.updateStreak()
        #expect(stats.dailyStreak == 1)
        #expect(stats.lastPlayedDate != nil)
    }

    @Test("Consecutive day increments streak")
    func consecutiveDay() {
        let stats = PlayerStats()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
        stats.updateStreak(on: yesterday)
        #expect(stats.dailyStreak == 1)

        stats.updateStreak(on: .now)
        #expect(stats.dailyStreak == 2)
    }

    @Test("Missed day resets streak")
    func missedDay() {
        let stats = PlayerStats()
        let twoDaysAgo = Calendar.current.date(byAdding: .day, value: -2, to: .now)!
        stats.updateStreak(on: twoDaysAgo)
        #expect(stats.dailyStreak == 1)

        stats.updateStreak(on: .now)
        #expect(stats.dailyStreak == 1)
    }

    @Test("Same day does not increment streak")
    func sameDay() {
        let stats = PlayerStats()
        stats.updateStreak()
        stats.updateStreak()
        #expect(stats.dailyStreak == 1)
    }

    @Test("Records game session")
    func recordGame() {
        let stats = PlayerStats()
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)

        stats.recordGame(session: session)
        #expect(stats.totalSolved == 3)
        #expect(stats.totalCorrect == 2)
        #expect(stats.gamesPlayed == 1)
        #expect(stats.bestStreak == 2)
        #expect(stats.easyGamesPlayed == 1)
    }

    @Test("Best streak updates when exceeded")
    func bestStreakUpdates() {
        let stats = PlayerStats()
        stats.bestStreak = 5

        var session = GameSession(difficulty: .medium)
        for _ in 0..<10 {
            session.recordAnswer(correct: true)
        }

        stats.recordGame(session: session)
        #expect(stats.bestStreak == 10)
    }

    @Test("Best streak does not decrease")
    func bestStreakNoDecrease() {
        let stats = PlayerStats()
        stats.bestStreak = 20

        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)

        stats.recordGame(session: session)
        #expect(stats.bestStreak == 20)
    }

    // MARK: - Operation Counts (ui-189)

    @Test("Increment operation count works for each type")
    func incrementOperationCount() {
        let stats = PlayerStats()
        stats.incrementOperationCount(.add)
        stats.incrementOperationCount(.add)
        stats.incrementOperationCount(.subtract)
        #expect(stats.addCount == 2)
        #expect(stats.subtractCount == 1)
        #expect(stats.multiplyCount == 0)
    }

    @Test("Favorite operation returns most used")
    func favoriteOperation() {
        let stats = PlayerStats()
        stats.addCount = 10
        stats.subtractCount = 5
        stats.multiplyCount = 3
        let fav = stats.favoriteOperation
        #expect(fav?.symbol == "+")
        #expect(fav?.count == 10)
    }

    // MARK: - Weakest Operation (logic-204)

    @Test("Weakest operation returns nil when no operations played")
    func weakestOperationNil() {
        let stats = PlayerStats()
        #expect(stats.weakestOperation == nil)
    }

    @Test("Weakest operation returns least used")
    func weakestOperationLeastUsed() {
        let stats = PlayerStats()
        stats.addCount = 10
        stats.subtractCount = 5
        stats.multiplyCount = 2
        stats.divideCount = 8
        let weak = stats.weakestOperation
        #expect(weak?.symbol == "x")
        #expect(weak?.count == 2)
    }

    // MARK: - Best Score Per Difficulty (logic-205)

    @Test("Best score per difficulty starts at 0")
    func bestScorePerDifficultyStartsAt0() {
        let stats = PlayerStats()
        #expect(stats.bestScoreForDifficulty(.easy) == 0)
        #expect(stats.bestScoreForDifficulty(.medium) == 0)
        #expect(stats.bestScoreForDifficulty(.hard) == 0)
    }

    @Test("Update best score for difficulty sets new best")
    func updateBestScoreForDifficulty() {
        let stats = PlayerStats()
        stats.updateBestScore(100, for: .easy)
        #expect(stats.bestScoreForDifficulty(.easy) == 100)
        #expect(stats.bestScoreForDifficulty(.medium) == 0)
    }

    @Test("Best score does not decrease for difficulty")
    func bestScoreDoesNotDecrease() {
        let stats = PlayerStats()
        stats.updateBestScore(100, for: .easy)
        stats.updateBestScore(50, for: .easy)
        #expect(stats.bestScoreForDifficulty(.easy) == 100)
    }

    @Test("Best score updates when exceeded for difficulty")
    func bestScoreUpdatesWhenExceeded() {
        let stats = PlayerStats()
        stats.updateBestScore(100, for: .hard)
        stats.updateBestScore(150, for: .hard)
        #expect(stats.bestScoreForDifficulty(.hard) == 150)
    }

    // MARK: - Average Score Per Difficulty (logic-209)

    @Test("Average score returns 0 when no games played")
    func averageScoreZeroGames() {
        let stats = PlayerStats()
        #expect(stats.averageScoreForDifficulty(.easy) == 0)
    }

    @Test("Average score calculates correctly")
    func averageScoreCalculation() {
        let stats = PlayerStats()
        stats.recordScoreForDifficulty(100, for: .easy)
        stats.recordScoreForDifficulty(200, for: .easy)
        #expect(stats.averageScoreForDifficulty(.easy) == 150)
    }

    @Test("Average score is per difficulty")
    func averageScorePerDifficulty() {
        let stats = PlayerStats()
        stats.recordScoreForDifficulty(100, for: .easy)
        stats.recordScoreForDifficulty(300, for: .hard)
        #expect(stats.averageScoreForDifficulty(.easy) == 100)
        #expect(stats.averageScoreForDifficulty(.hard) == 300)
    }

    // MARK: - Total Problems Per Operation (logic-214)

    @Test("Total problems per operation starts at 0")
    func totalProblemsPerOperationZero() {
        let stats = PlayerStats()
        #expect(stats.totalProblemsForOperation(.add) == 0)
    }

    @Test("Total problems per operation increments")
    func totalProblemsPerOperationIncrements() {
        let stats = PlayerStats()
        stats.incrementTotalProblems(.add)
        stats.incrementTotalProblems(.add)
        stats.incrementTotalProblems(.subtract)
        #expect(stats.totalProblemsForOperation(.add) == 2)
        #expect(stats.totalProblemsForOperation(.subtract) == 1)
    }

    // MARK: - Mastery Counts (logic-217)

    @Test("Mastery count starts at 0")
    func masteryCountStartsAt0() {
        let stats = PlayerStats()
        #expect(stats.masteryCountForDifficulty(.easy) == 0)
    }

    @Test("Mastery increments on 90%+ accuracy")
    func masteryIncrementsOn90Plus() {
        let stats = PlayerStats()
        stats.recordMasteryIfQualified(accuracy: 95, difficulty: .easy)
        #expect(stats.masteryCountForDifficulty(.easy) == 1)
    }

    @Test("Mastery does not increment below 90%")
    func masteryDoesNotIncrementBelow90() {
        let stats = PlayerStats()
        stats.recordMasteryIfQualified(accuracy: 85, difficulty: .easy)
        #expect(stats.masteryCountForDifficulty(.easy) == 0)
    }

    // MARK: - Accuracy Per Operation (logic-219)

    @Test("Accuracy per operation returns 0 with no data")
    func accuracyPerOperationZero() {
        let stats = PlayerStats()
        #expect(stats.accuracyForOperation(.add) == 0)
    }

    @Test("Accuracy per operation calculates correctly")
    func accuracyPerOperationCalc() {
        let stats = PlayerStats()
        stats.addCount = 8
        stats.addTotal = 10
        #expect(stats.accuracyForOperation(.add) == 80.0)
    }

    // MARK: - Best Accuracy Per Difficulty (logic-224)

    @Test("Best accuracy starts at 0")
    func bestAccuracyStartsAt0() {
        let stats = PlayerStats()
        #expect(stats.bestAccuracyForDifficulty(.easy) == 0)
    }

    @Test("Best accuracy updates correctly")
    func bestAccuracyUpdates() {
        let stats = PlayerStats()
        stats.updateBestAccuracy(85.0, for: .easy)
        #expect(stats.bestAccuracyForDifficulty(.easy) == 85.0)
        stats.updateBestAccuracy(70.0, for: .easy)
        #expect(stats.bestAccuracyForDifficulty(.easy) == 85.0)
        stats.updateBestAccuracy(95.0, for: .easy)
        #expect(stats.bestAccuracyForDifficulty(.easy) == 95.0)
    }

    // MARK: - XP Per Difficulty (logic-229)

    @Test("XP per difficulty starts at 0")
    func xpPerDifficultyStartsAt0() {
        let stats = PlayerStats()
        #expect(stats.xpForDifficulty(.easy) == 0)
    }

    @Test("XP per difficulty tracks correctly")
    func xpPerDifficultyTracks() {
        let stats = PlayerStats()
        stats.addXPForDifficulty(50, for: .easy)
        stats.addXPForDifficulty(30, for: .easy)
        stats.addXPForDifficulty(100, for: .hard)
        #expect(stats.xpForDifficulty(.easy) == 80)
        #expect(stats.xpForDifficulty(.hard) == 100)
        #expect(stats.xpForDifficulty(.medium) == 0)
    }

    // MARK: - Longest Session (logic-234)

    @Test("Longest session starts at 0")
    func longestSessionStartsAt0() {
        let stats = PlayerStats()
        #expect(stats.longestSessionSeconds == 0)
    }

    @Test("Longest session updates correctly")
    func longestSessionUpdates() {
        let stats = PlayerStats()
        stats.updateLongestSession(30)
        #expect(stats.longestSessionSeconds == 30)
        stats.updateLongestSession(20)
        #expect(stats.longestSessionSeconds == 30)
        stats.updateLongestSession(45)
        #expect(stats.longestSessionSeconds == 45)
    }

    // MARK: - Best Daily Streak (logic-239)

    @Test("Best daily streak starts at 0")
    func bestDailyStreakStartsAt0() {
        let stats = PlayerStats()
        #expect(stats.bestDailyStreak == 0)
    }

    @Test("Best daily streak updates with updateStreak")
    func bestDailyStreakUpdates() {
        let stats = PlayerStats()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: .now)!
        stats.updateStreak(on: yesterday)
        stats.updateStreak(on: .now)
        #expect(stats.bestDailyStreak == 2)
    }
}
