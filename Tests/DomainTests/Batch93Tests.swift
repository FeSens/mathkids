import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 93 Tests - logic-544 to logic-548")
struct Batch93Tests {

    // MARK: - logic-544: HomeViewModel.dailyChallengeButtonText

    @MainActor
    @Test("dailyChallengeButtonText shows Play when not completed")
    func dailyChallengeNotDone() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.dailyChallengeCompleted = false
        #expect(vm.dailyChallengeButtonText.contains("Play"))
    }

    @MainActor
    @Test("dailyChallengeButtonText shows Completed when done")
    func dailyChallengeDone() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.dailyChallengeCompleted = true
        #expect(vm.dailyChallengeButtonText.contains("Completed"))
    }

    // MARK: - logic-545: StatsViewModel.xpToNextLevelText

    @MainActor
    @Test("xpToNextLevelText includes XP amount")
    func xpToNextLevelTextAmount() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.totalXP = 50
        #expect(vm.xpToNextLevelText.contains("XP"))
    }

    // MARK: - logic-546: ResultsViewModel.isPerfectGame

    @MainActor
    @Test("isPerfectGame true when all correct")
    func isPerfectGameTrue() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.isPerfectGame == true)
    }

    @MainActor
    @Test("isPerfectGame false when any wrong")
    func isPerfectGameFalse() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.isPerfectGame == false)
    }

    // MARK: - logic-547: DifficultyLevel.isFirstDifficulty

    @Test("easy isFirstDifficulty true")
    func easyIsFirst() {
        #expect(DifficultyLevel.easy.isFirstDifficulty == true)
    }

    @Test("medium isFirstDifficulty false")
    func mediumIsFirst() {
        #expect(DifficultyLevel.medium.isFirstDifficulty == false)
    }

    @Test("hard isFirstDifficulty false")
    func hardIsFirst() {
        #expect(DifficultyLevel.hard.isFirstDifficulty == false)
    }

    // MARK: - logic-548: MathProblem.answerAbsoluteValue

    @Test("answerAbsoluteValue positive stays positive")
    func answerAbsPositive() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.answerAbsoluteValue == 8)
    }

    @Test("answerAbsoluteValue negative becomes positive")
    func answerAbsNegative() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .subtract)
        #expect(problem.answerAbsoluteValue == 2)
    }
}
