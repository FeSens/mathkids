import Testing
import Foundation
@testable import MathKids

@Suite("PlayerStats Extended Tests")
struct PlayerStatsExtendedTests {
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
