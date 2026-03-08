import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 102 Tests")
struct Batch102Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-589: HomeViewModel.difficultyPointsText

    @Test @MainActor
    func difficultyPointsText_easy() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .easy
        #expect(vm.difficultyPointsText == "10 pts")
    }

    @Test @MainActor
    func difficultyPointsText_hard() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .hard
        #expect(vm.difficultyPointsText == "30 pts")
    }

    // MARK: - logic-590: StatsViewModel.xpPercentText

    @Test @MainActor
    func xpPercentText() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.totalXP = 50
        let text = vm.xpPercentText
        #expect(text.contains("%"))
    }

    // MARK: - logic-591: ResultsViewModel.correctRatioText

    @Test @MainActor
    func correctRatioText() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.correctRatioText == "1/2")
    }

    // MARK: - logic-592: GameSession.scoringRate

    @Test
    func scoringRate_noTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoringRate == 0)
    }

    @Test
    func scoringRate_withTime() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        session.recordAnswer(correct: true, bonusPoints: 10)
        #expect(session.scoringRate > 0)
    }

    // MARK: - logic-593: Achievement.categoryEmoji

    @Test
    func categoryEmoji() {
        #expect(Achievement.Category.streak.emoji == "🔥")
        #expect(Achievement.Category.games.emoji == "🎮")
        #expect(Achievement.Category.score.emoji == "🏆")
        #expect(Achievement.Category.mastery.emoji == "🎓")
    }
}
