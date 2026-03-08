import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 92 Tests - logic-539 to logic-543")
struct Batch92Tests {

    // MARK: - logic-539: HomeViewModel.isBeginner

    @MainActor
    @Test("isBeginner true when no problems solved")
    func isBeginnerTrue() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.totalSolved = 0
        #expect(vm.isBeginner == true)
    }

    @MainActor
    @Test("isBeginner false when problems solved")
    func isBeginnerFalse() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.totalSolved = 10
        #expect(vm.isBeginner == false)
    }

    // MARK: - logic-540: StatsViewModel.favoriteOperationDescription

    @MainActor
    @Test("favoriteOperationDescription includes operation")
    func favOpDescWithOp() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.favoriteOperation = "+"
        #expect(vm.favoriteOperationDescription.contains("+"))
    }

    @MainActor
    @Test("favoriteOperationDescription fallback when none")
    func favOpDescFallback() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.favoriteOperation = nil
        #expect(!vm.favoriteOperationDescription.isEmpty)
    }

    // MARK: - logic-541: ResultsViewModel.hasStreak

    @MainActor
    @Test("hasStreak true when streak exists")
    func hasStreakTrue() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.hasStreak == true)
    }

    @MainActor
    @Test("hasStreak false when no streak")
    func hasStreakFalse() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.hasStreak == false)
    }

    // MARK: - logic-542: DifficultyLevel.timeFormatted

    @Test("easy timeFormatted is 1:00")
    func easyTimeFormatted() {
        #expect(DifficultyLevel.easy.timeFormatted == "1:00")
    }

    @Test("medium timeFormatted is 0:45")
    func mediumTimeFormatted() {
        #expect(DifficultyLevel.medium.timeFormatted == "0:45")
    }

    @Test("hard timeFormatted is 0:30")
    func hardTimeFormatted() {
        #expect(DifficultyLevel.hard.timeFormatted == "0:30")
    }

    // MARK: - logic-543: MathProblem.isAdditionOfSameDigit

    @Test("isAdditionOfSameDigit true for 5+5")
    func isAddSameTrue() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(problem.isAdditionOfSameDigit == true)
    }

    @Test("isAdditionOfSameDigit false for 3+5")
    func isAddSameFalseDiff() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.isAdditionOfSameDigit == false)
    }

    @Test("isAdditionOfSameDigit false for multiply")
    func isAddSameFalseOp() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .multiply)
        #expect(problem.isAdditionOfSameDigit == false)
    }
}
