import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 12 Tests")
struct ImproveRound12Tests {

    // MARK: - improve-055: Average problems per game

    @Test("averageProblemsPerGame returns correct average")
    @MainActor
    func avgProblemsPerGame() {
        let vm = makeStatsVM()
        vm.totalSolved = 50
        vm.gamesPlayed = 10
        #expect(vm.averageProblemsPerGame == 5.0)
    }

    @Test("Zero games returns 0")
    @MainActor
    func avgProblemsZeroGames() {
        let vm = makeStatsVM()
        vm.totalSolved = 0
        vm.gamesPlayed = 0
        #expect(vm.averageProblemsPerGame == 0)
    }

    @Test("averageProblemsPerGameText formats correctly")
    @MainActor
    func avgProblemsText() {
        let vm = makeStatsVM()
        vm.totalSolved = 25
        vm.gamesPlayed = 10
        #expect(vm.averageProblemsPerGameText == "2.5 per game")
    }

    // MARK: - improve-056: Correct ratio text

    @Test("correctRatioText shows correct/total format")
    @MainActor
    func correctRatio() {
        let vm = makeStatsVM()
        vm.totalCorrect = 45
        vm.totalSolved = 50
        #expect(vm.correctRatioText == "45/50 correct")
    }

    @Test("Zero solved shows 0/0")
    @MainActor
    func correctRatioZero() {
        let vm = makeStatsVM()
        vm.totalCorrect = 0
        vm.totalSolved = 0
        #expect(vm.correctRatioText == "0/0 correct")
    }

    // MARK: - improve-057: Answer bias analysis

    @Test("answerBias overEstimates when wrong answers higher")
    @MainActor
    func answerBiasOver() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 7), // wrong, over
            AnsweredProblem(problem: MathProblem(operand1: 3, operand2: 4, operation: .add), userAnswer: 9), // wrong, over
            AnsweredProblem(problem: MathProblem(operand1: 1, operand2: 1, operation: .add), userAnswer: 2), // correct
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.answerBias == .overEstimates)
    }

    @Test("answerBias underEstimates when wrong answers lower")
    @MainActor
    func answerBiasUnder() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 5, operand2: 5, operation: .add), userAnswer: 8), // wrong, under
            AnsweredProblem(problem: MathProblem(operand1: 4, operand2: 6, operation: .add), userAnswer: 7), // wrong, under
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.answerBias == .underEstimates)
    }

    @Test("No wrong answers returns balanced")
    @MainActor
    func answerBiasBalanced() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.answerBias == .balanced)
    }

    // MARK: - improve-058: Time pressure metric

    @Test("timeUsagePercent returns percentage of timer used")
    @MainActor
    func timeUsagePartial() {
        var session = GameSession(difficulty: .easy)
        // Easy has 60s timer. Tick 30 times to use half the time.
        for _ in 0..<30 { session.tick() }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.timeUsagePercent == 50)
    }

    @Test("Full time used returns 100")
    @MainActor
    func timeUsageFull() {
        var session = GameSession(difficulty: .easy)
        // Tick all 60 seconds
        for _ in 0..<60 { session.tick() }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.timeUsagePercent == 100)
    }

    @Test("No time used returns 0")
    @MainActor
    func timeUsageNone() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.timeUsagePercent == 0)
    }

    @Test("timeUsageText returns formatted string")
    @MainActor
    func timeUsageTextFormatted() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.timeUsageText.contains("50"))
    }

    // MARK: - improve-059: Elo gap

    @Test("eloGap returns difference between highest and lowest")
    @MainActor
    func eloGapDifference() {
        let vm = makeStatsVM()
        vm.eloAdd = 1200
        vm.eloSubtract = 1000
        vm.eloMultiply = 900
        vm.eloDivide = 1100
        #expect(vm.eloGap == 300)
    }

    @Test("All equal ratings returns 0")
    @MainActor
    func eloGapEqual() {
        let vm = makeStatsVM()
        vm.eloAdd = 1000
        vm.eloSubtract = 1000
        vm.eloMultiply = 1000
        vm.eloDivide = 1000
        #expect(vm.eloGap == 0)
    }

    @Test("eloGapText returns formatted string")
    @MainActor
    func eloGapTextFormatted() {
        let vm = makeStatsVM()
        vm.eloAdd = 1200
        vm.eloSubtract = 900
        vm.eloMultiply = 1000
        vm.eloDivide = 1000
        #expect(vm.eloGapText.contains("300"))
    }

    @Test("skillBalance returns unbalanced for large gap")
    @MainActor
    func skillBalanceUnbalanced() {
        let vm = makeStatsVM()
        vm.eloAdd = 1300
        vm.eloSubtract = 900
        vm.eloMultiply = 1000
        vm.eloDivide = 1000
        #expect(vm.skillBalance == .unbalanced)
    }

    // MARK: - Helpers

    @MainActor
    private func makeStatsVM() -> StatsViewModel {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        return StatsViewModel(statsService: service)
    }
}
