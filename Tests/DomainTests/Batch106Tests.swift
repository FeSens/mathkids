import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 106 Tests")
struct Batch106Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-609: HomeViewModel.dailyChallengeBestTimeText

    @Test @MainActor
    func dailyChallengeBestTimeText() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyChallengeBestTime = 45
        #expect(vm.dailyChallengeBestTimeText == "45s")
    }

    // MARK: - logic-610: StatsViewModel.streakStatusEmoji

    @Test @MainActor
    func streakStatusEmoji_active() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyStreak = 5
        #expect(vm.streakStatusEmoji == "🔥")
    }

    @Test @MainActor
    func streakStatusEmoji_none() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyStreak = 0
        #expect(vm.streakStatusEmoji == "❄️")
    }

    // MARK: - logic-611: ResultsViewModel.baseScoreText

    @Test @MainActor
    func baseScoreText() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.baseScoreText.contains("pts"))
    }

    // MARK: - logic-612: GameSession.correctAnswerCount

    @Test
    func correctAnswerCount() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        #expect(session.correctAnswerCount == 2)
    }

    // MARK: - logic-613: MathProblem.operationEmoji

    @Test
    func operationEmoji_add() {
        let p = MathProblem(operand1: 1, operand2: 2, operation: .add)
        #expect(p.operationEmoji == "➕")
    }

    @Test
    func operationEmoji_multiply() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(p.operationEmoji == "✖️")
    }
}
