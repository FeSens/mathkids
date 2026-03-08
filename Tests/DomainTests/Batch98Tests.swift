import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 98 Tests")
struct Batch98Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-569: HomeViewModel.totalXPText

    @Test @MainActor
    func totalXPText() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.totalXP = 1500
        #expect(vm.totalXPText == "1500 XP")
    }

    // MARK: - logic-570: StatsViewModel.easyGamesText

    @Test @MainActor
    func easyGamesText() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.easyGames = 12
        #expect(vm.easyGamesText == "12 easy games")
    }

    // MARK: - logic-571: ResultsViewModel.isNewRecord

    @Test @MainActor
    func isNewRecord_true() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.isNewRecord == true)
    }

    @Test @MainActor
    func isNewRecord_false() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 100)
        #expect(vm.isNewRecord == false)
    }

    // MARK: - logic-572: GameSession.timeElapsedPercentage

    @Test
    func timeElapsedPercentage_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.timeElapsedPercentage == 0)
    }

    @Test
    func timeElapsedPercentage_halfway() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.timeElapsedPercentage == 50)
    }

    // MARK: - logic-573: DifficultyLevel.isMiddleDifficulty

    @Test
    func isMiddleDifficulty() {
        #expect(DifficultyLevel.medium.isMiddleDifficulty == true)
        #expect(DifficultyLevel.easy.isMiddleDifficulty == false)
        #expect(DifficultyLevel.hard.isMiddleDifficulty == false)
    }
}
