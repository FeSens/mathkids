import Testing
@testable import MathKids

@MainActor
@Suite("ResultsViewModel Batch 37 Tests")
struct ResultsViewModelBatch37Tests {

    private func makeSession(correct: Int, total: Int, difficulty: DifficultyLevel = .easy) -> GameSession {
        var session = GameSession(difficulty: difficulty)
        for i in 0..<total {
            session.recordAnswer(correct: i < correct, bonusPoints: 0)
        }
        return session
    }

    // MARK: - Improvement Summary (logic-258)

    @Test("Perfect score shows celebration text")
    func improvementSummaryPerfect() {
        let session = makeSession(correct: 10, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.improvementSummary.lowercased().contains("perfect"))
    }

    @Test("High accuracy shows positive text")
    func improvementSummaryHigh() {
        let session = makeSession(correct: 8, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(!vm.improvementSummary.isEmpty)
    }

    @Test("Low accuracy suggests practice")
    func improvementSummaryLow() {
        let session = makeSession(correct: 3, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.improvementSummary.lowercased().contains("practice") || vm.improvementSummary.lowercased().contains("keep"))
    }

    // MARK: - Time Performance Text (logic-268)

    @Test("Shows N/A when no time played")
    func timePerformanceNA() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timePerformanceText == "N/A")
    }

    @Test("Shows Lightning fast when faster than target")
    func timePerformanceFast() {
        var session = GameSession(difficulty: .easy) // target 6s
        for _ in 0..<10 { session.tick() } // 10 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 2s per answer
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timePerformanceText.contains("Lightning"))
    }

    @Test("Shows On pace when near target")
    func timePerformanceOnPace() {
        var session = GameSession(difficulty: .easy) // target 6s
        for _ in 0..<30 { session.tick() } // 30 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 6s per answer
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timePerformanceText.contains("pace"))
    }

    // MARK: - Accuracy Comparison (logic-278)

    @Test("Above average when accuracy exceeds average")
    func accuracyAboveAverage() {
        let stats = PlayerStats()
        stats.totalSolved = 100
        stats.totalCorrect = 60 // 60% average
        let session = makeSession(correct: 9, total: 10) // 90%
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: stats)
        #expect(vm.accuracyComparisonText?.contains("above") == true)
    }

    @Test("Below average when accuracy is lower")
    func accuracyBelowAverage() {
        let stats = PlayerStats()
        stats.totalSolved = 100
        stats.totalCorrect = 90 // 90% average
        let session = makeSession(correct: 5, total: 10) // 50%
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: stats)
        #expect(vm.accuracyComparisonText?.contains("below") == true)
    }

    @Test("Returns nil when no stats available")
    func accuracyComparisonNilNoStats() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyComparisonText == nil)
    }

    // MARK: - Score As Percentage Of Max (logic-288)

    @Test("Score percentage between 0 and 100")
    func scorePercentageInRange() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.scoreAsPercentOfMax >= 0)
        #expect(vm.scoreAsPercentOfMax <= 100)
    }

    @Test("Score percentage 0 with no score")
    func scorePercentageZero() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.scoreAsPercentOfMax == 0)
    }
}
