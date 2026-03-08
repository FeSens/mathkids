import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 86 Tests - logic-509 to logic-513")
struct Batch86Tests {

    // MARK: - logic-509: HomeViewModel.isAllOperationsSelected

    @MainActor
    @Test("isAllOperationsSelected true when all selected")
    func isAllSelectedTrue() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.selectedOperations = Set(Operation.allCases)
        #expect(vm.isAllOperationsSelected == true)
    }

    @MainActor
    @Test("isAllOperationsSelected false when subset")
    func isAllSelectedFalse() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.selectedOperations = [.add]
        #expect(vm.isAllOperationsSelected == false)
    }

    // MARK: - logic-510: StatsViewModel.dailyStreakText

    @MainActor
    @Test("dailyStreakText includes streak count")
    func dailyStreakTextCount() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.dailyStreak = 5
        #expect(vm.dailyStreakText.contains("5"))
    }

    @MainActor
    @Test("dailyStreakText shows day word")
    func dailyStreakTextDay() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.dailyStreak = 1
        #expect(vm.dailyStreakText.contains("day"))
    }

    // MARK: - logic-511: ResultsViewModel.scorePercentageText

    @MainActor
    @Test("scorePercentageText includes percentage sign")
    func scorePercentageTextSign() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.scorePercentageText.contains("%"))
    }

    // MARK: - logic-512: MathProblem.isAddingToTen

    @Test("isAddingToTen true for 3+7")
    func isAddingToTenTrue() {
        let problem = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(problem.isAddingToTen == true)
    }

    @Test("isAddingToTen false for 3+5")
    func isAddingToTenFalse() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.isAddingToTen == false)
    }

    @Test("isAddingToTen false for multiply")
    func isAddingToTenWrongOp() {
        let problem = MathProblem(operand1: 5, operand2: 2, operation: .multiply)
        #expect(problem.isAddingToTen == false)
    }

    // MARK: - logic-513: Operation.randomOperation

    @Test("randomOperation returns valid operation")
    func randomOperationValid() {
        let op = Operation.randomOperation
        #expect(Operation.allCases.contains(op))
    }
}
