import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 101 Tests")
struct Batch101Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-584: HomeViewModel.selectedDifficultyColor

    @Test @MainActor
    func selectedDifficultyColor_easy() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .easy
        #expect(vm.selectedDifficultyColor == "green")
    }

    @Test @MainActor
    func selectedDifficultyColor_hard() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .hard
        #expect(vm.selectedDifficultyColor == "red")
    }

    // MARK: - logic-585: StatsViewModel.accuracyTrendEmoji

    @Test @MainActor
    func accuracyTrendEmoji_stable() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        #expect(vm.accuracyTrendEmoji == "➡️")
    }

    // MARK: - logic-586: ResultsViewModel.totalPointsText

    @Test @MainActor
    func totalPointsText() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.totalPointsText.contains("pts"))
    }

    // MARK: - logic-587: GameSession.isFirstHalf

    @Test
    func isFirstHalf_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isFirstHalf == true)
    }

    @Test
    func isFirstHalf_pastHalf() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<35 { session.tick() }
        #expect(session.isFirstHalf == false)
    }

    // MARK: - logic-588: Achievement.isRareAchievement

    @Test
    func isRareAchievement() {
        let rare = Achievement.all.first { $0.id == "easy_mastery" }
        let common = Achievement.all.first { $0.id == "first_game" }
        if let rare { #expect(rare.isRareAchievement == true) }
        if let common { #expect(common.isRareAchievement == false) }
    }
}
