import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 90 Tests - logic-529 to logic-533")
struct Batch90Tests {

    // MARK: - logic-529: HomeViewModel.recommendedDifficultyText

    @MainActor
    @Test("recommendedDifficultyText includes name and emoji")
    func recommendedDifficultyTextFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.recommendedDifficulty = .easy
        #expect(vm.recommendedDifficultyText.contains("Easy"))
        #expect(vm.recommendedDifficultyText.contains("🌱"))
    }

    // MARK: - logic-530: StatsViewModel.operationCountText

    @MainActor
    @Test("operationCountText includes count and operations")
    func operationCountTextFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.operationAccuracies = ["+": 80.0, "-": 70.0]
        #expect(vm.operationCountText.contains("2"))
        #expect(vm.operationCountText.contains("operation"))
    }

    // MARK: - logic-531: ResultsViewModel.difficultyDisplayText

    @MainActor
    @Test("difficultyDisplayText includes emoji and name")
    func difficultyDisplayTextFormat() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyDisplayText.contains("🌱"))
        #expect(vm.difficultyDisplayText.contains("Easy"))
    }

    // MARK: - logic-532: MathProblem.isOddResult

    @Test("isOddResult true for 2+3=5")
    func isOddResultTrue() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.isOddResult == true)
    }

    @Test("isOddResult false for 2+2=4")
    func isOddResultFalse() {
        let problem = MathProblem(operand1: 2, operand2: 2, operation: .add)
        #expect(problem.isOddResult == false)
    }

    // MARK: - logic-533: GameSession.hasTimeRemaining

    @Test("hasTimeRemaining true at start")
    func hasTimeRemainingTrue() {
        let session = GameSession(difficulty: .easy)
        #expect(session.hasTimeRemaining == true)
    }

    @Test("hasTimeRemaining false when expired")
    func hasTimeRemainingFalse() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.hasTimeRemaining == false)
    }
}
