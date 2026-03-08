import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 110 Tests")
struct Batch110Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-629: HomeViewModel.difficultyStarRating

    @Test @MainActor
    func difficultyStarRating() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.selectedDifficulty = .medium
        #expect(vm.difficultyStarRating == "⭐⭐")
    }

    // MARK: - logic-630: ResultsViewModel.totalAnsweredLabel

    @Test @MainActor
    func totalAnsweredLabel() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.totalAnsweredLabel == "2 answered")
    }

    // MARK: - logic-631: ResultsViewModel.scorePerQuestion

    @Test @MainActor
    func scorePerQuestion_noAnswers() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.scorePerQuestion == 0)
    }

    @Test @MainActor
    func scorePerQuestion_withAnswers() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 10)
        session.recordAnswer(correct: true, bonusPoints: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.scorePerQuestion > 0)
    }

    // MARK: - logic-632: GameSession.difficultyName

    @Test
    func difficultyName() {
        let session = GameSession(difficulty: .easy)
        #expect(session.difficultyName == "Easy")
    }

    // MARK: - logic-633: GameSession.isFinishedWithStreak

    @Test
    func isFinishedWithStreak_notFinished() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isFinishedWithStreak == false)
    }

    @Test
    func isFinishedWithStreak_finishedWithStreak() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        for _ in 0..<60 { session.tick() } // finish the game
        #expect(session.isFinishedWithStreak == true)
    }
}
