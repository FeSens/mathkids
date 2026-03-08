import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 89 Tests - logic-524 to logic-528")
struct Batch89Tests {

    // MARK: - logic-524: HomeViewModel.totalSolvedText

    @MainActor
    @Test("totalSolvedText includes count and solved")
    func totalSolvedTextFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.totalSolved = 42
        #expect(vm.totalSolvedText.contains("42"))
        #expect(vm.totalSolvedText.contains("solved"))
    }

    // MARK: - logic-525: StatsViewModel.bestScoreDescription

    @MainActor
    @Test("bestScoreDescription includes score and Best")
    func bestScoreDescriptionFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.bestScore = 150
        #expect(vm.bestScoreDescription.contains("150"))
        #expect(vm.bestScoreDescription.contains("Best"))
    }

    // MARK: - logic-526: ResultsViewModel.wrongAnswerLabel

    @MainActor
    @Test("wrongAnswerLabel includes count and wrong")
    func wrongAnswerLabelFormat() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.wrongAnswerLabel.contains("2"))
        #expect(vm.wrongAnswerLabel.contains("wrong"))
    }

    // MARK: - logic-527: MathProblem.isEvenResult

    @Test("isEvenResult true for 2+2=4")
    func isEvenResultTrue() {
        let problem = MathProblem(operand1: 2, operand2: 2, operation: .add)
        #expect(problem.isEvenResult == true)
    }

    @Test("isEvenResult false for 2+3=5")
    func isEvenResultFalse() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.isEvenResult == false)
    }

    // MARK: - logic-528: GameSession.isFinishedWithPerfectAccuracy

    @Test("isFinishedWithPerfectAccuracy true when finished all correct")
    func isFinishedPerfectTrue() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.endGame()
        #expect(session.isFinishedWithPerfectAccuracy == true)
    }

    @Test("isFinishedWithPerfectAccuracy false when not finished")
    func isFinishedPerfectFalseNotFinished() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.isFinishedWithPerfectAccuracy == false)
    }

    @Test("isFinishedWithPerfectAccuracy false when has wrong")
    func isFinishedPerfectFalseWrong() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.endGame()
        #expect(session.isFinishedWithPerfectAccuracy == false)
    }
}
