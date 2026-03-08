import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 84 Tests - logic-499 to logic-503")
struct Batch84Tests {

    // MARK: - logic-499: HomeViewModel.difficultyDescription

    @MainActor
    @Test("difficultyDescription includes difficulty name")
    func difficultyDescriptionName() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.selectedDifficulty = .easy
        #expect(vm.difficultyDescription.contains("Easy"))
    }

    // MARK: - logic-500: StatsViewModel.accuracyDescription

    @MainActor
    @Test("accuracyDescription includes percentage and grade")
    func accuracyDescriptionFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.accuracy = 85.0
        #expect(vm.accuracyDescription.contains("85"))
        #expect(vm.accuracyDescription.contains("B"))
    }

    // MARK: - logic-501: ResultsViewModel+Analysis.streakSummaryText

    @MainActor
    @Test("streakSummaryText includes streak count")
    func streakSummaryTextCount() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let text = vm.streakSummaryText
        #expect(text.contains("streak") || text.contains("Streak"))
    }

    // MARK: - logic-502: Achievement.progressText

    @Test("progressText format is current/target")
    func progressTextFormat() {
        let stats = PlayerStats()
        let achievement = Achievement.all.first!
        let text = achievement.progressText(stats: stats)
        #expect(text.contains("/"))
    }

    @Test("progressText shows completed when unlocked")
    func progressTextCompleted() {
        let stats = PlayerStats()
        stats.gamesPlayed = 1
        let achievement = Achievement.all.first { $0.id == "first_game" }!
        let text = achievement.progressText(stats: stats)
        #expect(text.lowercased().contains("done") || text.contains("✓") || text.contains("1/1"))
    }

    // MARK: - logic-503: MathProblem.isMultiplicationTable

    @Test("isMultiplicationTable true for 3x4")
    func isMultTableTrue() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(problem.isMultiplicationTable == true)
    }

    @Test("isMultiplicationTable false for 13x4")
    func isMultTableFalseOverflow() {
        let problem = MathProblem(operand1: 13, operand2: 4, operation: .multiply)
        #expect(problem.isMultiplicationTable == false)
    }

    @Test("isMultiplicationTable false for addition")
    func isMultTableFalseWrongOp() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isMultiplicationTable == false)
    }
}
