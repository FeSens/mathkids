import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 97 Tests")
struct Batch97Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-564: HomeViewModel.currentLevelText

    @Test @MainActor
    func currentLevelText() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.currentLevel = 5
        #expect(vm.currentLevelText == "Level 5")
    }

    // MARK: - logic-565: StatsViewModel.totalWrongText

    @Test @MainActor
    func totalWrongText() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.totalSolved = 100
        vm.totalCorrect = 85
        #expect(vm.totalWrongText == "15 wrong")
    }

    @Test @MainActor
    func totalWrongText_zero() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.totalSolved = 10
        vm.totalCorrect = 10
        #expect(vm.totalWrongText == "0 wrong")
    }

    // MARK: - logic-566: ResultsViewModel.accuracyPercentInt

    @Test @MainActor
    func accuracyPercentInt() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyPercentInt == Int(vm.accuracy))
    }

    // MARK: - logic-567: GameSession.hasStarted

    @Test
    func hasStarted_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.hasStarted == false)
    }

    // MARK: - logic-568: Operation.opposite

    @Test
    func opposite_add() {
        #expect(Operation.add.opposite == .subtract)
    }

    @Test
    func opposite_multiply() {
        #expect(Operation.multiply.opposite == .divide)
    }

    @Test
    func opposite_subtract() {
        #expect(Operation.subtract.opposite == .add)
    }
}
