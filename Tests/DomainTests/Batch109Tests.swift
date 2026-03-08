import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 109 Tests")
struct Batch109Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-624: HomeViewModel.selectedOperationCount

    @Test @MainActor
    func selectedOperationCount() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedOperations = [.add, .subtract, .multiply]
        #expect(vm.selectedOperationCount == 3)
    }

    // MARK: - logic-625: StatsViewModel.averageProblemsText

    @Test @MainActor
    func averageProblemsText() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.averageProblemsPerMinute = 5.3
        #expect(vm.averageProblemsText.contains("5.3"))
    }

    // MARK: - logic-626: ResultsViewModel.sessionTimeText

    @Test @MainActor
    func sessionTimeText() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.sessionTimeText.contains("s"))
    }

    // MARK: - logic-627: GameSession.isOnStreak

    @Test
    func isOnStreak_no() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.isOnStreak == false)
    }

    @Test
    func isOnStreak_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.isOnStreak == true)
    }

    // MARK: - logic-628: ResultsViewModel.difficultyEmoji

    @Test @MainActor
    func difficultyEmoji() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyEmoji == "🌱")
    }
}
