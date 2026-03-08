import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 111 Tests")
struct Batch111Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-634: HomeViewModel.maxOperandText

    @Test @MainActor
    func maxOperandText() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .easy
        #expect(vm.maxOperandText == "Up to 10")
    }

    // MARK: - logic-635: ResultsViewModel.accuracyStatusText

    @Test @MainActor
    func accuracyStatusText_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyStatusText.contains("Excellent"))
    }

    @Test @MainActor
    func accuracyStatusText_low() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyStatusText.contains("Needs work"))
    }

    // MARK: - logic-636: ResultsViewModel.scoreComparisonEmoji

    @Test @MainActor
    func scoreComparisonEmoji_newBest() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 50)
        let vm = ResultsViewModel(session: session, previousBestScore: 10)
        #expect(vm.scoreComparisonEmoji == "🏆")
    }

    @Test @MainActor
    func scoreComparisonEmoji_belowBest() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 100)
        #expect(vm.scoreComparisonEmoji == "⬇️")
    }

    // MARK: - logic-637: GameSession.currentStreakText

    @Test
    func currentStreakText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.currentStreakText == "5")
    }

    // MARK: - logic-638: GameSession.hasBonus

    @Test
    func hasBonus_no() {
        let session = GameSession(difficulty: .easy)
        #expect(session.hasBonus == false)
    }

    @Test
    func hasBonus_yes() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        #expect(session.hasBonus == true)
    }
}
