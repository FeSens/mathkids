import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 3 Tests")
struct ImproveRound3Tests {

    // MARK: - improve-010: Elo delta display UI components

    @Test("EloDeltaView shows positive delta with up arrow")
    @MainActor
    func positiveDelta() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: history, previouslyUnlockedIds: [])
        let deltas = vm.eloDeltas
        #expect(deltas[.add] != nil)
        #expect(deltas[.add]! > 0)
    }

    @Test("Elo delta format string shows plus sign for positive")
    func deltaFormatPositive() {
        let formatted = EloDeltaView.formatDelta(12.5)
        #expect(formatted == "+13")
    }

    @Test("Elo delta format string shows minus sign for negative")
    func deltaFormatNegative() {
        let formatted = EloDeltaView.formatDelta(-8.3)
        #expect(formatted == "-8")
    }

    // MARK: - improve-011: Per-operation best streaks in stats

    @Test("StatsViewModel exposes per-operation best streaks")
    @MainActor
    func perOperationBestStreaks() {
        let stats = PlayerStats()
        stats.bestStreakAdd = 5
        stats.bestStreakSubtract = 3
        stats.bestStreakMultiply = 8
        stats.bestStreakDivide = 0

        let vm = StatsViewModel(statsService: StatsService(modelContainer: try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))))
        vm.loadBestStreaks(from: stats)
        #expect(vm.bestStreakAdd == 5)
        #expect(vm.bestStreakSubtract == 3)
        #expect(vm.bestStreakMultiply == 8)
        #expect(vm.bestStreakDivide == 0)
    }

    @Test("All four operations have streak values")
    @MainActor
    func allFourStreaks() {
        let stats = PlayerStats()
        let vm = StatsViewModel(statsService: StatsService(modelContainer: try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))))
        vm.loadBestStreaks(from: stats)
        // All should be 0 by default
        #expect(vm.bestStreakAdd == 0)
        #expect(vm.bestStreakSubtract == 0)
        #expect(vm.bestStreakMultiply == 0)
        #expect(vm.bestStreakDivide == 0)
    }

    // MARK: - improve-012: Perfect game counter

    @Test("StatsViewModel shows perfectGameCount from PlayerStats")
    @MainActor
    func perfectGameCount() {
        let stats = PlayerStats()
        stats.perfectGameCount = 7
        let vm = StatsViewModel(statsService: StatsService(modelContainer: try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))))
        vm.loadPerfectGameCount(from: stats)
        #expect(vm.perfectGameCount == 7)
    }

    @Test("ResultsViewModel isPerfectScore returns true for 100% accuracy")
    @MainActor
    func perfectScore() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 0)
        session.recordAnswer(correct: true, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.isPerfectScore == true)
    }

    @Test("Perfect game count is non-negative integer")
    @MainActor
    func perfectGameNonNegative() {
        let stats = PlayerStats()
        let vm = StatsViewModel(statsService: StatsService(modelContainer: try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))))
        vm.loadPerfectGameCount(from: stats)
        #expect(vm.perfectGameCount >= 0)
    }

    // MARK: - improve-013: Accuracy comparison UI

    @Test("AccuracyComparisonView renders with positive delta")
    @MainActor
    func accuracyComparisonPositive() {
        let stats = PlayerStats()
        stats.totalSolved = 100
        stats.totalCorrect = 70
        var session = GameSession(difficulty: .easy)
        for i in 0..<10 { session.recordAnswer(correct: i < 9, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: stats, problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.accuracyVsAverage > 0)
        #expect(vm.accuracyComparisonText != nil)
        #expect(vm.accuracyComparisonText!.contains("above"))
    }

    @Test("AccuracyComparisonView renders with negative delta")
    @MainActor
    func accuracyComparisonNegative() {
        let stats = PlayerStats()
        stats.totalSolved = 100
        stats.totalCorrect = 90
        var session = GameSession(difficulty: .easy)
        for i in 0..<10 { session.recordAnswer(correct: i < 5, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: stats, problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.accuracyVsAverage < 0)
        #expect(vm.accuracyComparisonText != nil)
        #expect(vm.accuracyComparisonText!.contains("below"))
    }

    @Test("Zero delta shows neutral state")
    @MainActor
    func accuracyComparisonZero() {
        let vm = ResultsViewModel(session: GameSession(difficulty: .easy), previousBestScore: 0, stats: nil, problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.accuracyVsAverage == 0)
    }

    // MARK: - improve-014: Speed stats per operation

    @Test("SpeedBreakdownView renders time per operation")
    @MainActor
    func speedBreakdown() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 2.0
        var p2 = AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 2, operation: .subtract), userAnswer: 4)
        p2.timeTaken = 4.0
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2], previouslyUnlockedIds: [])
        let times = vm.averageTimePerOperation
        #expect(times[.add] == 2.0)
        #expect(times[.subtract] == 4.0)
    }

    @Test("Slowest operation is highlighted")
    @MainActor
    func slowestHighlighted() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 2.0
        var p2 = AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 2, operation: .subtract), userAnswer: 4)
        p2.timeTaken = 5.0
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2], previouslyUnlockedIds: [])
        #expect(vm.slowestOperationThisGame == .subtract)
    }

    @Test("Operations with no time data are excluded")
    @MainActor
    func noTimeDataExcluded() {
        let p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        // No timeTaken set
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1], previouslyUnlockedIds: [])
        let times = vm.averageTimePerOperation
        #expect(times.isEmpty)
    }
}
