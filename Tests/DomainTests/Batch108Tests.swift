import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 108 Tests")
struct Batch108Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-619: HomeViewModel.canPlayDailyChallenge

    @Test @MainActor
    func canPlayDailyChallenge_yes() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyChallengeCompleted = false
        #expect(vm.canPlayDailyChallenge == true)
    }

    @Test @MainActor
    func canPlayDailyChallenge_no() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyChallengeCompleted = true
        #expect(vm.canPlayDailyChallenge == false)
    }

    // MARK: - logic-620: StatsViewModel.hasPlayedGames

    @Test @MainActor
    func hasPlayedGames() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.gamesPlayed = 0
        #expect(vm.hasPlayedGames == false)
        vm.gamesPlayed = 3
        #expect(vm.hasPlayedGames == true)
    }

    // MARK: - logic-621: ResultsViewModel.correctCountLabel

    @Test @MainActor
    func correctCountLabel() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.correctCountLabel.contains("1"))
    }

    // MARK: - logic-622: GameSession.timeRemainingText

    @Test
    func timeRemainingText_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.timeRemainingText == "60s remaining")
    }

    @Test
    func timeRemainingText_partial() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() }
        #expect(session.timeRemainingText == "40s remaining")
    }

    // MARK: - logic-623: ResultsViewModel.wrongCountLabel

    @Test @MainActor
    func wrongCountLabel() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.wrongCountLabel.contains("1"))
    }
}
