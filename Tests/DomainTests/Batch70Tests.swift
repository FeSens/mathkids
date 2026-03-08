import Testing
@testable import MathKids

@Suite("Batch 70 Tests")
struct Batch70Tests {

    // MARK: - GameSession isPerfectGame (logic-429)

    @Test("True when all correct and finished")
    func perfectFinished() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        session.endGame()
        #expect(session.isPerfectGame)
    }

    @Test("False when all correct but not finished")
    func perfectNotFinished() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(!session.isPerfectGame)
    }

    @Test("False when some wrong and finished")
    func notPerfect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        session.endGame()
        #expect(!session.isPerfectGame)
    }

    // MARK: - MathProblem isMultiplicationByOne (logic-430)

    @Test("7x1 is multiplication by one")
    func mul71() {
        let p = MathProblem(operand1: 7, operand2: 1, operation: .multiply)
        #expect(p.isMultiplicationByOne)
    }

    @Test("1x5 is multiplication by one")
    func mul15() {
        let p = MathProblem(operand1: 1, operand2: 5, operation: .multiply)
        #expect(p.isMultiplicationByOne)
    }

    @Test("3x4 is not multiplication by one")
    func mul34() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(!p.isMultiplicationByOne)
    }

    // MARK: - LevelSystem xpUntilMax (logic-431)

    @Test("0 XP needs 4500")
    func until0() {
        #expect(LevelSystem.xpUntilMax(currentXP: 0) == 4500)
    }

    @Test("2000 XP needs 2500")
    func until2000() {
        #expect(LevelSystem.xpUntilMax(currentXP: 2000) == 2500)
    }

    @Test("5000 XP needs 0")
    func until5000() {
        #expect(LevelSystem.xpUntilMax(currentXP: 5000) == 0)
    }

    // MARK: - Operation isBasicOperation (logic-433)

    @Test("Add is basic")
    func addBasic() {
        #expect(Operation.add.isBasicOperation)
    }

    @Test("Subtract is basic")
    func subBasic() {
        #expect(Operation.subtract.isBasicOperation)
    }

    @Test("Multiply is not basic")
    func mulNotBasic() {
        #expect(!Operation.multiply.isBasicOperation)
    }

    @Test("Divide is not basic")
    func divNotBasic() {
        #expect(!Operation.divide.isBasicOperation)
    }
}

@MainActor
@Suite("Batch 70 Feature Tests")
struct Batch70FeatureTests {

    // MARK: - ResultsViewModel difficultyBadgeText (logic-432)

    @Test("Contains difficulty name")
    func badgeName() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyBadgeText.contains("Easy"))
    }

    @Test("Contains emoji")
    func badgeEmoji() {
        let session = GameSession(difficulty: .hard)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyBadgeText.contains("🔥"))
    }
}
