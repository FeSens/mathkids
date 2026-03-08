import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 88 Tests - logic-519 to logic-523")
struct Batch88Tests {

    // MARK: - logic-519: HomeViewModel.bestScoreText

    @MainActor
    @Test("bestScoreText includes score and pts")
    func bestScoreTextFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.bestScore = 250
        #expect(vm.bestScoreText.contains("250"))
        #expect(vm.bestScoreText.contains("pts"))
    }

    // MARK: - logic-520: StatsViewModel.hasSignificantData

    @MainActor
    @Test("hasSignificantData false when 0 games")
    func hasSignificantDataFalse() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.gamesPlayed = 0
        #expect(vm.hasSignificantData == false)
    }

    @MainActor
    @Test("hasSignificantData true when 3+ games")
    func hasSignificantDataTrue() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.gamesPlayed = 3
        #expect(vm.hasSignificantData == true)
    }

    // MARK: - logic-521: ResultsViewModel.correctAnswerLabel

    @MainActor
    @Test("correctAnswerLabel includes count and correct")
    func correctAnswerLabelFormat() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.correctAnswerLabel.contains("2"))
        #expect(vm.correctAnswerLabel.contains("correct"))
    }

    // MARK: - logic-522: MathProblem.isSquareNumber

    @Test("isSquareNumber true for 2+2=4")
    func isSquareNumberFour() {
        let problem = MathProblem(operand1: 2, operand2: 2, operation: .add)
        #expect(problem.isSquareNumber == true)
    }

    @Test("isSquareNumber true for 3x3=9")
    func isSquareNumberNine() {
        let problem = MathProblem(operand1: 3, operand2: 3, operation: .multiply)
        #expect(problem.isSquareNumber == true)
    }

    @Test("isSquareNumber false for 2+3=5")
    func isSquareNumberFalse() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.isSquareNumber == false)
    }

    // MARK: - logic-523: GameSession.averagePointsPerCorrect

    @Test("averagePointsPerCorrect returns correct average")
    func averagePointsPerCorrectValue() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.averagePointsPerCorrect > 0)
    }

    @Test("averagePointsPerCorrect returns 0 when no correct")
    func averagePointsPerCorrectZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.averagePointsPerCorrect == 0)
    }
}
