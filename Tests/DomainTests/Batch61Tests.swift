import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 61 Tests")
struct Batch61Tests {

    // MARK: - GameSession percentComplete (logic-384)

    @Test("50% when half time used")
    func halfTime() {
        var session = GameSession(difficulty: .easy) // 60s
        for _ in 0..<30 { session.tick() }
        #expect(session.percentComplete == 50)
    }

    @Test("0% at start")
    func atStart() {
        let session = GameSession(difficulty: .easy)
        #expect(session.percentComplete == 0)
    }

    @Test("100% when time up")
    func timeUp() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.percentComplete == 100)
    }

    // MARK: - MathProblem minOperand (logic-385)

    @Test("minOperand for 3+7 returns 3")
    func minOp37() {
        let p = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(p.minOperand == 3)
    }

    @Test("minOperand for 10-5 returns 5")
    func minOp105() {
        let p = MathProblem(operand1: 10, operand2: 5, operation: .subtract)
        #expect(p.minOperand == 5)
    }

    @Test("minOperand for equal returns that value")
    func minOpEqual() {
        let p = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(p.minOperand == 4)
    }

    // MARK: - LevelSystem percentToMax (logic-386)

    @Test("0 XP returns 0%")
    func percentMax0() {
        #expect(LevelSystem.percentToMax(currentXP: 0) == 0)
    }

    @Test("Max XP returns 100%")
    func percentMax100() {
        #expect(LevelSystem.percentToMax(currentXP: 4500) == 100)
    }

    @Test("2250 XP returns 50%")
    func percentMax50() {
        #expect(LevelSystem.percentToMax(currentXP: 2250) == 50)
    }

    // MARK: - DifficultyLevel difficultyIndex (logic-388)

    @Test("Easy returns 0")
    func indexEasy() {
        #expect(DifficultyLevel.easy.difficultyIndex == 0)
    }

    @Test("Medium returns 1")
    func indexMedium() {
        #expect(DifficultyLevel.medium.difficultyIndex == 1)
    }

    @Test("Hard returns 2")
    func indexHard() {
        #expect(DifficultyLevel.hard.difficultyIndex == 2)
    }
}

@MainActor
@Suite("Batch 61 Feature Tests")
struct Batch61FeatureTests {

    // MARK: - HomeViewModel levelProgressDescription (logic-387)

    @Test("Shows percentage and next level")
    func progressDesc() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = HomeViewModel(statsService: StatsService(modelContainer: container))
        vm.totalXP = 50
        vm.currentLevel = 1
        #expect(vm.levelProgressDescription.contains("%"))
    }

    @Test("Shows max level text when at max")
    func progressDescMax() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = HomeViewModel(statsService: StatsService(modelContainer: container))
        vm.totalXP = 5000
        vm.currentLevel = 10
        #expect(vm.levelProgressDescription.lowercased().contains("max"))
    }
}
