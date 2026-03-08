import Testing
@testable import MathKids

@Suite("Batch 75 Tests - logic-454 to logic-458")
struct Batch75Tests {

    // MARK: - logic-454: GameSession.isLowAccuracy

    @Test("isLowAccuracy true when below 50%")
    func isLowAccuracyTrue() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        #expect(session.isLowAccuracy == true)
    }

    @Test("isLowAccuracy false when above 50%")
    func isLowAccuracyFalse() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.isLowAccuracy == false)
    }

    @Test("isLowAccuracy false when no answers")
    func isLowAccuracyNoAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isLowAccuracy == false)
    }

    // MARK: - logic-455: Achievement.unlockPercentage

    @Test("unlockPercentage returns 0 for fresh stats")
    func unlockPercentageFreshStats() {
        let stats = PlayerStats()
        #expect(Achievement.unlockPercentage(for: stats) == 0)
    }

    @Test("unlockPercentage returns correct value with some unlocked")
    func unlockPercentageWithUnlocked() {
        let stats = PlayerStats()
        stats.gamesPlayed = 1
        let pct = Achievement.unlockPercentage(for: stats)
        let expected = Achievement.unlockedCount(for: stats) * 100 / Achievement.totalCount
        #expect(pct == expected)
    }

    // MARK: - logic-456: DifficultyLevel.minOperand

    @Test("easy minOperand is 1")
    func easyMinOperand() {
        #expect(DifficultyLevel.easy.minOperand == 1)
    }

    @Test("medium minOperand is 1")
    func mediumMinOperand() {
        #expect(DifficultyLevel.medium.minOperand == 1)
    }

    @Test("hard minOperand is 1")
    func hardMinOperand() {
        #expect(DifficultyLevel.hard.minOperand == 1)
    }

    // MARK: - logic-457: LevelSystem.xpToReachLevel

    @Test("xpToReachLevel 0 XP to level 2 returns 100")
    func xpToReachLevelFromZero() {
        #expect(LevelSystem.xpToReachLevel(currentXP: 0, targetLevel: 2) == 100)
    }

    @Test("xpToReachLevel 50 XP to level 2 returns 50")
    func xpToReachLevelPartial() {
        #expect(LevelSystem.xpToReachLevel(currentXP: 50, targetLevel: 2) == 50)
    }

    @Test("xpToReachLevel already at target returns 0")
    func xpToReachLevelAlreadyThere() {
        #expect(LevelSystem.xpToReachLevel(currentXP: 100, targetLevel: 2) == 0)
    }

    // MARK: - logic-458: Operation.pairKey

    @Test("pairKey generates consistent key for add-subtract")
    func pairKeyAddSubtract() {
        let key = Operation.add.pairKey(with: .subtract)
        #expect(key.contains("Addition"))
        #expect(key.contains("Subtraction"))
    }

    @Test("pairKey is commutative")
    func pairKeyCommutative() {
        let key1 = Operation.add.pairKey(with: .subtract)
        let key2 = Operation.subtract.pairKey(with: .add)
        #expect(key1 == key2)
    }

    @Test("pairKey same operation produces single name")
    func pairKeySameOperation() {
        let key = Operation.add.pairKey(with: .add)
        #expect(key == "Addition")
    }
}
