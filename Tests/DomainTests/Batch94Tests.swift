import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 94 Tests")
struct Batch94Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-549: HomeViewModel.selectedDifficultyEmoji

    @Test @MainActor
    func selectedDifficultyEmoji_easy() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .easy
        #expect(vm.selectedDifficultyEmoji == "🌱")
    }

    @Test @MainActor
    func selectedDifficultyEmoji_hard() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .hard
        #expect(vm.selectedDifficultyEmoji == "🔥")
    }

    // MARK: - logic-550: StatsViewModel.gamesPlayedLabel

    @Test @MainActor
    func gamesPlayedLabel_singular() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.gamesPlayed = 1
        #expect(vm.gamesPlayedLabel == "1 game")
    }

    @Test @MainActor
    func gamesPlayedLabel_plural() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.gamesPlayed = 5
        #expect(vm.gamesPlayedLabel == "5 games")
    }

    // MARK: - logic-551: ResultsViewModel.hasTimeBonus

    @Test @MainActor
    func hasTimeBonus() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.hasTimeBonus == (session.timeBonus > 0))
    }

    // MARK: - logic-552: DifficultyLevel.hasNextDifficulty

    @Test
    func hasNextDifficulty_easy() {
        #expect(DifficultyLevel.easy.hasNextDifficulty == true)
    }

    @Test
    func hasNextDifficulty_hard() {
        #expect(DifficultyLevel.hard.hasNextDifficulty == false)
    }

    // MARK: - logic-553: MathProblem.operandTotal

    @Test
    func operandTotal_positive() {
        let p = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(p.operandTotal == 10)
    }

    @Test
    func operandTotal_withNegative() {
        let p = MathProblem(operand1: -4, operand2: 6, operation: .subtract)
        #expect(p.operandTotal == 10)
    }
}
