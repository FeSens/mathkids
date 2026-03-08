import Testing
@testable import MathKids

@Suite("Batch 74 Tests - logic-449 to logic-453")
struct Batch74Tests {

    // MARK: - logic-449: GameSession.wrongAnswerRate

    @Test("wrongAnswerRate returns 0.0 when no answers")
    func wrongAnswerRateNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.wrongAnswerRate == 0.0)
    }

    @Test("wrongAnswerRate returns 0.25 for 1 wrong out of 4")
    func wrongAnswerRateOneOfFour() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.wrongAnswerRate == 0.25)
    }

    @Test("wrongAnswerRate returns 1.0 for all wrong")
    func wrongAnswerRateAllWrong() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.wrongAnswerRate == 1.0)
    }

    // MARK: - logic-450: Achievement.totalCount

    @Test("totalCount equals all.count")
    func totalCountEqualsAll() {
        #expect(Achievement.totalCount == Achievement.all.count)
    }

    @Test("totalCount is greater than 0")
    func totalCountPositive() {
        #expect(Achievement.totalCount > 0)
    }

    // MARK: - logic-451: DifficultyLevel.maxOperand

    @Test("easy maxOperand is 10")
    func easyMaxOperand() {
        #expect(DifficultyLevel.easy.maxOperand == 10)
    }

    @Test("medium maxOperand is 20")
    func mediumMaxOperand() {
        #expect(DifficultyLevel.medium.maxOperand == 20)
    }

    @Test("hard maxOperand is 50")
    func hardMaxOperand() {
        #expect(DifficultyLevel.hard.maxOperand == 50)
    }

    // MARK: - logic-452: LevelSystem.levelsBetween

    @Test("levelsBetween 0 and 100 XP is 1")
    func levelsBetweenOneApart() {
        #expect(LevelSystem.levelsBetween(xp1: 0, xp2: 100) == 1)
    }

    @Test("levelsBetween same XP returns 0")
    func levelsBetweenSame() {
        #expect(LevelSystem.levelsBetween(xp1: 50, xp2: 50) == 0)
    }

    @Test("levelsBetween 0 and 1000 XP returns correct gap")
    func levelsBetweenLargeGap() {
        let expected = LevelSystem.level(for: 1000) - LevelSystem.level(for: 0)
        #expect(LevelSystem.levelsBetween(xp1: 0, xp2: 1000) == expected)
    }

    // MARK: - logic-453: MathProblem.isPositiveResult

    @Test("isPositiveResult true for 5+3")
    func isPositiveResultAddition() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.isPositiveResult == true)
    }

    @Test("isPositiveResult false for 3-3 (zero)")
    func isPositiveResultZero() {
        let problem = MathProblem(operand1: 3, operand2: 3, operation: .subtract)
        #expect(problem.isPositiveResult == false)
    }

    @Test("isPositiveResult false for 3-5 (negative)")
    func isPositiveResultNegative() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .subtract)
        #expect(problem.isPositiveResult == false)
    }
}
