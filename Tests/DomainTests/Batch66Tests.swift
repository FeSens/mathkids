import Testing
@testable import MathKids

@Suite("Batch 66 Tests")
struct Batch66Tests {

    // MARK: - GameSession timeRemainingLabel (logic-409)

    @Test("45 seconds returns 0:45")
    func time45() {
        var session = GameSession(difficulty: .easy) // 60s
        for _ in 0..<15 { session.tick() }
        #expect(session.timeRemainingLabel == "0:45")
    }

    @Test("5 seconds returns 0:05")
    func time5() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<55 { session.tick() }
        #expect(session.timeRemainingLabel == "0:05")
    }

    @Test("0 seconds returns 0:00")
    func time0() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() }
        #expect(session.timeRemainingLabel == "0:00")
    }

    // MARK: - MathProblem isLargeResult (logic-410)

    @Test("50+60 is large result")
    func large5060() {
        let p = MathProblem(operand1: 50, operand2: 60, operation: .add)
        #expect(p.isLargeResult)
    }

    @Test("5+3 is not large result")
    func notLarge() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(!p.isLargeResult)
    }

    @Test("12x12 is large result")
    func large12x12() {
        let p = MathProblem(operand1: 12, operand2: 12, operation: .multiply)
        #expect(p.isLargeResult)
    }

    // MARK: - LevelSystem levelCompletionPercentage (logic-411)

    @Test("50 XP shows 50% of level 1")
    func level1Half() {
        #expect(LevelSystem.levelCompletionPercentage(currentXP: 50, forLevel: 1) == 50)
    }

    @Test("200 XP shows 50% of level 2")
    func level2Half() {
        #expect(LevelSystem.levelCompletionPercentage(currentXP: 200, forLevel: 2) == 50)
    }

    @Test("0 XP for level 2 shows 0%")
    func level2Zero() {
        #expect(LevelSystem.levelCompletionPercentage(currentXP: 0, forLevel: 2) == 0)
    }

    // MARK: - Operation descriptionWithExample (logic-413)

    @Test("Add returns correct description")
    func addDesc() {
        #expect(Operation.add.descriptionWithExample == "Addition (3 + 2 = 5)")
    }

    @Test("Contains display name")
    func containsName() {
        #expect(Operation.multiply.descriptionWithExample.contains("Multiplication"))
    }

    @Test("Contains example")
    func containsExample() {
        #expect(Operation.subtract.descriptionWithExample.contains("7 - 3 = 4"))
    }
}

@MainActor
@Suite("Batch 66 Feature Tests")
struct Batch66FeatureTests {

    // MARK: - ResultsViewModel finalScoreText (logic-412)

    @Test("Includes score value")
    func finalScoreIncludes() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(!vm.finalScoreText.isEmpty)
    }

    @Test("Shows formatted number")
    func finalScoreFormatted() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.finalScoreText.contains("pts"))
    }
}
