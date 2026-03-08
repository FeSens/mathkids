import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 112 Tests")
struct Batch112Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-639: HomeViewModel.hasDailyStreak

    @Test @MainActor
    func hasDailyStreak() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyStreak = 0
        #expect(vm.hasDailyStreak == false)
        vm.dailyStreak = 3
        #expect(vm.hasDailyStreak == true)
    }

    // MARK: - logic-640: ResultsViewModel.gameSummaryText

    @Test @MainActor
    func gameSummaryText() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let summary = vm.gameSummaryText
        #expect(summary.contains("pts"))
        #expect(summary.contains("%"))
    }

    // MARK: - logic-641: ResultsViewModel.wasHighAccuracy

    @Test @MainActor
    func wasHighAccuracy_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.wasHighAccuracy == true)
    }

    @Test @MainActor
    func wasHighAccuracy_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.wasHighAccuracy == false)
    }

    // MARK: - logic-642: GameSession.bonusPointsText

    @Test
    func bonusPointsText() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 15)
        #expect(session.bonusPointsText == "15 bonus pts")
    }

    // MARK: - logic-643: GameSession.answeredRatio

    @Test
    func answeredRatio() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        #expect(session.answeredRatio == "2/3")
    }
}
