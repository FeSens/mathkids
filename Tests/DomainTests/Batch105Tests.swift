import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 105 Tests")
struct Batch105Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - logic-604: HomeViewModel.levelProgressPercent

    @Test @MainActor
    func levelProgressPercent() {
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.levelProgress = 0.75
        #expect(vm.levelProgressPercent == 75)
    }

    // MARK: - logic-605: StatsViewModel.correctPercentageText

    @Test @MainActor
    func correctPercentageText() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.accuracy = 90
        #expect(vm.correctPercentageText == "90% correct")
    }

    // MARK: - logic-606: ResultsViewModel.timeBonusLabel

    @Test @MainActor
    func timeBonusLabel() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let label = vm.timeBonusLabel
        #expect(label.count > 0)
    }

    // MARK: - logic-607: GameSession.isHighScore

    @Test
    func isHighScore_low() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isHighScore == false)
    }

    @Test
    func isHighScore_high() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<15 { session.recordAnswer(correct: true, bonusPoints: 10) }
        #expect(session.isHighScore == true)
    }

    // MARK: - logic-608: MathProblem.isChallengingProblem

    @Test
    func isChallengingProblem_yes() {
        let p = MathProblem(operand1: 12, operand2: 8, operation: .multiply)
        #expect(p.isChallengingProblem == true)
    }

    @Test
    func isChallengingProblem_no() {
        let p = MathProblem(operand1: 3, operand2: 2, operation: .add)
        #expect(p.isChallengingProblem == false)
    }
}
