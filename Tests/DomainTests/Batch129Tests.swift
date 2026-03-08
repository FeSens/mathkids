import Testing
@testable import MathKids

@Suite("Batch 129 Tests")
struct Batch129Tests {

    // MARK: - logic-724: isConsistentPerformer

    @Test
    func isConsistentPerformer_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<8 { session.recordAnswer(correct: true) }
        for _ in 0..<2 { session.recordAnswer(correct: false) }
        #expect(session.isConsistentPerformer == true)
    }

    @Test
    func isConsistentPerformer_no_lowAccuracy() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<2 { session.recordAnswer(correct: true) }
        for _ in 0..<8 { session.recordAnswer(correct: false) }
        #expect(session.isConsistentPerformer == false)
    }

    @Test
    func isConsistentPerformer_no_tooFew() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        #expect(session.isConsistentPerformer == false)
    }

    // MARK: - logic-725: quickFinishBonus

    @Test
    func quickFinishBonus_withTimeLeft() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        // 50s remaining → bonus = 50/2 = 25
        #expect(session.quickFinishBonus == 25)
    }

    @Test
    func quickFinishBonus_noTimeLeft() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.quickFinishBonus == 0)
    }

    // MARK: - logic-726: sessionTitleText

    @Test
    func sessionTitleText_easy() {
        let session = GameSession(difficulty: .easy)
        #expect(session.sessionTitleText == "Easy Challenge")
    }

    @Test
    func sessionTitleText_hard() {
        let session = GameSession(difficulty: .hard)
        #expect(session.sessionTitleText == "Hard Challenge")
    }

    // MARK: - logic-727: answersPerSecond

    @Test
    func answersPerSecond_withData() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<20 { session.tick() }
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.answersPerSecond == 0.5)
    }

    @Test
    func answersPerSecond_noTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.answersPerSecond == 0.0)
    }

    // MARK: - logic-728: perfectGameText

    @Test
    func perfectGameText_perfect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.perfectGameText == "Perfect Game!")
    }

    @Test
    func perfectGameText_notPerfect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.perfectGameText == "")
    }

    @Test
    func perfectGameText_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.perfectGameText == "")
    }
}
