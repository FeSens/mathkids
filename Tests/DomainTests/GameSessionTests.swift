import Testing
@testable import MathKids

@Suite("GameSession Tests")
struct GameSessionTests {
    @Test("Starts with correct initial values")
    func initialValues() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalAnswered == 0)
        #expect(session.totalCorrect == 0)
        #expect(session.currentStreak == 0)
        #expect(session.bestStreak == 0)
        #expect(session.score == 0)
        #expect(session.timeRemaining == 60)
        #expect(!session.isFinished)
    }

    @Test("Records correct answers and increments streak")
    func recordCorrect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.totalAnswered == 1)
        #expect(session.totalCorrect == 1)
        #expect(session.currentStreak == 1)
        #expect(session.score == 10)
    }

    @Test("Records wrong answers and resets streak")
    func recordWrong() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.totalAnswered == 3)
        #expect(session.totalCorrect == 2)
        #expect(session.currentStreak == 0)
        #expect(session.bestStreak == 2)
    }

    @Test("Calculates accuracy")
    func accuracy() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.accuracy == 50.0)
    }

    @Test("Accuracy is zero when no answers")
    func accuracyZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.accuracy == 0)
    }

    @Test("Tick decrements time")
    func tick() {
        var session = GameSession(difficulty: .easy)
        session.tick()
        #expect(session.timeRemaining == 59)
    }

    @Test("Game finishes when time runs out")
    func finishOnTimeout() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 {
            session.tick()
        }
        #expect(session.isFinished)
        #expect(session.timeRemaining == 0)
    }

    @Test("Best streak tracks highest streak")
    func bestStreak() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        #expect(session.bestStreak == 3)
        #expect(session.currentStreak == 1)
    }

    @Test("Bonus points are added to score")
    func bonusPoints() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 5)
        #expect(session.score == 15) // 10 base + 5 bonus
    }

    // MARK: - Total Time Played (ui-151)

    @Test("Total time played starts at 0")
    func totalTimePlayedStartsAt0() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalTimePlayed == 0)
    }

    @Test("Total time played increases as timer ticks")
    func totalTimePlayedIncreasesWithTicks() {
        var session = GameSession(difficulty: .easy)
        session.tick()
        session.tick()
        session.tick()
        #expect(session.totalTimePlayed == 3)
    }
}
