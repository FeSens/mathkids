import Testing
@testable import MathKids

@Suite("Batch 72 Tests")
struct Batch72Tests {

    // MARK: - GameSession averageStreakLength (logic-439)

    @Test("6 correct 2 breaks gives average 2")
    func avgStreak() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false) // break 1
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false) // break 2
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        // 6 correct, 2 breaks = 3 streak segments → avg 2.0
        #expect(session.averageStreakLength == 2.0)
    }

    @Test("All correct gives totalCorrect")
    func avgStreakAllCorrect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.averageStreakLength == 5.0)
    }

    @Test("0 answers gives 0")
    func avgStreakEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.averageStreakLength == 0)
    }

    // MARK: - MathProblem isDivisionExact (logic-440)

    @Test("10/2 is exact")
    func exactDiv() {
        let p = MathProblem(operand1: 10, operand2: 2, operation: .divide)
        #expect(p.isDivisionExact)
    }

    @Test("10/3 is not exact")
    func notExactDiv() {
        let p = MathProblem(operand1: 10, operand2: 3, operation: .divide)
        #expect(!p.isDivisionExact)
    }

    @Test("5+3 is not (wrong op)")
    func notDivision() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(!p.isDivisionExact)
    }

    // MARK: - LevelSystem nextLevelName (logic-441)

    @Test("0 XP next is Learner")
    func nextName0() {
        #expect(LevelSystem.nextLevelName(for: 0) == "Learner")
    }

    @Test("100 XP next is Explorer")
    func nextName100() {
        #expect(LevelSystem.nextLevelName(for: 100) == "Explorer")
    }

    @Test("Max level returns nil")
    func nextNameMax() {
        #expect(LevelSystem.nextLevelName(for: 5000) == nil)
    }

    // MARK: - Operation isAdvanced (logic-443)

    @Test("Multiply is advanced")
    func mulAdvanced() {
        #expect(Operation.multiply.isAdvanced)
    }

    @Test("Divide is advanced")
    func divAdvanced() {
        #expect(Operation.divide.isAdvanced)
    }

    @Test("Add is not advanced")
    func addNotAdvanced() {
        #expect(!Operation.add.isAdvanced)
    }

    @Test("Subtract is not advanced")
    func subNotAdvanced() {
        #expect(!Operation.subtract.isAdvanced)
    }
}

@MainActor
@Suite("Batch 72 Feature Tests")
struct Batch72FeatureTests {

    // MARK: - ResultsViewModel problemCountText (logic-442)

    @Test("Shows problem count")
    func countText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<15 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.problemCountText.contains("15"))
    }

    @Test("Contains problem text")
    func countContains() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.problemCountText.lowercased().contains("problem"))
    }
}
