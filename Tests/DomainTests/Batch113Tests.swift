import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 113 Tests")
struct Batch113Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-644: HomeViewModel.difficultyBadge

    @Test @MainActor
    func difficultyBadge() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .easy
        #expect(vm.difficultyBadge == "🌱 Easy")
    }

    // MARK: - logic-645: ResultsViewModel.improvementNeeded

    @Test @MainActor
    func improvementNeeded_belowBest() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 100)
        #expect(vm.improvementNeeded == 100)
    }

    @Test @MainActor
    func improvementNeeded_aboveBest() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 50)
        let vm = ResultsViewModel(session: session, previousBestScore: 10)
        #expect(vm.improvementNeeded == 0)
    }

    // MARK: - logic-646: ResultsViewModel.wasLowAccuracy

    @Test @MainActor
    func wasLowAccuracy_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.wasLowAccuracy == true)
    }

    @Test @MainActor
    func wasLowAccuracy_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.wasLowAccuracy == false)
    }

    // MARK: - logic-647: GameSession+Display.scoreWithBonusText

    @Test
    func scoreWithBonusText() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        #expect(session.scoreWithBonusText.contains("bonus"))
    }

    // MARK: - logic-648: GameSession+Display.performanceSummary

    @Test
    func performanceSummary() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 10)
        session.recordAnswer(correct: false)
        let summary = session.performanceSummary
        #expect(summary.contains("1/2"))
        #expect(summary.contains("pts"))
    }
}
