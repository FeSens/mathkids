import Testing
@testable import MathKids

@Suite("Batch 83 Tests - logic-494 to logic-498")
struct Batch83Tests {

    // MARK: - logic-494: GameSession.elapsedTimeText

    @Test("elapsedTimeText format is M:SS")
    func elapsedTimeTextFormat() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.elapsedTimeText == "0:30")
    }

    @Test("elapsedTimeText returns 0:00 for no time")
    func elapsedTimeTextZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.elapsedTimeText == "0:00")
    }

    // MARK: - logic-495: Achievement.masteryAchievements

    @Test("masteryAchievements all have mastery category")
    func masteryAchievementsCategory() {
        for achievement in Achievement.masteryAchievements {
            #expect(achievement.category == .mastery)
        }
    }

    // MARK: - logic-496: DifficultyLevel.difficultyLabel

    @Test("easy difficultyLabel includes emoji and name")
    func easyDifficultyLabel() {
        let label = DifficultyLevel.easy.difficultyLabel
        #expect(label.contains("🌱"))
        #expect(label.contains("Easy"))
    }

    @Test("hard difficultyLabel includes emoji and name")
    func hardDifficultyLabel() {
        let label = DifficultyLevel.hard.difficultyLabel
        #expect(label.contains("🔥"))
        #expect(label.contains("Hard"))
    }

    // MARK: - logic-497: Operation.operationCount

    @Test("operationCount returns 4")
    func operationCountIs4() {
        #expect(Operation.operationCount == 4)
    }

    @Test("operationCount equals allCases.count")
    func operationCountEqualsAll() {
        #expect(Operation.operationCount == Operation.allCases.count)
    }

    // MARK: - logic-498: MathProblem.isDoubleDigitResult

    @Test("isDoubleDigitResult true for 5+7=12")
    func isDoubleDigitTrue() {
        let problem = MathProblem(operand1: 5, operand2: 7, operation: .add)
        #expect(problem.isDoubleDigitResult == true)
    }

    @Test("isDoubleDigitResult false for 2+3=5")
    func isDoubleDigitFalseSingle() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.isDoubleDigitResult == false)
    }

    @Test("isDoubleDigitResult false for 50+60=110")
    func isDoubleDigitFalseTriple() {
        let problem = MathProblem(operand1: 50, operand2: 60, operation: .add)
        #expect(problem.isDoubleDigitResult == false)
    }
}
