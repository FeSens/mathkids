import Testing
@testable import MathKids

@Suite("Batch 81 Tests - logic-484 to logic-488")
struct Batch81Tests {

    // MARK: - logic-484: GameSession.correctPerMinute

    @Test("correctPerMinute returns rate")
    func correctPerMinuteRate() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        for _ in 0..<30 { session.tick() }
        #expect(session.correctPerMinute == 4.0) // 2 correct in 30 sec = 4/min
    }

    @Test("correctPerMinute returns 0 when no time")
    func correctPerMinuteNoTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.correctPerMinute == 0)
    }

    // MARK: - logic-485: Achievement.gameAchievements

    @Test("gameAchievements all have games category")
    func gameAchievementsCategory() {
        let games = Achievement.gameAchievements
        for achievement in games {
            #expect(achievement.category == .games)
        }
    }

    @Test("gameAchievements count is correct")
    func gameAchievementsCount() {
        let games = Achievement.gameAchievements
        let expected = Achievement.all.filter { $0.category == .games }.count
        #expect(games.count == expected)
    }

    // MARK: - logic-486: DifficultyLevel.allSorted

    @Test("allSorted first is easy")
    func allSortedFirst() {
        #expect(DifficultyLevel.allSorted.first == .easy)
    }

    @Test("allSorted last is hard")
    func allSortedLast() {
        #expect(DifficultyLevel.allSorted.last == .hard)
    }

    @Test("allSorted count is 3")
    func allSortedCount() {
        #expect(DifficultyLevel.allSorted.count == 3)
    }

    // MARK: - logic-487: Operation.basicOperations

    @Test("basicOperations count is 2")
    func basicOperationsCount() {
        #expect(Operation.basicOperations.count == 2)
    }

    @Test("basicOperations contains add and subtract")
    func basicOperationsContents() {
        #expect(Operation.basicOperations.contains(.add))
        #expect(Operation.basicOperations.contains(.subtract))
    }

    // MARK: - logic-488: MathProblem.operandAbsDifference

    @Test("operandAbsDifference 3 and 5 returns 2")
    func operandAbsDiffSmallFirst() {
        let problem = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(problem.operandAbsDifference == 2)
    }

    @Test("operandAbsDifference 5 and 3 returns 2")
    func operandAbsDiffLargeFirst() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.operandAbsDifference == 2)
    }

    @Test("operandAbsDifference same returns 0")
    func operandAbsDiffSame() {
        let problem = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(problem.operandAbsDifference == 0)
    }
}
