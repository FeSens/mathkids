import Testing
@testable import MathKids

@Suite("Batch 68 Tests")
struct Batch68Tests {

    // MARK: - GameSession isHighScore (logic-419)

    @Test("Score exceeds previous best")
    func isHighTrue() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 50 pts
        #expect(session.isHighScore(previousBest: 30))
    }

    @Test("Score equals previous best")
    func isHighEqual() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) } // 30 pts
        #expect(!session.isHighScore(previousBest: 30))
    }

    @Test("Score below previous best")
    func isHighBelow() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<2 { session.recordAnswer(correct: true) } // 20 pts
        #expect(!session.isHighScore(previousBest: 30))
    }

    // MARK: - MathProblem isCommutativeProblem (logic-420)

    @Test("3+5 is commutative")
    func commAdd() {
        let p = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(p.isCommutativeProblem)
    }

    @Test("4x7 is commutative")
    func commMul() {
        let p = MathProblem(operand1: 4, operand2: 7, operation: .multiply)
        #expect(p.isCommutativeProblem)
    }

    @Test("8-3 is not commutative")
    func notComm() {
        let p = MathProblem(operand1: 8, operand2: 3, operation: .subtract)
        #expect(!p.isCommutativeProblem)
    }

    // MARK: - LevelSystem didReachMilestone (logic-421)

    @Test("480 to 520 crosses 500")
    func cross500() {
        #expect(LevelSystem.didReachMilestone(oldXP: 480, newXP: 520, interval: 500))
    }

    @Test("300 to 400 does not cross")
    func noCross300() {
        #expect(!LevelSystem.didReachMilestone(oldXP: 300, newXP: 400, interval: 500))
    }

    @Test("980 to 1020 crosses 1000")
    func cross1000() {
        #expect(LevelSystem.didReachMilestone(oldXP: 980, newXP: 1020, interval: 500))
    }

    // MARK: - Achievement categoryCount (logic-423)

    @Test("Streak category has achievements")
    func streakCount() {
        #expect(Achievement.categoryCount(for: .streak) > 0)
    }

    @Test("Games category has achievements")
    func gamesCount() {
        #expect(Achievement.categoryCount(for: .games) > 0)
    }

    @Test("All categories sum to total")
    func totalCategories() {
        let total = Achievement.categoryCount(for: .streak) +
                    Achievement.categoryCount(for: .score) +
                    Achievement.categoryCount(for: .games) +
                    Achievement.categoryCount(for: .mastery)
        #expect(total == Achievement.all.count)
    }
}

@MainActor
@Suite("Batch 68 Feature Tests")
struct Batch68FeatureTests {

    // MARK: - ResultsViewModel operationSummaryText (logic-422)

    @Test("Shows difficulty name")
    func opSummaryDifficulty() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, operation: .add)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.operationSummaryText.contains("Easy"))
    }

    @Test("Not empty with operations played")
    func opSummaryNotEmpty() {
        var session = GameSession(difficulty: .medium)
        session.recordAnswer(correct: true, operation: .add)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(!vm.operationSummaryText.isEmpty)
    }
}
