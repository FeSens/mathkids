import Testing
@testable import MathKids

@Suite("Batch 117 Tests")
struct Batch117Tests {

    // MARK: - logic-664: GameSession+Display.progressBarValue

    @Test
    func progressBarValue_half() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(session.progressBarValue == 0.5)
    }

    @Test
    func progressBarValue_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.progressBarValue == 0.0)
    }

    // MARK: - logic-665: GameSession+Display.answerRateText

    @Test
    func answerRateText_noTime() {
        let session = GameSession(difficulty: .easy)
        #expect(session.answerRateText == "0/min")
    }

    @Test
    func answerRateText_withAnswers() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.answerRateText == "5/min")
    }

    // MARK: - logic-666: GameSession+Display.isStrugglingSession

    @Test
    func isStrugglingSession_yes() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        for _ in 0..<4 { session.recordAnswer(correct: false) }
        #expect(session.isStrugglingSession == true)
    }

    @Test
    func isStrugglingSession_no() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isStrugglingSession == false)
    }

    // MARK: - logic-667: GameSession+Display.correctPercentText

    @Test
    func correctPercentText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(session.correctPercentText == "75%")
    }

    @Test
    func correctPercentText_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.correctPercentText == "0%")
    }

    // MARK: - logic-668: GameSession+Display.isTimeCritical

    @Test
    func isTimeCritical_no() {
        let session = GameSession(difficulty: .easy)
        #expect(session.isTimeCritical == false)
    }

    @Test
    func isTimeCritical_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<57 { session.tick() }
        #expect(session.isTimeCritical == true)
    }
}
