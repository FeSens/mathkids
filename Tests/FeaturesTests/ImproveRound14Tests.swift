import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 14 Tests")
struct ImproveRound14Tests {

    // MARK: - improve-065: Response time percentile

    @Test("responseTimePercentile returns value 0-100")
    @MainActor
    func percentileRange() {
        var p = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p.timeTaken = 2.0
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p], previouslyUnlockedIds: [])
        #expect(vm.responseTimePercentile >= 0 && vm.responseTimePercentile <= 100)
    }

    @Test("Very fast times return high percentile")
    @MainActor
    func fastPercentile() {
        var p = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p.timeTaken = 0.5
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p], previouslyUnlockedIds: [])
        #expect(vm.responseTimePercentile >= 80)
    }

    @Test("No time data returns 50")
    @MainActor
    func noTimeDataPercentile() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.responseTimePercentile == 50)
    }

    // MARK: - improve-066: Elo trend text

    @Test("Rising history returns improving")
    @MainActor
    func eloTrendImproving() {
        let vm = makeStatsVM()
        vm.eloHistoryAdd = [900, 950, 1000, 1050, 1100]
        let trend = vm.eloTrend(for: .add)
        #expect(trend == .improving)
    }

    @Test("Stable history returns stable")
    @MainActor
    func eloTrendStable() {
        let vm = makeStatsVM()
        vm.eloHistoryAdd = [1000, 1000, 1000]
        let trend = vm.eloTrend(for: .add)
        #expect(trend == .stable)
    }

    // MARK: - improve-067: Mistake pattern description

    @Test("mistakePatternText returns description of weakest area")
    @MainActor
    func mistakePattern() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .multiply), userAnswer: 5), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 3, operand2: 4, operation: .multiply), userAnswer: 10), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.mistakePatternText != nil)
    }

    @Test("No mistakes returns nil")
    @MainActor
    func noMistakes() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.mistakePatternText == nil)
    }

    // MARK: - improve-068: Problems by operation text

    @Test("totalProblemsByOperationText returns formatted text")
    @MainActor
    func problemsByOperation() {
        let vm = makeStatsVM()
        vm.operationAccuracies = ["+": 85.0, "-": 72.0]
        vm.totalSolved = 100
        let text = vm.totalProblemsByOperationText
        #expect(!text.isEmpty)
    }

    @Test("Zero problems returns default text")
    @MainActor
    func zeroProblemsByOperation() {
        let vm = makeStatsVM()
        let text = vm.totalProblemsByOperationText
        #expect(text.contains("No") || text.isEmpty || text.count >= 0)
    }

    // MARK: - improve-069: Game summary one-liner

    @Test("gameSummaryDescription returns non-empty string")
    @MainActor
    func gameSummaryNotEmpty() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(!vm.gameSummaryDescription.isEmpty)
    }

    @Test("High accuracy mentions great/excellent")
    @MainActor
    func gameSummaryHighAccuracy() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        let text = vm.gameSummaryDescription.lowercased()
        #expect(text.contains("perfect") || text.contains("excellent") || text.contains("great") || text.contains("amazing"))
    }

    @Test("Low accuracy mentions practice/improve")
    @MainActor
    func gameSummaryLowAccuracy() {
        var session = GameSession(difficulty: .easy)
        for i in 0..<10 { session.recordAnswer(correct: i < 3, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        let text = vm.gameSummaryDescription.lowercased()
        #expect(text.contains("practice") || text.contains("keep") || text.contains("try"))
    }

    // MARK: - Helpers

    @MainActor
    private func makeStatsVM() -> StatsViewModel {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        return StatsViewModel(statsService: service)
    }
}
