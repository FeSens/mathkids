import Testing
@testable import MathKids

@Suite("Batch 55 Tests")
struct Batch55Tests {

    // MARK: - GameSession wrongAnswerPositions (logic-354)

    @Test("wrongAnswerPositions tracks wrong answer indices")
    func wrongPositions() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.wrongAnswerPositions == [1, 3])
    }

    @Test("wrongAnswerPositions empty when all correct")
    func wrongPositionsAllCorrect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.wrongAnswerPositions.isEmpty)
    }

    // MARK: - MathProblem isEasyProblem (logic-355)

    @Test("3+2 is an easy problem")
    func isEasySmallAdd() {
        let p = MathProblem(operand1: 3, operand2: 2, operation: .add)
        #expect(p.isEasyProblem)
    }

    @Test("12+5 is not an easy problem")
    func isNotEasyLargeAdd() {
        let p = MathProblem(operand1: 12, operand2: 5, operation: .add)
        #expect(!p.isEasyProblem)
    }

    @Test("5x5 is an easy problem")
    func isEasySmallMultiply() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .multiply)
        #expect(p.isEasyProblem)
    }

    // MARK: - LevelSystem totalLevels (logic-356)

    @Test("totalLevels is 10")
    func totalLevels() {
        #expect(LevelSystem.totalLevels == 10)
    }

    @Test("totalLevels matches thresholds count")
    func totalLevelsMatchesThresholds() {
        #expect(LevelSystem.totalLevels == LevelSystem.thresholds.count)
    }

    // MARK: - GameSession scoreEfficiency (logic-357)

    @Test("scoreEfficiency returns points per second")
    func scoreEfficiency() {
        var session = GameSession(difficulty: .easy) // 10 pts per correct
        for _ in 0..<20 { session.tick() }
        for _ in 0..<4 { session.recordAnswer(correct: true) } // 40 pts, 20 seconds
        #expect(session.scoreEfficiency == 2.0)
    }

    @Test("scoreEfficiency returns 0 with no time")
    func scoreEfficiencyNoTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoreEfficiency == 0)
    }

    // MARK: - Achievement progressFraction (logic-358)

    @Test("progressFraction for partial progress")
    func progressFractionPartial() {
        let stats = PlayerStats()
        stats.gamesPlayed = 5 // ten_games needs 10
        let achievement = Achievement.all.first { $0.id == "ten_games" }!
        #expect(achievement.progressFraction(stats: stats) == 0.5)
    }

    @Test("progressFraction for complete achievement")
    func progressFractionComplete() {
        let stats = PlayerStats()
        stats.gamesPlayed = 10
        let achievement = Achievement.all.first { $0.id == "ten_games" }!
        #expect(achievement.progressFraction(stats: stats) == 1.0)
    }

    @Test("progressFraction for zero progress")
    func progressFractionZero() {
        let stats = PlayerStats()
        stats.gamesPlayed = 0
        let achievement = Achievement.all.first { $0.id == "ten_games" }!
        #expect(achievement.progressFraction(stats: stats) == 0.0)
    }
}
