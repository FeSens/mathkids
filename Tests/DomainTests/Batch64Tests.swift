import Testing
@testable import MathKids

@Suite("Batch 64 Tests")
struct Batch64Tests {

    // MARK: - GameSession scoreLabel (logic-399)

    @Test("5 correct easy returns 50 pts")
    func scoreLabel50() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.scoreLabel == "50 pts")
    }

    @Test("0 score returns 0 pts")
    func scoreLabel0() {
        let session = GameSession(difficulty: .easy)
        #expect(session.scoreLabel == "0 pts")
    }

    // MARK: - MathProblem isZeroResult (logic-400)

    @Test("5-5 has zero result")
    func zeroResult55() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .subtract)
        #expect(p.isZeroResult)
    }

    @Test("0*7 has zero result")
    func zeroResult07() {
        let p = MathProblem(operand1: 0, operand2: 7, operation: .multiply)
        #expect(p.isZeroResult)
    }

    @Test("5+3 does not have zero result")
    func notZeroResult() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(!p.isZeroResult)
    }

    // MARK: - LevelSystem isNewLevel (logic-401)

    @Test("95 to 105 crosses level 2")
    func crossLevel2() {
        #expect(LevelSystem.isNewLevel(oldXP: 95, newXP: 105))
    }

    @Test("50 to 90 does not cross")
    func noCross() {
        #expect(!LevelSystem.isNewLevel(oldXP: 50, newXP: 90))
    }

    @Test("290 to 310 crosses level 3")
    func crossLevel3() {
        #expect(LevelSystem.isNewLevel(oldXP: 290, newXP: 310))
    }

    // MARK: - Operation precedence (logic-403)

    @Test("Add precedence is 1")
    func addPrec() {
        #expect(Operation.add.precedence == 1)
    }

    @Test("Multiply precedence is 2")
    func mulPrec() {
        #expect(Operation.multiply.precedence == 2)
    }

    @Test("Subtract precedence is 1")
    func subPrec() {
        #expect(Operation.subtract.precedence == 1)
    }
}

@MainActor
@Suite("Batch 64 Feature Tests")
struct Batch64FeatureTests {

    // MARK: - ResultsViewModel correctVsWrongText (logic-402)

    @Test("Shows correct and wrong counts")
    func correctVsWrong() {
        var session = GameSession(difficulty: .easy)
        for i in 0..<10 { session.recordAnswer(correct: i < 8) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.correctVsWrongText.contains("8"))
        #expect(vm.correctVsWrongText.contains("2"))
    }

    @Test("All correct shows 0 wrong")
    func allCorrectVsWrong() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.correctVsWrongText.contains("0"))
    }
}
