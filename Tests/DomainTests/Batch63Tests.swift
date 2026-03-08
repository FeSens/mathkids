import Testing
@testable import MathKids

@Suite("Batch 63 Tests")
struct Batch63Tests {

    // MARK: - GameSession accuracyLabel (logic-394)

    @Test("8/10 correct returns 80%")
    func accuracy80() {
        var session = GameSession(difficulty: .easy)
        for i in 0..<10 { session.recordAnswer(correct: i < 8) }
        #expect(session.accuracyLabel == "80%")
    }

    @Test("0 answers returns 0%")
    func accuracy0() {
        let session = GameSession(difficulty: .easy)
        #expect(session.accuracyLabel == "0%")
    }

    @Test("10/10 correct returns 100%")
    func accuracy100() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.accuracyLabel == "100%")
    }

    // MARK: - MathProblem isMakesTen (logic-395)

    @Test("3+7 makes ten")
    func makesTen37() {
        let p = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(p.isMakesTen)
    }

    @Test("3+5 does not make ten")
    func notMakesTen() {
        let p = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(!p.isMakesTen)
    }

    @Test("3x7 does not make ten")
    func notMakesTenWrongOp() {
        let p = MathProblem(operand1: 3, operand2: 7, operation: .multiply)
        #expect(!p.isMakesTen)
    }

    // MARK: - LevelSystem levelGap (logic-396)

    @Test("Level 1 gap is 100")
    func gap1() {
        #expect(LevelSystem.levelGap(forLevel: 1) == 100)
    }

    @Test("Level 2 gap is 200")
    func gap2() {
        #expect(LevelSystem.levelGap(forLevel: 2) == 200)
    }

    @Test("Max level returns 0")
    func gapMax() {
        #expect(LevelSystem.levelGap(forLevel: 10) == 0)
    }

    // MARK: - DifficultyLevel isHardest/isEasiest (logic-398)

    @Test("Easy is easiest")
    func easyIsEasiest() {
        #expect(DifficultyLevel.easy.isEasiest)
    }

    @Test("Hard is hardest")
    func hardIsHardest() {
        #expect(DifficultyLevel.hard.isHardest)
    }

    @Test("Medium is neither")
    func mediumIsNeither() {
        #expect(!DifficultyLevel.medium.isEasiest)
        #expect(!DifficultyLevel.medium.isHardest)
    }
}

@MainActor
@Suite("Batch 63 Feature Tests")
struct Batch63FeatureTests {

    // MARK: - ResultsViewModel timeBonusText (logic-397)

    @Test("Shows bonus when time remaining")
    func timeBonusWithTime() {
        var session = GameSession(difficulty: .easy) // 60s
        for _ in 0..<10 { session.tick() } // 50s remaining
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        session.endGame()
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timeBonusText.contains("50"))
    }

    @Test("Shows 0 when no time remaining")
    func timeBonusNoTime() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() } // 0 remaining
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timeBonusText.contains("0"))
    }
}
