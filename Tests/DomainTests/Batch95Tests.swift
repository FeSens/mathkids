import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 95 Tests")
struct Batch95Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-554: HomeViewModel.selectedOperationsEmojis

    @Test @MainActor
    func selectedOperationsEmojis_allOps() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedOperations = [.add, .multiply]
        let emojis = vm.selectedOperationsEmojis
        #expect(emojis.contains("➕"))
        #expect(emojis.contains("✖️"))
    }

    @Test @MainActor
    func selectedOperationsEmojis_single() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedOperations = [.subtract]
        #expect(vm.selectedOperationsEmojis == "➖")
    }

    // MARK: - logic-555: StatsViewModel.averageAccuracyText

    @Test @MainActor
    func averageAccuracyText_value() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.accuracy = 85.5
        #expect(vm.averageAccuracyText == "85%")
    }

    @Test @MainActor
    func averageAccuracyText_zero() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.accuracy = 0
        #expect(vm.averageAccuracyText == "0%")
    }

    // MARK: - logic-556: ResultsViewModel.scoreBreakdownText

    @Test @MainActor
    func scoreBreakdownText() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let text = vm.scoreBreakdownText
        #expect(text.contains("pts"))
    }

    // MARK: - logic-557: GameSession.isHalfwayDone

    @Test
    func isHalfwayDone_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isHalfwayDone == false)
    }

    @Test
    func isHalfwayDone_pastHalf() {
        var session = GameSession(difficulty: .easy)
        // easy has 60s, so halfway is 30s elapsed (30s remaining)
        for _ in 0..<31 { session.tick() }
        #expect(session.isHalfwayDone == true)
    }

    // MARK: - logic-558: Operation.isPairOperation

    @Test
    func isPairOperation_add() {
        #expect(Operation.add.isPairOperation == true)
    }

    @Test
    func isPairOperation_subtract() {
        #expect(Operation.subtract.isPairOperation == false)
    }

    @Test
    func isPairOperation_multiply() {
        #expect(Operation.multiply.isPairOperation == true)
    }
}
