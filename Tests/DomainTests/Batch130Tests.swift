import Testing
@testable import MathKids

@Suite("Batch 130 Tests")
struct Batch130Tests {

    // MARK: - logic-729: difficultyScoreMultiplier

    @Test
    func difficultyScoreMultiplier_easy() {
        let session = GameSession(difficulty: .easy)
        #expect(session.difficultyScoreMultiplier == 1)
    }

    @Test
    func difficultyScoreMultiplier_medium() {
        let session = GameSession(difficulty: .medium)
        #expect(session.difficultyScoreMultiplier == 2)
    }

    @Test
    func difficultyScoreMultiplier_hard() {
        let session = GameSession(difficulty: .hard)
        #expect(session.difficultyScoreMultiplier == 3)
    }

    // MARK: - logic-730: isComebackStory

    @Test
    func isComebackStory_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        // accuracy = 50%, currentStreak = 5 → comeback
        #expect(session.isComebackStory == true)
    }

    @Test
    func isComebackStory_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        // accuracy = 100%, no comeback needed
        #expect(session.isComebackStory == false)
    }

    // MARK: - logic-731: endOfGameSummary

    @Test
    func endOfGameSummary_containsScore() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let summary = session.endOfGameSummary
        #expect(summary.contains("Score"))
    }

    @Test
    func endOfGameSummary_containsAccuracy() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let summary = session.endOfGameSummary
        #expect(summary.contains("%"))
    }

    // MARK: - logic-732: shouldShowHint

    @Test
    func shouldShowHint_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        #expect(session.shouldShowHint == true)
    }

    @Test
    func shouldShowHint_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.shouldShowHint == false)
    }

    // MARK: - logic-733: progressEmoji

    @Test
    func progressEmoji_start() {
        let session = GameSession(difficulty: .easy)
        #expect(session.progressEmoji == "🏁")
    }

    @Test
    func progressEmoji_middle() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.progressEmoji == "🏃")
    }

    @Test
    func progressEmoji_end() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<55 { session.tick() }
        #expect(session.progressEmoji == "🏆")
    }
}
