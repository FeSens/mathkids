import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 87 Tests - logic-514 to logic-518")
struct Batch87Tests {

    // MARK: - logic-514: HomeViewModel.xpSummaryText

    @MainActor
    @Test("xpSummaryText includes XP count and level")
    func xpSummaryTextFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.totalXP = 150
        vm.currentLevel = 2
        #expect(vm.xpSummaryText.contains("150"))
        #expect(vm.xpSummaryText.contains("2"))
    }

    // MARK: - logic-515: StatsViewModel.improvementTrend

    @MainActor
    @Test("improvementTrend returns stable text")
    func improvementTrendStable() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        let text = vm.improvementTrend
        #expect(!text.isEmpty)
    }

    // MARK: - logic-516: ResultsViewModel.timeTakenText

    @MainActor
    @Test("timeTakenText includes seconds")
    func timeTakenTextSeconds() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<15 { session.tick() }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timeTakenText.contains("s") || vm.timeTakenText.contains("sec"))
    }

    // MARK: - logic-517: MathProblem.isSubtractionFromTen

    @Test("isSubtractionFromTen true for 10-3")
    func isSubtractionFromTenTrue() {
        let problem = MathProblem(operand1: 10, operand2: 3, operation: .subtract)
        #expect(problem.isSubtractionFromTen == true)
    }

    @Test("isSubtractionFromTen false for 5-3")
    func isSubtractionFromTenFalse() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(problem.isSubtractionFromTen == false)
    }

    @Test("isSubtractionFromTen false for addition")
    func isSubtractionFromTenWrongOp() {
        let problem = MathProblem(operand1: 10, operand2: 3, operation: .add)
        #expect(problem.isSubtractionFromTen == false)
    }

    // MARK: - logic-518: GameSession.remainingTimePercentage

    @Test("remainingTimePercentage returns 100 at start")
    func remainingTimePercentageFull() {
        let session = GameSession(difficulty: .easy)
        #expect(session.remainingTimePercentage == 100)
    }

    @Test("remainingTimePercentage returns ~50 at half time")
    func remainingTimePercentageHalf() {
        var session = GameSession(difficulty: .easy) // 60 seconds
        for _ in 0..<30 { session.tick() }
        #expect(session.remainingTimePercentage == 50)
    }
}
