import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 4 Tests")
struct ImproveRound4Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - improve-015: Per-difficulty accuracy in stats

    @Test("StatsViewModel exposes per-difficulty accuracy values")
    @MainActor
    func perDifficultyAccuracy() {
        let stats = PlayerStats()
        stats.bestAccuracyEasy = 95.0
        stats.bestAccuracyMedium = 80.0
        stats.bestAccuracyHard = 65.0
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadDifficultyAccuracy(from: stats)
        #expect(vm.bestAccuracyEasy == 95.0)
        #expect(vm.bestAccuracyMedium == 80.0)
        #expect(vm.bestAccuracyHard == 65.0)
    }

    @Test("Zero games shows no accuracy")
    @MainActor
    func zeroDifficultyAccuracy() {
        let stats = PlayerStats()
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadDifficultyAccuracy(from: stats)
        #expect(vm.bestAccuracyEasy == 0)
        #expect(vm.bestAccuracyMedium == 0)
        #expect(vm.bestAccuracyHard == 0)
    }

    // MARK: - improve-016: Best score per difficulty

    @Test("StatsViewModel exposes best scores per difficulty")
    @MainActor
    func bestScoresPerDifficulty() {
        let stats = PlayerStats()
        stats.bestScoreEasy = 150
        stats.bestScoreMedium = 200
        stats.bestScoreHard = 250
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadBestScores(from: stats)
        #expect(vm.bestScoreEasy == 150)
        #expect(vm.bestScoreMedium == 200)
        #expect(vm.bestScoreHard == 250)
    }

    @Test("Default best scores are 0")
    @MainActor
    func defaultBestScores() {
        let stats = PlayerStats()
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadBestScores(from: stats)
        #expect(vm.bestScoreEasy == 0)
        #expect(vm.bestScoreMedium == 0)
        #expect(vm.bestScoreHard == 0)
    }

    // MARK: - improve-017: Hint usage tracking

    @Test("GameViewModel tracks hintsUsed count")
    @MainActor
    func hintsUsedTracking() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        #expect(vm.hintsUsed == 0)
    }

    @Test("Requesting a hint increments the counter")
    @MainActor
    func hintIncrementsCounter() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.requestHint()
        #expect(vm.hintsUsed == 1)
        // Requesting hint again on same problem just shows next step, doesn't increment
        vm.requestHint()
        #expect(vm.hintsUsed == 1)
    }

    // MARK: - improve-018: Problems per minute

    @Test("ResultsViewModel problemsPerMinuteText formatted correctly")
    @MainActor
    func problemsPerMinuteFormatted() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        // With no data, should show the text from problemsPerMinuteText
        #expect(vm.problemsPerMinuteText == "N/A" || vm.problemsPerMinuteText.contains("."))
    }

    @Test("Zero time returns N/A for problems per minute")
    @MainActor
    func zeroTimePPM() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.problemsPerMinuteText == "N/A")
    }

    // MARK: - improve-019: Accuracy trend on home screen

    @Test("HomeViewModel exposes recentAccuracies from PlayerStats")
    @MainActor
    func homeRecentAccuracies() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        // Initially empty
        #expect(vm.recentAccuracies.isEmpty)
    }

    @Test("Trend computed from recent accuracies")
    @MainActor
    func trendFromAccuracies() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.recentAccuracies = [60, 70, 80, 90]
        #expect(vm.accuracyTrend == .improving)
    }

    @Test("Empty accuracies returns stable trend")
    @MainActor
    func emptyTrendStable() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.recentAccuracies = []
        #expect(vm.accuracyTrend == .stable)
    }
}
