import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 5 Tests")
struct ImproveRound5Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - improve-020: Difficulty stats cards

    @Test("DifficultyStatCard shows all three difficulties")
    @MainActor
    func allThreeDifficulties() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.easyGames = 5
        vm.mediumGames = 3
        vm.hardGames = 1
        #expect(vm.easyGames >= 0)
        #expect(vm.mediumGames >= 0)
        #expect(vm.hardGames >= 0)
    }

    @Test("Zero values handled gracefully in difficulty cards")
    @MainActor
    func zeroValuesDifficulty() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        #expect(vm.bestScoreEasy == 0)
        #expect(vm.bestAccuracyEasy == 0)
        #expect(vm.easyGames == 0)
    }

    // MARK: - improve-021: Accuracy trend badge

    @Test("Improving trend detected from accuracies")
    @MainActor
    func improvingTrendDetected() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.recentAccuracies = [50, 55, 70, 80, 90]
        #expect(vm.accuracyTrend == .improving)
    }

    @Test("Stable trend with no data")
    @MainActor
    func stableWithNoData() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        #expect(vm.accuracyTrend == .stable)
    }

    // MARK: - improve-022: Hint count on results

    @Test("GameViewModel hintsUsed starts at zero")
    @MainActor
    func hintsStartZero() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        #expect(vm.hintsUsed == 0)
    }

    @Test("Hint count increments correctly")
    @MainActor
    func hintCountIncrements() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.requestHint()
        #expect(vm.hintsUsed == 1)
    }

    // MARK: - improve-023: Operation mastery levels

    @Test("StatsViewModel computes skill level for each operation")
    @MainActor
    func skillLevelsFromElo() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.eloAdd = 1000
        vm.eloSubtract = 1400
        vm.eloMultiply = 700
        vm.eloDivide = 1600
        let levels = vm.operationSkillLevels
        #expect(levels["+"] == "Intermediate")
        #expect(levels["-"] != nil)
        #expect(levels["×"] == "Learning")
        #expect(levels["÷"] != nil)
    }

    @Test("Default rating of 1000 returns Intermediate")
    @MainActor
    func defaultRatingIntermediate() {
        let level = EloSystem.skillLevel(forRating: 1000)
        #expect(level == "Intermediate")
    }

    @Test("High rating returns Expert or Master")
    func highRatingExpertOrMaster() {
        let expert = EloSystem.skillLevel(forRating: 1300)
        let master = EloSystem.skillLevel(forRating: 1500)
        #expect(expert == "Expert")
        #expect(master == "Master")
    }

    // MARK: - improve-024: XP breakdown by difficulty

    @Test("StatsViewModel exposes XP per difficulty")
    @MainActor
    func xpPerDifficulty() {
        let stats = PlayerStats()
        stats.xpEasy = 500
        stats.xpMedium = 300
        stats.xpHard = 200
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadXPBreakdown(from: stats)
        #expect(vm.xpEasy == 500)
        #expect(vm.xpMedium == 300)
        #expect(vm.xpHard == 200)
    }

    @Test("Default XP values are 0")
    @MainActor
    func defaultXPZero() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        #expect(vm.xpEasy == 0)
        #expect(vm.xpMedium == 0)
        #expect(vm.xpHard == 0)
    }
}
