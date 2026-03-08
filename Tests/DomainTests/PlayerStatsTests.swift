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
}
