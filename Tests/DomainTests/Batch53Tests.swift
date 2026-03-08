import Testing
@testable import MathKids

@Suite("Batch 53 Tests")
struct Batch53Tests {

    // MARK: - GameSession streakAtEnd (logic-344)

    @Test("streakAtEnd returns current streak when game ends with correct answers")
    func streakAtEndCorrect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.endGame()
        #expect(session.streakAtEnd == 3)
    }

    @Test("streakAtEnd is 0 when last answer was wrong")
    func streakAtEndWrong() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.endGame()
        #expect(session.streakAtEnd == 0)
    }

    @Test("streakAtEnd is 0 for empty session")
    func streakAtEndEmpty() {
        var session = GameSession(difficulty: .easy)
        session.endGame()
        #expect(session.streakAtEnd == 0)
    }

    // MARK: - MathProblem stepByStepHint (logic-345)

    @Test("Multiplication hint shows repeated addition")
    func stepByStepHintMultiply() {
        let problem = MathProblem(operand1: 4, operand2: 3, operation: .multiply)
        let hint = problem.stepByStepHint
        #expect(hint.contains("3 + 3 + 3 + 3"))
    }

    @Test("Addition hint shows counting up")
    func stepByStepHintAdd() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        let hint = problem.stepByStepHint
        #expect(!hint.isEmpty)
    }

    @Test("Subtraction hint shows counting down")
    func stepByStepHintSubtract() {
        let problem = MathProblem(operand1: 8, operand2: 3, operation: .subtract)
        let hint = problem.stepByStepHint
        #expect(!hint.isEmpty)
    }

    @Test("Division hint shows grouping")
    func stepByStepHintDivide() {
        let problem = MathProblem(operand1: 12, operand2: 4, operation: .divide)
        let hint = problem.stepByStepHint
        #expect(!hint.isEmpty)
    }

    // MARK: - LevelSystem xpForLevel (logic-346)

    @Test("xpForLevel 1 returns 0")
    func xpForLevel1() {
        #expect(LevelSystem.xpForLevel(1) == 0)
    }

    @Test("xpForLevel 5 returns 1000")
    func xpForLevel5() {
        #expect(LevelSystem.xpForLevel(5) == 1000)
    }

    @Test("xpForLevel out of range returns nil")
    func xpForLevelOutOfRange() {
        #expect(LevelSystem.xpForLevel(0) == nil)
        #expect(LevelSystem.xpForLevel(11) == nil)
    }

    // MARK: - GameSession averageTimePerAnswer (logic-347)

    @Test("averageTimePerAnswer returns time divided by answers")
    func avgTimePerAnswer() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() } // 20 seconds
        for _ in 0..<4 { session.recordAnswer(correct: true) }
        #expect(session.averageTimePerAnswer == 5.0)
    }

    @Test("averageTimePerAnswer returns 0 with no answers")
    func avgTimePerAnswerEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.averageTimePerAnswer == 0)
    }

    // MARK: - DifficultyLevel difficultyMultiplier (logic-348)

    @Test("Easy multiplier is 1.0")
    func easyMultiplier() {
        #expect(DifficultyLevel.easy.difficultyMultiplier == 1.0)
    }

    @Test("Medium multiplier is 1.5")
    func mediumMultiplier() {
        #expect(DifficultyLevel.medium.difficultyMultiplier == 1.5)
    }

    @Test("Hard multiplier is 2.0")
    func hardMultiplier() {
        #expect(DifficultyLevel.hard.difficultyMultiplier == 2.0)
    }
}
