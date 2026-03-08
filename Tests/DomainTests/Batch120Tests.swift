import Testing
@testable import MathKids

@Suite("Batch 120 Tests")
struct Batch120Tests {

    // MARK: - logic-679: gameStatusText

    @Test
    func gameStatusText_inProgress() {
        let session = GameSession(difficulty: .easy)
        #expect(session.gameStatusText == "In Progress")
    }

    @Test
    func gameStatusText_finished() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.gameStatusText == "Finished")
    }

    // MARK: - logic-680: pointsPerCorrectAnswer

    @Test
    func pointsPerCorrectAnswer() {
        let session = GameSession(difficulty: .easy)
        #expect(session.pointsPerCorrectAnswer == "10 pts/correct")
    }

    // MARK: - logic-681: isNewGame

    @Test
    func isNewGame_yes() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isNewGame == true)
    }

    @Test
    func isNewGame_no() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.isNewGame == false)
    }

    // MARK: - logic-682: currentScoreLabel

    @Test
    func currentScoreLabel() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 50)
        #expect(session.currentScoreLabel.contains("Score:"))
    }

    // MARK: - logic-683: hasPerfectStreak

    @Test
    func hasPerfectStreak_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.hasPerfectStreak == true)
    }

    @Test
    func hasPerfectStreak_no() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.hasPerfectStreak == false)
    }
}
