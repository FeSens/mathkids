import Testing
@testable import MathKids

@Suite("Batch 79 Tests - logic-474 to logic-478")
struct Batch79Tests {

    // MARK: - logic-474: GameSession.pointsNeededForTarget

    @Test("pointsNeededForTarget returns gap")
    func pointsNeededForTargetGap() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        let needed = session.pointsNeededForTarget(target: 100)
        #expect(needed == 100 - session.score)
    }

    @Test("pointsNeededForTarget returns 0 when exceeded")
    func pointsNeededForTargetExceeded() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.pointsNeededForTarget(target: 0) == 0)
    }

    // MARK: - logic-475: Achievement.firstLockedAchievement

    @Test("firstLockedAchievement returns first for fresh stats")
    func firstLockedFreshStats() {
        let stats = PlayerStats()
        let first = Achievement.firstLockedAchievement(for: stats)
        #expect(first != nil)
        #expect(first?.id == Achievement.all.first?.id)
    }

    // MARK: - logic-476: DifficultyLevel.isUnlocked

    @Test("easy always unlocked")
    func easyAlwaysUnlocked() {
        #expect(DifficultyLevel.easy.isUnlocked(gamesPlayed: 0) == true)
    }

    @Test("medium needs 3 games")
    func mediumNeeds3() {
        #expect(DifficultyLevel.medium.isUnlocked(gamesPlayed: 2) == false)
        #expect(DifficultyLevel.medium.isUnlocked(gamesPlayed: 3) == true)
    }

    @Test("hard needs 10 games")
    func hardNeeds10() {
        #expect(DifficultyLevel.hard.isUnlocked(gamesPlayed: 9) == false)
        #expect(DifficultyLevel.hard.isUnlocked(gamesPlayed: 10) == true)
    }

    // MARK: - logic-477: Operation.allDisplayNames

    @Test("allDisplayNames count matches allCases")
    func allDisplayNamesCount() {
        #expect(Operation.allDisplayNames.count == Operation.allCases.count)
    }

    @Test("allDisplayNames contains Addition")
    func allDisplayNamesContainsAddition() {
        #expect(Operation.allDisplayNames.contains("Addition"))
    }

    // MARK: - logic-478: MathProblem.largerOperand

    @Test("largerOperand returns 5 for 3+5")
    func largerOperandSecond() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.largerOperand == 5)
    }

    @Test("largerOperand returns 7 for 7+2")
    func largerOperandFirst() {
        let problem = MathProblem(operand1: 7, operand2: 2, operation: .add)
        #expect(problem.largerOperand == 7)
    }

    @Test("largerOperand returns 4 for 4+4")
    func largerOperandEqual() {
        let problem = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(problem.largerOperand == 4)
    }
}
