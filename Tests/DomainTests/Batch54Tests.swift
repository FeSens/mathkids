import Testing
@testable import MathKids

@Suite("Batch 54 Tests")
struct Batch54Tests {

    // MARK: - GameSession correctAnswersPerMinute (logic-349)

    @Test("correctAnswersPerMinute with time and correct answers")
    func correctPerMinute() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() } // 30 seconds
        for i in 0..<10 { session.recordAnswer(correct: i < 6) } // 6 correct
        #expect(session.correctAnswersPerMinute == 12.0)
    }

    @Test("correctAnswersPerMinute returns 0 with no time")
    func correctPerMinuteNoTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.correctAnswersPerMinute == 0)
    }

    // MARK: - Operation pairDescription (logic-350)

    @Test("Pair description for add and subtract")
    func pairAddSubtract() {
        let desc = Operation.pairDescription(.add, .subtract)
        #expect(desc.contains("Addition"))
        #expect(desc.contains("Subtraction"))
    }

    @Test("Pair description for same operation")
    func pairSameOp() {
        let desc = Operation.pairDescription(.add, .add)
        #expect(desc == "Addition")
    }

    @Test("Pair description for multiply and divide")
    func pairMultiplyDivide() {
        let desc = Operation.pairDescription(.multiply, .divide)
        #expect(desc.contains("Multiplication"))
        #expect(desc.contains("Division"))
    }

    // MARK: - LevelSystem levelUpMessage (logic-351)

    @Test("Level up message contains level names")
    func levelUpMessage() {
        let msg = LevelSystem.levelUpMessage(from: 1, to: 2)
        #expect(msg.contains("Beginner"))
        #expect(msg.contains("Learner"))
    }

    @Test("Max level message is special")
    func levelUpMax() {
        let msg = LevelSystem.levelUpMessage(from: 9, to: 10)
        #expect(msg.contains("Math Wizard"))
    }

    // MARK: - GameSession longestCorrectRun (logic-352)

    @Test("longestCorrectRun matches bestStreak")
    func longestRun() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.longestCorrectRun == 3)
    }

    @Test("longestCorrectRun is 0 with no answers")
    func longestRunEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.longestCorrectRun == 0)
    }

    // MARK: - DifficultyLevel xpPerCorrectAnswer (logic-353)

    @Test("Easy xpPerCorrectAnswer is 10")
    func xpEasy() {
        #expect(DifficultyLevel.easy.xpPerCorrectAnswer == 10)
    }

    @Test("Medium xpPerCorrectAnswer is 15")
    func xpMedium() {
        #expect(DifficultyLevel.medium.xpPerCorrectAnswer == 15)
    }

    @Test("Hard xpPerCorrectAnswer is 20")
    func xpHard() {
        #expect(DifficultyLevel.hard.xpPerCorrectAnswer == 20)
    }
}
