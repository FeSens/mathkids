import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 58 Tests")
struct Batch58Tests {

    // MARK: - GameSession perfectStreakBonus (logic-369)

    @Test("bestStreak 10 returns 20 bonus")
    func streakBonus10() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.perfectStreakBonus == 20)
    }

    @Test("bestStreak 3 returns 0 bonus")
    func streakBonus3() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.perfectStreakBonus == 0)
    }

    @Test("bestStreak 15 returns 30 bonus")
    func streakBonus15() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<15 { session.recordAnswer(correct: true) }
        #expect(session.perfectStreakBonus == 30)
    }

    // MARK: - MathProblem isIdentityOperation (logic-370)

    @Test("5+0 is identity operation")
    func identityAddZero() {
        let p = MathProblem(operand1: 5, operand2: 0, operation: .add)
        #expect(p.isIdentityOperation)
    }

    @Test("5*1 is identity operation")
    func identityMultiplyOne() {
        let p = MathProblem(operand1: 5, operand2: 1, operation: .multiply)
        #expect(p.isIdentityOperation)
    }

    @Test("5+3 is not identity operation")
    func notIdentity() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(!p.isIdentityOperation)
    }

    // MARK: - LevelSystem milestoneDescription (logic-371)

    @Test("Level 1 returns beginner message")
    func milestoneLevel1() {
        let desc = LevelSystem.milestoneDescription(forLevel: 1)
        #expect(!desc.isEmpty)
    }

    @Test("Level 10 returns max level message")
    func milestoneLevel10() {
        let desc = LevelSystem.milestoneDescription(forLevel: 10)
        #expect(desc.lowercased().contains("max") || desc.lowercased().contains("wizard"))
    }

    @Test("All valid levels have non-empty descriptions")
    func milestoneAllLevels() {
        for level in 1...10 {
            #expect(!LevelSystem.milestoneDescription(forLevel: level).isEmpty)
        }
    }

    // MARK: - DifficultyLevel estimatedProblemsPerGame (logic-373)

    @Test("Easy estimates 10 problems")
    func estimatedEasy() {
        #expect(DifficultyLevel.easy.estimatedProblemsPerGame == 10)
    }

    @Test("Medium estimates 11 problems")
    func estimatedMedium() {
        #expect(DifficultyLevel.medium.estimatedProblemsPerGame == 11)
    }

    @Test("Hard estimates 10 problems")
    func estimatedHard() {
        #expect(DifficultyLevel.hard.estimatedProblemsPerGame == 10)
    }
}

@MainActor
@Suite("Batch 58 Feature Tests")
struct Batch58FeatureTests {

    // MARK: - StatsViewModel averageScoreText (logic-372)

    @Test("averageScoreText shows 0 when no games")
    func avgScoreNoGames() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        #expect(vm.averageScoreText.contains("0"))
    }

    @Test("averageScoreText shows formatted score")
    func avgScoreWithGames() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.bestScore = 100
        vm.gamesPlayed = 5
        #expect(!vm.averageScoreText.isEmpty)
    }
}
