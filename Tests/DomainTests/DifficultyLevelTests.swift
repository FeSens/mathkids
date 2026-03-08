import Testing
@testable import MathKids

@Suite("DifficultyLevel Tests")
struct DifficultyLevelTests {
    @Test("Easy has operands 1-10")
    func easyOperandRange() {
        let range = DifficultyLevel.easy.operandRange
        #expect(range == 1...10)
    }

    @Test("Medium has operands 1-20")
    func mediumOperandRange() {
        let range = DifficultyLevel.medium.operandRange
        #expect(range == 1...20)
    }

    @Test("Hard has operands 1-50")
    func hardOperandRange() {
        let range = DifficultyLevel.hard.operandRange
        #expect(range == 1...50)
    }

    @Test("Easy only allows add and subtract")
    func easyOperations() {
        let ops = DifficultyLevel.easy.allowedOperations
        #expect(ops == [.add, .subtract])
    }

    @Test("Medium allows add, subtract, multiply")
    func mediumOperations() {
        let ops = DifficultyLevel.medium.allowedOperations
        #expect(ops == [.add, .subtract, .multiply])
    }

    @Test("Hard allows all operations")
    func hardOperations() {
        let ops = DifficultyLevel.hard.allowedOperations
        #expect(ops == Operation.allCases)
    }

    @Test("Easy has 60 second time limit")
    func easyTimeLimit() {
        #expect(DifficultyLevel.easy.timeLimitSeconds == 60)
    }

    @Test("Medium has 45 second time limit")
    func mediumTimeLimit() {
        #expect(DifficultyLevel.medium.timeLimitSeconds == 45)
    }

    @Test("Hard has 30 second time limit")
    func hardTimeLimit() {
        #expect(DifficultyLevel.hard.timeLimitSeconds == 30)
    }

    // MARK: - Next Difficulty (logic-218)

    @Test("Easy next difficulty is medium")
    func easyNextDifficulty() {
        #expect(DifficultyLevel.easy.nextDifficulty == .medium)
    }

    @Test("Medium next difficulty is hard")
    func mediumNextDifficulty() {
        #expect(DifficultyLevel.medium.nextDifficulty == .hard)
    }

    @Test("Hard next difficulty is nil")
    func hardNextDifficulty() {
        #expect(DifficultyLevel.hard.nextDifficulty == nil)
    }

    // MARK: - Previous Difficulty (logic-228)

    @Test("Hard previous difficulty is medium")
    func hardPreviousDifficulty() {
        #expect(DifficultyLevel.hard.previousDifficulty == .medium)
    }

    @Test("Medium previous difficulty is easy")
    func mediumPreviousDifficulty() {
        #expect(DifficultyLevel.medium.previousDifficulty == .easy)
    }

    @Test("Easy previous difficulty is nil")
    func easyPreviousDifficulty() {
        #expect(DifficultyLevel.easy.previousDifficulty == nil)
    }

    // MARK: - Operand Description (logic-241)

    @Test("Operand description for each difficulty")
    func operandDescriptions() {
        #expect(DifficultyLevel.easy.operandDescription == "1 to 10")
        #expect(DifficultyLevel.medium.operandDescription == "1 to 20")
        #expect(DifficultyLevel.hard.operandDescription == "1 to 50")
    }

    // MARK: - Streak Bonus Multiplier (logic-254)

    @Test("Easy has 1x streak bonus multiplier")
    func easyStreakMultiplier() {
        #expect(DifficultyLevel.easy.streakBonusMultiplier == 1.0)
    }

    @Test("Medium has 1.5x streak bonus multiplier")
    func mediumStreakMultiplier() {
        #expect(DifficultyLevel.medium.streakBonusMultiplier == 1.5)
    }

    @Test("Hard has 2x streak bonus multiplier")
    func hardStreakMultiplier() {
        #expect(DifficultyLevel.hard.streakBonusMultiplier == 2.0)
    }

    // MARK: - Recommended Time Per Problem (logic-267)

    @Test("Easy recommends 6 seconds")
    func easyRecommendedTime() {
        #expect(DifficultyLevel.easy.recommendedSecondsPerProblem == 6)
    }

    @Test("Medium recommends 4 seconds")
    func mediumRecommendedTime() {
        #expect(DifficultyLevel.medium.recommendedSecondsPerProblem == 4)
    }

    @Test("Hard recommends 3 seconds")
    func hardRecommendedTime() {
        #expect(DifficultyLevel.hard.recommendedSecondsPerProblem == 3)
    }
}
