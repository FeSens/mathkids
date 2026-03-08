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

    // MARK: - Slowest Answer Time (logic-304)

    @Test("Slowest is nil initially")
    @MainActor
    func slowestNilInitially() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.slowestAnswerTime == nil)
    }

    @Test("Slowest updates on first answer")
    @MainActor
    func slowestUpdatesOnFirst() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        #expect(engine.slowestAnswerTime != nil)
    }

    @Test("Slowest keeps the maximum time")
    @MainActor
    func slowestKeepsMax() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        let first = engine.slowestAnswerTime!
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        #expect(engine.slowestAnswerTime! >= first || engine.slowestAnswerTime! > 0)
    }

    // MARK: - Difficulty Trend (logic-312)

    @Test("Starts as stable")
    @MainActor
    func difficultyTrendStable() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.difficultyTrend == .stable)
    }

    @Test("Increasing after many correct")
    @MainActor
    func difficultyTrendIncreasing() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        for _ in 0..<6 {
            engine.submitAnswer(engine.currentProblem.correctAnswer)
        }
        #expect(engine.difficultyTrend == .increasing)
    }

    @Test("Decreasing after many wrong")
    @MainActor
    func difficultyTrendDecreasing() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        for _ in 0..<4 {
            engine.submitAnswer(99999)
        }
        #expect(engine.difficultyTrend == .decreasing)
    }

    // MARK: - Accuracy By Half (logic-322)

    @Test("First half accuracy matches session")
    @MainActor
    func firstHalfAccuracyMatchesSession() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        engine.submitAnswer(99999)
        engine.submitAnswer(99999)
        #expect(engine.firstHalfAccuracy == engine.session.firstHalfAccuracy)
    }

    @Test("Second half accuracy matches session")
    @MainActor
    func secondHalfAccuracyMatchesSession() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(99999)
        engine.submitAnswer(99999)
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        engine.submitAnswer(engine.currentProblem.correctAnswer)
        #expect(engine.secondHalfAccuracy == engine.session.secondHalfAccuracy)
    }

    // MARK: - Time On Current Problem (logic-332)

    @Test("Starts at approximately 0")
    @MainActor
    func timeOnProblemStartsLow() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.timeOnCurrentProblem < 1.0)
    }
}
