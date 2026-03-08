import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 71 Tests")
struct Batch71Tests {

    // MARK: - GameSession scorePerSecond (logic-434)

    @Test("50 pts in 10 seconds = 5.0")
    func sps5() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.scorePerSecond == 5.0)
    }

    @Test("0 when no time played")
    func sps0() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scorePerSecond == 0)
    }

    // MARK: - MathProblem isAdditionTen (logic-435)

    @Test("10+5 is addition ten")
    func addTen105() {
        let p = MathProblem(operand1: 10, operand2: 5, operation: .add)
        #expect(p.isAdditionTen)
    }

    @Test("3+10 is addition ten")
    func addTen310() {
        let p = MathProblem(operand1: 3, operand2: 10, operation: .add)
        #expect(p.isAdditionTen)
    }

    @Test("3+5 is not addition ten")
    func addTenNot() {
        let p = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(!p.isAdditionTen)
    }

    // MARK: - LevelSystem isAtMaxLevel (logic-436)

    @Test("4500+ returns true")
    func atMax() {
        #expect(LevelSystem.isAtMaxLevel(xp: 4500))
        #expect(LevelSystem.isAtMaxLevel(xp: 5000))
    }

    @Test("100 returns false")
    func notMax() {
        #expect(!LevelSystem.isAtMaxLevel(xp: 100))
    }

    // MARK: - DifficultyLevel bonusMultiplierText (logic-438)

    @Test("Easy shows 1.0x")
    func bonusEasy() {
        #expect(DifficultyLevel.easy.bonusMultiplierText == "1.0x bonus")
    }

    @Test("Medium shows 1.5x")
    func bonusMedium() {
        #expect(DifficultyLevel.medium.bonusMultiplierText == "1.5x bonus")
    }

    @Test("Hard shows 2.0x")
    func bonusHard() {
        #expect(DifficultyLevel.hard.bonusMultiplierText == "2.0x bonus")
    }
}

@MainActor
@Suite("Batch 71 Feature Tests")
struct Batch71FeatureTests {

    // MARK: - HomeViewModel operationCountText (logic-437)

    @Test("Shows selected count")
    func opCount() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let vm = HomeViewModel(statsService: StatsService(modelContainer: container))
        #expect(vm.operationCountText.contains("\(vm.selectedOperations.count)"))
    }

    @Test("Shows total count")
    func opTotal() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let vm = HomeViewModel(statsService: StatsService(modelContainer: container))
        #expect(vm.operationCountText.contains("4"))
    }
}
