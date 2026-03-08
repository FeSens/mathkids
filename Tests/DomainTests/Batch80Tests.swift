import Testing
@testable import MathKids

@Suite("Batch 80 Tests - logic-479 to logic-483")
struct Batch80Tests {

    // MARK: - logic-479: GameSession.isAboveAverage

    @Test("isAboveAverage true when above threshold")
    func isAboveAverageTrue() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<4 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(session.isAboveAverage(threshold: 70) == true)
    }

    @Test("isAboveAverage false when below threshold")
    func isAboveAverageFalse() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.isAboveAverage(threshold: 70) == false)
    }

    // MARK: - logic-480: Achievement.streakAchievements

    @Test("streakAchievements all have streak category")
    func streakAchievementsCategory() {
        let streaks = Achievement.streakAchievements
        for achievement in streaks {
            #expect(achievement.category == .streak)
        }
    }

    @Test("streakAchievements count less than total")
    func streakAchievementsLessThanTotal() {
        #expect(Achievement.streakAchievements.count < Achievement.totalCount)
    }

    // MARK: - logic-481: DifficultyLevel.requiredAccuracyForPromotion

    @Test("easy requiredAccuracyForPromotion is 80")
    func easyPromotion() {
        #expect(DifficultyLevel.easy.requiredAccuracyForPromotion == 80)
    }

    @Test("medium requiredAccuracyForPromotion is 85")
    func mediumPromotion() {
        #expect(DifficultyLevel.medium.requiredAccuracyForPromotion == 85)
    }

    @Test("hard requiredAccuracyForPromotion is 0")
    func hardPromotion() {
        #expect(DifficultyLevel.hard.requiredAccuracyForPromotion == 0)
    }

    // MARK: - logic-482: Operation.allEmojis

    @Test("allEmojis count matches allCases")
    func allEmojisCount() {
        #expect(Operation.allEmojis.count == Operation.allCases.count)
    }

    @Test("allEmojis contains plus emoji")
    func allEmojisContainsPlus() {
        #expect(Operation.allEmojis.contains("➕"))
    }

    // MARK: - logic-483: MathProblem.smallerOperand

    @Test("smallerOperand returns 3 for 3+5")
    func smallerOperandFirst() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.smallerOperand == 3)
    }

    @Test("smallerOperand returns 2 for 7+2")
    func smallerOperandSecond() {
        let problem = MathProblem(operand1: 7, operand2: 2, operation: .add)
        #expect(problem.smallerOperand == 2)
    }

    @Test("smallerOperand returns 4 for 4+4")
    func smallerOperandEqual() {
        let problem = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(problem.smallerOperand == 4)
    }
}
