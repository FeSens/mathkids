import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 99 Tests")
struct Batch99Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-574: HomeViewModel.difficultyTimeLimitText

    @Test @MainActor
    func difficultyTimeLimitText_easy() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .easy
        #expect(vm.difficultyTimeLimitText == "60s")
    }

    @Test @MainActor
    func difficultyTimeLimitText_hard() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .hard
        #expect(vm.difficultyTimeLimitText == "30s")
    }

    // MARK: - logic-575: StatsViewModel.mediumGamesText

    @Test @MainActor
    func mediumGamesText() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.mediumGames = 8
        #expect(vm.mediumGamesText == "8 medium games")
    }

    // MARK: - logic-576: ResultsViewModel.accuracyEmoji

    @Test @MainActor
    func accuracyEmoji_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true, bonusPoints: 10) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyEmoji == "⭐")
    }

    @Test @MainActor
    func accuracyEmoji_low() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyEmoji == "🤔")
    }

    // MARK: - logic-577: GameSession.secondsPerAnswer

    @Test
    func secondsPerAnswer_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.secondsPerAnswer == 0)
    }

    @Test
    func secondsPerAnswer_withAnswers() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.secondsPerAnswer == 5)
    }

    // MARK: - logic-578: DifficultyLevel.progressionIndex

    @Test
    func progressionIndex() {
        #expect(DifficultyLevel.easy.progressionIndex == 1)
        #expect(DifficultyLevel.medium.progressionIndex == 2)
        #expect(DifficultyLevel.hard.progressionIndex == 3)
    }
}
