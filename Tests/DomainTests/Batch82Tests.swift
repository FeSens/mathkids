import Testing
@testable import MathKids

@Suite("Batch 82 Tests - logic-489 to logic-493")
struct Batch82Tests {

    // MARK: - logic-489: GameSession.wrongPerMinute

    @Test("wrongPerMinute returns rate")
    func wrongPerMinuteRate() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        for _ in 0..<30 { session.tick() }
        #expect(session.wrongPerMinute == 4.0)
    }

    @Test("wrongPerMinute returns 0 when no time")
    func wrongPerMinuteNoTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.wrongPerMinute == 0)
    }

    // MARK: - logic-490: Achievement.scoreAchievements

    @Test("scoreAchievements all have score category")
    func scoreAchievementsCategory() {
        for achievement in Achievement.scoreAchievements {
            #expect(achievement.category == .score)
        }
    }

    @Test("scoreAchievements count is correct")
    func scoreAchievementsCount() {
        let expected = Achievement.all.filter { $0.category == .score }.count
        #expect(Achievement.scoreAchievements.count == expected)
    }

    // MARK: - logic-491: DifficultyLevel.pointsPerMinute

    @Test("easy pointsPerMinute is 100")
    func easyPointsPerMinute() {
        #expect(DifficultyLevel.easy.pointsPerMinute == 100)
    }

    @Test("medium pointsPerMinute is 300")
    func mediumPointsPerMinute() {
        #expect(DifficultyLevel.medium.pointsPerMinute == 300)
    }

    // MARK: - logic-492: Operation.advancedOperations

    @Test("advancedOperations count is 2")
    func advancedOperationsCount() {
        #expect(Operation.advancedOperations.count == 2)
    }

    @Test("advancedOperations contains multiply and divide")
    func advancedOperationsContents() {
        #expect(Operation.advancedOperations.contains(.multiply))
        #expect(Operation.advancedOperations.contains(.divide))
    }

    // MARK: - logic-493: MathProblem.isSingleDigitOperands

    @Test("isSingleDigitOperands true for 3+5")
    func isSingleDigitTrue() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.isSingleDigitOperands == true)
    }

    @Test("isSingleDigitOperands false for 12+5")
    func isSingleDigitFalseFirst() {
        let problem = MathProblem(operand1: 12, operand2: 5, operation: .add)
        #expect(problem.isSingleDigitOperands == false)
    }

    @Test("isSingleDigitOperands false for 5+15")
    func isSingleDigitFalseSecond() {
        let problem = MathProblem(operand1: 5, operand2: 15, operation: .add)
        #expect(problem.isSingleDigitOperands == false)
    }
}
