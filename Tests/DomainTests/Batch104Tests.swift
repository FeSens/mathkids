import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 104 Tests")
struct Batch104Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-599: HomeViewModel.showDailyChallengeReset

    @Test @MainActor
    func showDailyChallengeReset_completed() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyChallengeCompleted = true
        #expect(vm.showDailyChallengeReset == true)
    }

    @Test @MainActor
    func showDailyChallengeReset_notCompleted() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyChallengeCompleted = false
        #expect(vm.showDailyChallengeReset == false)
    }

    // MARK: - logic-600: StatsViewModel.totalWrongCount

    @Test @MainActor
    func totalWrongCount() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.totalSolved = 50
        vm.totalCorrect = 35
        #expect(vm.totalWrongCount == 15)
    }

    // MARK: - logic-601: ResultsViewModel.wasFirstGame

    @Test @MainActor
    func wasFirstGame_true() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.wasFirstGame == true)
    }

    @Test @MainActor
    func wasFirstGame_false() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 50)
        #expect(vm.wasFirstGame == false)
    }

    // MARK: - logic-602: GameSession.streakText

    @Test
    func streakText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.streakText == "3 streak")
    }

    // MARK: - logic-603: MathProblem.isSimpleProblem

    @Test
    func isSimpleProblem_simple() {
        let p = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(p.isSimpleProblem == true)
    }

    @Test
    func isSimpleProblem_notSimple() {
        let p = MathProblem(operand1: 12, operand2: 8, operation: .multiply)
        #expect(p.isSimpleProblem == false)
    }
}
