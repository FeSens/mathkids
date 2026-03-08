import Testing
@testable import MathKids

@Suite("Batch 73 Tests - logic-444 to logic-448")
struct Batch73Tests {

    // MARK: - logic-444: GameSession.correctAnswerRate

    @Test("correctAnswerRate returns 0.0 when no answers")
    func correctAnswerRateNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.correctAnswerRate == 0.0)
    }

    @Test("correctAnswerRate returns 0.75 for 3 of 4 correct")
    func correctAnswerRateThreeOfFour() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.correctAnswerRate == 0.75)
    }

    @Test("correctAnswerRate returns 1.0 for all correct")
    func correctAnswerRateAllCorrect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.correctAnswerRate == 1.0)
    }

    // MARK: - logic-445: Achievement.lockedAchievements

    @Test("lockedAchievements returns all for fresh stats")
    func lockedAchievementsFreshStats() {
        let stats = PlayerStats()
        let locked = Achievement.lockedAchievements(for: stats)
        #expect(locked.count == Achievement.all.count)
    }

    @Test("lockedAchievements excludes unlocked ones")
    func lockedAchievementsExcludesUnlocked() {
        let stats = PlayerStats()
        stats.gamesPlayed = 1
        let locked = Achievement.lockedAchievements(for: stats)
        #expect(locked.count < Achievement.all.count)
    }

    // MARK: - logic-446: DifficultyLevel.starRating

    @Test("easy starRating is one star")
    func easyStarRating() {
        #expect(DifficultyLevel.easy.starRating == "⭐")
    }

    @Test("medium starRating is two stars")
    func mediumStarRating() {
        #expect(DifficultyLevel.medium.starRating == "⭐⭐")
    }

    @Test("hard starRating is three stars")
    func hardStarRating() {
        #expect(DifficultyLevel.hard.starRating == "⭐⭐⭐")
    }

    // MARK: - logic-447: LevelSystem.totalXPAcrossAllLevels

    @Test("totalXPAcrossAllLevels returns sum of thresholds")
    func totalXPAcrossAllLevels() {
        let expected = LevelSystem.thresholds.reduce(0, +)
        #expect(LevelSystem.totalXPAcrossAllLevels == expected)
    }

    @Test("totalXPAcrossAllLevels is greater than 0")
    func totalXPAcrossAllLevelsPositive() {
        #expect(LevelSystem.totalXPAcrossAllLevels > 0)
    }

    // MARK: - logic-448: MathProblem.isNegativeResult

    @Test("isNegativeResult true for 3-5")
    func isNegativeResultSubtraction() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .subtract)
        #expect(problem.isNegativeResult == true)
    }

    @Test("isNegativeResult false for 5-3")
    func isNegativeResultPositive() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(problem.isNegativeResult == false)
    }

    @Test("isNegativeResult false for addition")
    func isNegativeResultAddition() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.isNegativeResult == false)
    }
}
