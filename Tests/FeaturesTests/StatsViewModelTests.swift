import Testing
import SwiftData
@testable import MathKids

@MainActor
@Suite("StatsViewModel Tests")
struct StatsViewModelTests {

    private func makeVM() -> StatsViewModel {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: PlayerStats.self, configurations: config)
        let service = StatsService(modelContainer: container)
        return StatsViewModel(statsService: service)
    }

    // MARK: - Accuracy Trend (ui-108)

    @Test("Accuracy trend is stable with no data")
    func trendStableNoData() {
        let vm = makeVM()
        #expect(vm.accuracyTrend == .stable)
    }

    @Test("Accuracy trend is stable with few data points")
    func trendStableFewPoints() {
        let vm = makeVM()
        vm.recentAccuracies = [80, 85]
        #expect(vm.accuracyTrend == .stable)
    }

    @Test("Accuracy trend is improving when recent scores are higher")
    func trendImproving() {
        let vm = makeVM()
        vm.recentAccuracies = [50, 55, 60, 70, 80, 90]
        #expect(vm.accuracyTrend == .improving)
    }

    @Test("Accuracy trend is declining when recent scores are lower")
    func trendDeclining() {
        let vm = makeVM()
        vm.recentAccuracies = [90, 85, 80, 50, 40, 30]
        #expect(vm.accuracyTrend == .declining)
    }

    // MARK: - Games Milestone

    @Test("No milestone under 10 games")
    func noMilestoneUnder10() {
        let vm = makeVM()
        vm.gamesPlayed = 5
        #expect(vm.gamesMilestone == nil)
    }

    @Test("Getting Started milestone at 10 games")
    func gettingStartedAt10() {
        let vm = makeVM()
        vm.gamesPlayed = 10
        #expect(vm.gamesMilestone == "Getting Started")
    }

    // MARK: - Formatted Time (ui-122)

    @Test("Formatted time under 60 minutes")
    func formattedTimeUnder60() {
        let vm = makeVM()
        vm.totalTimePlayedMinutes = 45
        #expect(vm.formattedTimePlayed == "45m")
    }

    @Test("Formatted time over 60 minutes")
    func formattedTimeOver60() {
        let vm = makeVM()
        vm.totalTimePlayedMinutes = 125
        #expect(vm.formattedTimePlayed == "2h 5m")
    }
}
