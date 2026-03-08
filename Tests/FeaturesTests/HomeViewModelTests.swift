import Testing
import Foundation
@testable import MathKids

@Suite("HomeViewModel Tests")
struct HomeViewModelTests {
    @Test("Selected operations defaults to all")
    @MainActor
    func defaultOperations() {
        // Clear saved operations for clean test
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        #expect(vm.selectedOperations.count == Operation.allCases.count)
    }

    @Test("Toggle operation removes it when more than one selected")
    @MainActor
    func toggleRemovesOperation() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.toggleOperation(.divide)
        #expect(!vm.selectedOperations.contains(.divide))
        #expect(vm.selectedOperations.count == 3)
    }

    @Test("Cannot deselect last operation")
    @MainActor
    func cannotDeselectLast() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        // Remove all but one
        vm.toggleOperation(.subtract)
        vm.toggleOperation(.multiply)
        vm.toggleOperation(.divide)
        #expect(vm.selectedOperations.count == 1)
        #expect(vm.selectedOperations.contains(.add))
        // Try to remove last — should stay
        vm.toggleOperation(.add)
        #expect(vm.selectedOperations.count == 1)
        #expect(vm.selectedOperations.contains(.add))
    }

    @Test("Toggle operation adds it back")
    @MainActor
    func toggleAddsBack() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.toggleOperation(.multiply)
        #expect(!vm.selectedOperations.contains(.multiply))
        vm.toggleOperation(.multiply)
        #expect(vm.selectedOperations.contains(.multiply))
    }

    @Test("Level progress loads from stats")
    @MainActor
    func levelProgressLoads() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.loadStats()
        #expect(vm.currentLevel >= 1)
        #expect(!vm.levelName.isEmpty)
        #expect(vm.levelProgress >= 0 && vm.levelProgress <= 1)
    }

    // MARK: - Greeting (ui-121)

    @Test("Greeting returns a valid greeting string")
    @MainActor
    func greetingReturnsString() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        let greeting = vm.greeting
        let validGreetings = ["Good Morning!", "Good Afternoon!", "Good Evening!"]
        #expect(validGreetings.contains(greeting))
    }
    // MARK: - Recommended Difficulty (logic-237)

    @Test("New player gets easy recommendation")
    @MainActor
    func newPlayerEasyRecommendation() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.loadStats()
        #expect(vm.recommendedDifficulty == .easy)
    }

    // MARK: - Daily Greeting (logic-263)

    @Test("Greeting message is not empty")
    @MainActor
    func greetingNotEmpty() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        #expect(!vm.greetingMessage.isEmpty)
    }

    // MARK: - Quick Play (logic-283)

    @Test("Quick play selects all 4 operations")
    @MainActor
    func quickPlaySelectsAll() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.selectedOperations = [.add] // start with just one
        vm.selectAllOperations()
        #expect(vm.selectedOperations.count == 4)
        #expect(vm.selectedOperations == Set(Operation.allCases))
    }

    // MARK: - Quick Stats Summary (logic-303)

    @Test("Quick stats includes total solved")
    @MainActor
    func quickStatsIncludesSolved() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.totalSolved = 42
        vm.currentLevel = 3
        #expect(vm.quickStatsSummary.contains("42"))
    }

    @Test("Quick stats includes level info")
    @MainActor
    func quickStatsIncludesLevel() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.totalSolved = 10
        vm.currentLevel = 3
        #expect(vm.quickStatsSummary.contains("3"))
    }

    @Test("Quick stats returns beginner message when no games")
    @MainActor
    func quickStatsBeginnerMessage() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.totalSolved = 0
        vm.currentLevel = 1
        #expect(vm.quickStatsSummary.lowercased().contains("start"))
    }

    // MARK: - Daily Challenge Status Text (logic-318)

    @Test("Shows available when not completed")
    @MainActor
    func dailyChallengeAvailable() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.dailyChallengeCompleted = false
        #expect(vm.dailyChallengeStatusText.lowercased().contains("available") || vm.dailyChallengeStatusText.lowercased().contains("ready"))
    }

    @Test("Shows completed when done")
    @MainActor
    func dailyChallengeCompleted() {
        UserDefaults.standard.removeObject(forKey: "selectedOperations")
        let statsService = StatsService(modelContainer: try! createTestContainer())
        let vm = HomeViewModel(statsService: statsService)
        vm.dailyChallengeCompleted = true
        #expect(vm.dailyChallengeStatusText.lowercased().contains("completed") || vm.dailyChallengeStatusText.lowercased().contains("done"))
    }
}

import SwiftData

@MainActor
private func createTestContainer() throws -> ModelContainer {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    return try ModelContainer(for: PlayerStats.self, configurations: config)
}
