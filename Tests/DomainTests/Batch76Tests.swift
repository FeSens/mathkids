import Testing
@testable import MathKids

@Suite("Batch 76 Tests - logic-459 to logic-463")
struct Batch76Tests {

    // MARK: - logic-459: GameSession.isHighAccuracy

    @Test("isHighAccuracy true when 80%")
    func isHighAccuracyTrue() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.isHighAccuracy == true)
    }

    @Test("isHighAccuracy false when below 80%")
    func isHighAccuracyFalse() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.isHighAccuracy == false)
    }

    @Test("isHighAccuracy false when no answers")
    func isHighAccuracyNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isHighAccuracy == false)
    }

    // MARK: - logic-460: Achievement.remainingToUnlock

    @Test("remainingToUnlock returns total for fresh stats")
    func remainingToUnlockFresh() {
        let stats = PlayerStats()
        #expect(Achievement.remainingToUnlock(for: stats) == Achievement.totalCount)
    }

    @Test("remainingToUnlock returns reduced count with unlocked")
    func remainingToUnlockWithUnlocked() {
        let stats = PlayerStats()
        stats.gamesPlayed = 1
        let remaining = Achievement.remainingToUnlock(for: stats)
        #expect(remaining < Achievement.totalCount)
    }

    // MARK: - logic-461: DifficultyLevel.operandRangeSize

    @Test("easy operandRangeSize is 10")
    func easyRangeSize() {
        #expect(DifficultyLevel.easy.operandRangeSize == 10)
    }

    @Test("medium operandRangeSize is 20")
    func mediumRangeSize() {
        #expect(DifficultyLevel.medium.operandRangeSize == 20)
    }

    @Test("hard operandRangeSize is 50")
    func hardRangeSize() {
        #expect(DifficultyLevel.hard.operandRangeSize == 50)
    }

    // MARK: - logic-462: LevelSystem.isCloseToLevelUp

    @Test("isCloseToLevelUp true at 90 XP")
    func isCloseToLevelUpTrue() {
        #expect(LevelSystem.isCloseToLevelUp(for: 90) == true)
    }

    @Test("isCloseToLevelUp false at 50 XP")
    func isCloseToLevelUpFalse() {
        #expect(LevelSystem.isCloseToLevelUp(for: 50) == false)
    }

    @Test("isCloseToLevelUp false at max level")
    func isCloseToLevelUpMaxLevel() {
        #expect(LevelSystem.isCloseToLevelUp(for: 5000) == false)
    }

    // MARK: - logic-463: MathProblem.isZeroOperand

    @Test("isZeroOperand true for 0+5")
    func isZeroOperandFirst() {
        let problem = MathProblem(operand1: 0, operand2: 5, operation: .add)
        #expect(problem.isZeroOperand == true)
    }

    @Test("isZeroOperand true for 5+0")
    func isZeroOperandSecond() {
        let problem = MathProblem(operand1: 5, operand2: 0, operation: .add)
        #expect(problem.isZeroOperand == true)
    }

    @Test("isZeroOperand false for 3+5")
    func isZeroOperandFalse() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.isZeroOperand == false)
    }
}
