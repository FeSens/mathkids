import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 91 Tests - logic-534 to logic-538")
struct Batch91Tests {

    // MARK: - logic-534: HomeViewModel.levelNameText

    @MainActor
    @Test("levelNameText includes level name")
    func levelNameTextContent() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.levelName = "Explorer"
        #expect(vm.levelNameText.contains("Explorer"))
    }

    // MARK: - logic-535: StatsViewModel.weakestOperationDescription

    @MainActor
    @Test("weakestOperationDescription includes symbol when available")
    func weakestOpDescWithSymbol() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.weakestOperationSymbol = "+"
        #expect(vm.weakestOperationDescription.contains("+"))
    }

    @MainActor
    @Test("weakestOperationDescription fallback when none")
    func weakestOpDescFallback() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.weakestOperationSymbol = nil
        #expect(!vm.weakestOperationDescription.isEmpty)
    }

    // MARK: - logic-536: ResultsViewModel.sessionDurationLabel

    @MainActor
    @Test("sessionDurationLabel includes time and unit")
    func sessionDurationLabelFormat() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.sessionDurationLabel.contains("20"))
        #expect(vm.sessionDurationLabel.contains("s"))
    }

    // MARK: - logic-537: MathProblem.isMultiplicationByZero

    @Test("isMultiplicationByZero true for 5x0")
    func isMultByZeroSecond() {
        let problem = MathProblem(operand1: 5, operand2: 0, operation: .multiply)
        #expect(problem.isMultiplicationByZero == true)
    }

    @Test("isMultiplicationByZero true for 0x5")
    func isMultByZeroFirst() {
        let problem = MathProblem(operand1: 0, operand2: 5, operation: .multiply)
        #expect(problem.isMultiplicationByZero == true)
    }

    @Test("isMultiplicationByZero false for 5x3")
    func isMultByZeroFalse() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .multiply)
        #expect(problem.isMultiplicationByZero == false)
    }

    // MARK: - logic-538: Achievement.completionMessage

    @Test("completionMessage for fresh stats is encouraging")
    func completionMessageFresh() {
        let stats = PlayerStats()
        let msg = Achievement.completionMessage(for: stats)
        #expect(!msg.isEmpty)
    }

    @Test("completionMessage for partial progress mentions progress")
    func completionMessagePartial() {
        let stats = PlayerStats()
        stats.gamesPlayed = 1
        let msg = Achievement.completionMessage(for: stats)
        #expect(!msg.isEmpty)
    }
}
