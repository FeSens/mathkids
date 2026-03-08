import Testing
@testable import MathKids

@Suite("GameEngine Extended Tests")
struct GameEngineExtendedTests {

    // MARK: - Streak Freeze (logic-252)

    @Test("Without freeze, wrong answer resets streak")
    @MainActor
    func wrongAnswerResetsStreakNoFreeze() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        #expect(engine.currentStreak == 1)
        engine.submitAnswer(99999) // wrong
        #expect(engine.currentStreak == 0)
    }

    @Test("With freeze active, wrong answer preserves streak")
    @MainActor
    func freezePreservesStreak() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.activateStreakFreeze()
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        let streak = engine.currentStreak
        #expect(streak >= 2)
        engine.submitAnswer(99999) // wrong, but freeze should save streak
        #expect(engine.currentStreak == streak)
        #expect(engine.hasStreakFreeze == false)
    }

    @Test("Second wrong answer after freeze resets streak")
    @MainActor
    func secondWrongAfterFreezeResetsStreak() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.activateStreakFreeze()
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        engine.submitAnswer(99999) // freeze consumed
        #expect(engine.hasStreakFreeze == false)
        engine.submitAnswer(engine.currentProblem.correctAnswer) // rebuild streak
        engine.submitAnswer(99999) // no freeze, resets
        #expect(engine.currentStreak == 0)
    }

    // MARK: - Wrong Answer Streak (logic-272)

    @Test("Wrong streak starts at 0")
    @MainActor
    func wrongStreakStartsAt0() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.consecutiveWrongCount == 0)
    }

    @Test("Consecutive wrong answers increment streak")
    @MainActor
    func wrongStreakIncrements() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(99999)
        engine.submitAnswer(99999)
        #expect(engine.consecutiveWrongCount == 2)
    }

    @Test("Correct answer resets wrong streak")
    @MainActor
    func correctResetsWrongStreak() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(99999)
        engine.submitAnswer(99999)
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        #expect(engine.consecutiveWrongCount == 0)
    }
}
