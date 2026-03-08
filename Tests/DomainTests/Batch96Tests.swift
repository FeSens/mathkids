import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 96 Tests")
struct Batch96Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-559: HomeViewModel.dailyStreakEmoji

    @Test @MainActor
    func dailyStreakEmoji_active() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyStreak = 3
        #expect(vm.dailyStreakEmoji == "🔥")
    }

    @Test @MainActor
    func dailyStreakEmoji_none() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyStreak = 0
        #expect(vm.dailyStreakEmoji == "❄️")
    }

    // MARK: - logic-560: StatsViewModel.problemsPerGameText

    @Test @MainActor
    func problemsPerGameText_value() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.totalSolved = 50
        vm.gamesPlayed = 5
        #expect(vm.problemsPerGameText == "10 per game")
    }

    @Test @MainActor
    func problemsPerGameText_noGames() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.totalSolved = 0
        vm.gamesPlayed = 0
        #expect(vm.problemsPerGameText == "0 per game")
    }

    // MARK: - logic-561: ResultsViewModel.answeredCountText

    @Test @MainActor
    func answeredCountText() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let text = vm.answeredCountText
        #expect(text.contains("problems"))
    }

    // MARK: - logic-562: GameSession.answeredProblemCount

    @Test
    func answeredProblemCount_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.answeredProblemCount == 0)
        #expect(session.answeredProblemCount == session.totalAnswered)
    }

    // MARK: - logic-563: Operation.shortName

    @Test
    func shortName_add() {
        #expect(Operation.add.shortName == "Add")
    }

    @Test
    func shortName_divide() {
        #expect(Operation.divide.shortName == "Div")
    }
}
