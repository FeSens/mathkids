import Testing
@testable import MathKids

@Suite("PlayerStats Batch 38 Tests")
struct PlayerStatsBatch38Tests {
    // MARK: - Consistency Score (logic-266)

    @Test("Consistency returns 0 with no games")
    func consistencyNoGames() {
        let stats = PlayerStats()
        #expect(stats.consistencyScore == 0)
    }

    @Test("High consistency for similar accuracies")
    func consistencyHighForSimilar() {
        let stats = PlayerStats()
        stats.recentAccuracies = [80, 82, 81, 79, 80]
        #expect(stats.consistencyScore >= 90)
    }

    @Test("Low consistency for varied accuracies")
    func consistencyLowForVaried() {
        let stats = PlayerStats()
        stats.recentAccuracies = [30, 90, 40, 95, 50]
        #expect(stats.consistencyScore < 70)
    }

    // MARK: - Favorite Difficulty (logic-271)

    @Test("Favorite difficulty nil with no games")
    func favoriteDifficultyNil() {
        let stats = PlayerStats()
        #expect(stats.favoriteDifficulty == nil)
    }

    @Test("Favorite difficulty is easy when most games are easy")
    func favoriteDifficultyEasy() {
        let stats = PlayerStats()
        stats.easyGamesPlayed = 10
        stats.mediumGamesPlayed = 3
        stats.hardGamesPlayed = 1
        #expect(stats.favoriteDifficulty == .easy)
    }

    @Test("Favorite difficulty is hard when most games are hard")
    func favoriteDifficultyHard() {
        let stats = PlayerStats()
        stats.easyGamesPlayed = 1
        stats.mediumGamesPlayed = 2
        stats.hardGamesPlayed = 15
        #expect(stats.favoriteDifficulty == .hard)
    }

    // MARK: - Perfect Game Count (logic-275)

    @Test("Perfect game count starts at 0")
    func perfectGameCountStartsAt0() {
        let stats = PlayerStats()
        #expect(stats.perfectGameCount == 0)
    }

    @Test("Perfect game count increments for perfect game")
    func perfectGameCountIncrements() {
        let stats = PlayerStats()
        stats.recordPerfectGameIfQualified(accuracy: 100)
        #expect(stats.perfectGameCount == 1)
    }

    @Test("Perfect game count does not increment for non-perfect")
    func perfectGameCountNotForNonPerfect() {
        let stats = PlayerStats()
        stats.recordPerfectGameIfQualified(accuracy: 90)
        #expect(stats.perfectGameCount == 0)
    }

    // MARK: - Average Session Length (logic-281)

    @Test("Average session length 0 with no games")
    func avgSessionLengthZero() {
        let stats = PlayerStats()
        #expect(stats.averageSessionSeconds == 0)
    }

    @Test("Average session length correct")
    func avgSessionLengthCorrect() {
        let stats = PlayerStats()
        stats.totalTimePlayedSeconds = 300
        stats.gamesPlayed = 5
        #expect(stats.averageSessionSeconds == 60)
    }

    // MARK: - Average XP Per Session (logic-285)

    @Test("Average XP per session 0 with no games")
    func avgXPPerSessionZero() {
        let stats = PlayerStats()
        #expect(stats.averageXPPerSession == 0)
    }

    @Test("Average XP per session correct")
    func avgXPPerSessionCorrect() {
        let stats = PlayerStats()
        stats.totalXP = 500
        stats.gamesPlayed = 10
        #expect(stats.averageXPPerSession == 50)
    }

    // MARK: - Win Rate (logic-291)

    @Test("Win rate 0 with no games")
    func winRateZero() {
        let stats = PlayerStats()
        #expect(stats.winRateForDifficulty(.easy) == 0)
    }

    @Test("Win rate correct after recording wins")
    func winRateCorrect() {
        let stats = PlayerStats()
        stats.easyGamesPlayed = 10
        stats.easyMasteryCount = 4 // 4 out of 10 = 40%
        #expect(stats.winRateForDifficulty(.easy) == 40)
    }
}
