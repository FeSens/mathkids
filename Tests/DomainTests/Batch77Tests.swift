import Testing
@testable import MathKids

@Suite("Batch 77 Tests - logic-464 to logic-468")
struct Batch77Tests {

    // MARK: - logic-464: GameSession.scoreSummaryText

    @Test("scoreSummaryText includes score value")
    func scoreSummaryTextIncludesScore() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.scoreSummaryText.contains("\(session.score)"))
    }

    @Test("scoreSummaryText includes accuracy")
    func scoreSummaryTextIncludesAccuracy() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.scoreSummaryText.contains("%"))
    }

    // MARK: - logic-465: Achievement.achievementsByCategory

    @Test("achievementsByCategory returns dictionary with keys")
    func achievementsByCategoryKeys() {
        let grouped = Achievement.achievementsByCategory
        #expect(!grouped.isEmpty)
    }

    @Test("achievementsByCategory includes all achievements")
    func achievementsByCategoryAll() {
        let grouped = Achievement.achievementsByCategory
        let total = grouped.values.reduce(0) { $0 + $1.count }
        #expect(total == Achievement.all.count)
    }

    // MARK: - logic-466: DifficultyLevel.totalPossibleProblems

    @Test("easy totalPossibleProblems is 20")
    func easyTotalPossible() {
        #expect(DifficultyLevel.easy.totalPossibleProblems == 20)
    }

    @Test("medium totalPossibleProblems is 60")
    func mediumTotalPossible() {
        #expect(DifficultyLevel.medium.totalPossibleProblems == 60)
    }

    @Test("hard totalPossibleProblems is 200")
    func hardTotalPossible() {
        #expect(DifficultyLevel.hard.totalPossibleProblems == 200)
    }

    // MARK: - logic-467: LevelSystem.xpPercentOfMax

    @Test("xpPercentOfMax returns 0 for 0 XP")
    func xpPercentOfMaxZero() {
        #expect(LevelSystem.xpPercentOfMax(for: 0) == 0)
    }

    @Test("xpPercentOfMax returns 100 for max XP")
    func xpPercentOfMaxFull() {
        #expect(LevelSystem.xpPercentOfMax(for: LevelSystem.xpToMaxLevel) == 100)
    }

    @Test("xpPercentOfMax returns correct partial")
    func xpPercentOfMaxPartial() {
        let halfXP = LevelSystem.xpToMaxLevel / 2
        let pct = LevelSystem.xpPercentOfMax(for: halfXP)
        #expect(pct == 50)
    }

    // MARK: - logic-468: MathProblem.operandRatio

    @Test("operandRatio returns 2.0 for 10/5")
    func operandRatioTwoToOne() {
        let problem = MathProblem(operand1: 10, operand2: 5, operation: .add)
        #expect(problem.operandRatio == 2.0)
    }

    @Test("operandRatio returns 0.5 for 5/10")
    func operandRatioHalf() {
        let problem = MathProblem(operand1: 5, operand2: 10, operation: .add)
        #expect(problem.operandRatio == 0.5)
    }

    @Test("operandRatio returns 0.0 for x/0")
    func operandRatioZeroDivisor() {
        let problem = MathProblem(operand1: 5, operand2: 0, operation: .add)
        #expect(problem.operandRatio == 0.0)
    }
}
