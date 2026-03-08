import Testing
@testable import MathKids

@Suite("Batch 119 Tests")
struct Batch119Tests {

    // MARK: - logic-674: GameSession+Display.formattedScore

    @Test
    func formattedScore() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 10)
        #expect(session.formattedScore.contains("pts"))
    }

    // MARK: - logic-675: GameSession+Display.streakLevel

    @Test
    func streakLevel_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakLevel == "none")
    }

    @Test
    func streakLevel_good() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.streakLevel == "good")
    }

    @Test
    func streakLevel_amazing() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.streakLevel == "amazing")
    }

    // MARK: - logic-676: GameSession+Display.isQuickAnswerer

    @Test
    func isQuickAnswerer_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isQuickAnswerer == false)
    }

    @Test
    func isQuickAnswerer_quick() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<2 { session.tick() }
        session.recordAnswer(correct: true)
        #expect(session.isQuickAnswerer == true)
    }

    // MARK: - logic-677: GameSession+Display.totalQuestionsLeft

    @Test
    func totalQuestionsLeft_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.totalQuestionsLeft == 0)
    }

    @Test
    func totalQuestionsLeft_withPace() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.totalQuestionsLeft > 0)
    }

    // MARK: - logic-678: GameSession+Display.difficultyColor

    @Test
    func difficultyColor() {
        let session = GameSession(difficulty: .easy)
        #expect(session.difficultyColor == "green")
    }
}
