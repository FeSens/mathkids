import Testing
@testable import MathKids

@Suite("Batch 78 Tests - logic-469 to logic-473")
struct Batch78Tests {

    // MARK: - logic-469: GameSession.streakPercentage

    @Test("streakPercentage returns 50 for 5 of 10")
    func streakPercentageHalf() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        #expect(session.streakPercentage == 50)
    }

    @Test("streakPercentage returns 0 for no answers")
    func streakPercentageNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakPercentage == 0)
    }

    // MARK: - logic-470: Achievement.hasUnlockedAll

    @Test("hasUnlockedAll returns false for fresh stats")
    func hasUnlockedAllFalse() {
        let stats = PlayerStats()
        #expect(Achievement.hasUnlockedAll(for: stats) == false)
    }

    // MARK: - logic-471: DifficultyLevel.scoreRange

    @Test("scoreRange min is 0")
    func scoreRangeMin() {
        #expect(DifficultyLevel.easy.scoreRange.min == 0)
    }

    @Test("scoreRange max equals maxPossibleScore")
    func scoreRangeMax() {
        #expect(DifficultyLevel.easy.scoreRange.max == DifficultyLevel.easy.maxPossibleScore)
    }

    // MARK: - logic-472: LevelSystem.formattedLevel

    @Test("formattedLevel returns Lv.1 for 0 XP")
    func formattedLevelOne() {
        #expect(LevelSystem.formattedLevel(for: 0) == "Lv.1")
    }

    @Test("formattedLevel returns Lv.2 for 100 XP")
    func formattedLevelTwo() {
        #expect(LevelSystem.formattedLevel(for: 100) == "Lv.2")
    }

    // MARK: - logic-473: MathProblem.bothOperandsEqual

    @Test("bothOperandsEqual true for 5+5")
    func bothOperandsEqualTrue() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(problem.bothOperandsEqual == true)
    }

    @Test("bothOperandsEqual false for 3+5")
    func bothOperandsEqualFalse() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.bothOperandsEqual == false)
    }
}
