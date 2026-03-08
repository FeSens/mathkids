import Testing
@testable import MathKids

@Suite("Batch 126 Tests")
struct Batch126Tests {

    // MARK: - logic-709: sessionAccuracyLabel

    @Test
    func sessionAccuracyLabel() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<8 { session.recordAnswer(correct: true) }
        for _ in 0..<2 { session.recordAnswer(correct: false) }
        #expect(session.sessionAccuracyLabel == "Accuracy: 80%")
    }

    @Test
    func sessionAccuracyLabel_noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(session.sessionAccuracyLabel == "Accuracy: 0%")
    }

    // MARK: - logic-710: difficultyStarsText

    @Test
    func difficultyStarsText_easy() {
        let session = GameSession(difficulty: .easy)
        #expect(session.difficultyStarsText == "⭐")
    }

    @Test
    func difficultyStarsText_medium() {
        let session = GameSession(difficulty: .medium)
        #expect(session.difficultyStarsText == "⭐⭐")
    }

    @Test
    func difficultyStarsText_hard() {
        let session = GameSession(difficulty: .hard)
        #expect(session.difficultyStarsText == "⭐⭐⭐")
    }

    // MARK: - logic-711: isOnFire

    @Test
    func isOnFire_yes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isOnFire == true)
    }

    @Test
    func isOnFire_no_lowStreak() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        #expect(session.isOnFire == false)
    }

    @Test
    func isOnFire_no_lowAccuracy() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<8 { session.recordAnswer(correct: false) }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        // accuracy = 5/13 = 38%, streak = 5 but accuracy too low
        #expect(session.isOnFire == false)
    }

    // MARK: - logic-712: gameProgressLabel

    @Test
    func gameProgressLabel() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.gameProgressLabel.contains("Q5"))
    }

    @Test
    func gameProgressLabel_start() {
        let session = GameSession(difficulty: .easy)
        #expect(session.gameProgressLabel.contains("Q0"))
    }

    // MARK: - logic-713: timePressureLevel

    @Test
    func timePressureLevel_none() {
        let session = GameSession(difficulty: .easy)
        #expect(session.timePressureLevel == "none")
    }

    @Test
    func timePressureLevel_critical() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<57 { session.tick() }
        #expect(session.timePressureLevel == "critical")
    }

    @Test
    func timePressureLevel_high() {
        var session = GameSession(difficulty: .easy)
        // 60s game, tick 55 = 5 remaining = 8% left → high (>5 and <=10)
        for _ in 0..<55 { session.tick() }
        #expect(session.timePressureLevel == "high")
    }
}
