import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 103 Tests")
struct Batch103Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-594: HomeViewModel.hasCompletedDailyChallenge

    @Test @MainActor
    func hasCompletedDailyChallenge() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.dailyChallengeCompleted = true
        #expect(vm.hasCompletedDailyChallenge == true)
        vm.dailyChallengeCompleted = false
        #expect(vm.hasCompletedDailyChallenge == false)
    }

    // MARK: - logic-595: StatsViewModel.averageAccuracy

    @Test @MainActor
    func averageAccuracyRounded() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.accuracy = 87.6
        #expect(vm.averageAccuracyRounded == 88)
    }

    @Test @MainActor
    func averageAccuracyRounded_exact() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.accuracy = 75.0
        #expect(vm.averageAccuracyRounded == 75)
    }

    // MARK: - logic-596: ResultsViewModel.difficultyPointsPerCorrect

    @Test @MainActor
    func difficultyPointsPerCorrect() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyPointsPerCorrect == 10)
    }

    // MARK: - logic-597: GameSession.isLowScore

    @Test
    func isLowScore_fresh() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isLowScore == true)
    }

    @Test
    func isLowScore_highScore() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true, bonusPoints: 10) }
        #expect(session.isLowScore == false)
    }

    // MARK: - logic-598: Achievement.Category.displayName

    @Test
    func categoryDisplayName() {
        #expect(Achievement.Category.streak.displayName == "Streak")
        #expect(Achievement.Category.score.displayName == "Score")
        #expect(Achievement.Category.games.displayName == "Games")
        #expect(Achievement.Category.mastery.displayName == "Mastery")
    }
}
