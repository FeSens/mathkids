import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 107 Tests")
struct Batch107Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-614: HomeViewModel.selectedDifficultyDescription

    @Test @MainActor
    func selectedDifficultyDescription() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .easy
        #expect(vm.selectedDifficultyDescription == DifficultyLevel.easy.challengeDescription)
    }

    // MARK: - logic-615: StatsViewModel.bestStreakDescription

    @Test @MainActor
    func bestStreakDescription_high() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.bestStreak = 10
        #expect(vm.bestStreakDescription.contains("🔥"))
        #expect(vm.bestStreakDescription.contains("10"))
    }

    @Test @MainActor
    func bestStreakDescription_low() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.bestStreak = 2
        #expect(!vm.bestStreakDescription.contains("🔥"))
    }

    // MARK: - logic-616: ResultsViewModel.gameDifficultyName

    @Test @MainActor
    func gameDifficultyName() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.gameDifficultyName == "Easy")
    }

    // MARK: - logic-617: GameSession.scoreDisplay

    @Test
    func scoreDisplay() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 10)
        #expect(session.scoreDisplay.contains("pts"))
    }

    // MARK: - logic-618: ResultsViewModel.bestStreakLabel

    @Test @MainActor
    func bestStreakLabel() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.bestStreakLabel.contains("5"))
    }
}
