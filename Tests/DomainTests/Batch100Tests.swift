import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 100 Tests")
struct Batch100Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-579: HomeViewModel.operationCountLabel

    @Test @MainActor
    func operationCountLabel() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedOperations = [.add, .subtract]
        #expect(vm.operationCountLabel == "2 operations selected")
    }

    // MARK: - logic-580: StatsViewModel.hardGamesText

    @Test @MainActor
    func hardGamesText() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.hardGames = 5
        #expect(vm.hardGamesText == "5 hard games")
    }

    // MARK: - logic-581: ResultsViewModel.streakEmoji

    @Test @MainActor
    func streakEmoji_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.streakEmoji == "🔥")
    }

    @Test @MainActor
    func streakEmoji_low() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.streakEmoji == "")
    }

    // MARK: - logic-582: GameSession.isAlmostDone

    @Test
    func isAlmostDone_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isAlmostDone == false)
    }

    @Test
    func isAlmostDone_nearEnd() {
        var session = GameSession(difficulty: .easy)
        // 60s total, tick 55 times to leave 5s
        for _ in 0..<55 { session.tick() }
        #expect(session.isAlmostDone == true)
    }

    // MARK: - logic-583: DifficultyLevel.targetAccuracy

    @Test
    func targetAccuracy() {
        #expect(DifficultyLevel.easy.targetAccuracy == 70)
        #expect(DifficultyLevel.medium.targetAccuracy == 80)
        #expect(DifficultyLevel.hard.targetAccuracy == 90)
    }
}
