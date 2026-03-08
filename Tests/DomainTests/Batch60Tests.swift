import Testing
@testable import MathKids

@Suite("Batch 60 Tests")
struct Batch60Tests {

    // MARK: - GameSession streakDescription (logic-379)

    @Test("Streak 5 shows 5 in a row")
    func streakDesc5() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.streakDescription == "5 in a row!")
    }

    @Test("Streak 0 shows no streak")
    func streakDesc0() {
        let session = GameSession(difficulty: .easy)
        #expect(session.streakDescription == "No streak")
    }

    @Test("Streak 1 shows 1 in a row")
    func streakDesc1() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.streakDescription == "1 in a row!")
    }

    // MARK: - MathProblem maxOperand (logic-380)

    @Test("maxOperand for 3+7 returns 7")
    func maxOp37() {
        let p = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(p.maxOperand == 7)
    }

    @Test("maxOperand for 10-5 returns 10")
    func maxOp105() {
        let p = MathProblem(operand1: 10, operand2: 5, operation: .subtract)
        #expect(p.maxOperand == 10)
    }

    @Test("maxOperand for equal returns that value")
    func maxOpEqual() {
        let p = MathProblem(operand1: 4, operand2: 4, operation: .add)
        #expect(p.maxOperand == 4)
    }

    // MARK: - LevelSystem xpToNextMilestone (logic-381)

    @Test("50 XP needs 50 to reach 100")
    func milestone50() {
        #expect(LevelSystem.xpToNextMilestone(currentXP: 50) == 50)
    }

    @Test("100 XP needs 100 to reach 200")
    func milestone100() {
        #expect(LevelSystem.xpToNextMilestone(currentXP: 100) == 100)
    }

    @Test("0 XP needs 100 to reach 100")
    func milestone0() {
        #expect(LevelSystem.xpToNextMilestone(currentXP: 0) == 100)
    }

    // MARK: - DifficultyLevel progressionPath (logic-383)

    @Test("Path has 3 elements")
    func pathCount() {
        #expect(DifficultyLevel.progressionPath.count == 3)
    }

    @Test("Order is easy, medium, hard")
    func pathOrder() {
        #expect(DifficultyLevel.progressionPath == [.easy, .medium, .hard])
    }
}

@MainActor
@Suite("Batch 60 Feature Tests")
struct Batch60FeatureTests {

    // MARK: - ResultsViewModel streakRewardText (logic-382)

    @Test("Shows text for streak >= 5")
    func streakRewardHigh() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.streakRewardText != nil)
        #expect(vm.streakRewardText!.contains("5"))
    }

    @Test("Returns nil for streak < 5")
    func streakRewardLow() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.streakRewardText == nil)
    }
}
