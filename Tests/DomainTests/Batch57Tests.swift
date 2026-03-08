import Testing
@testable import MathKids

@Suite("Batch 57 Tests")
struct Batch57Tests {

    // MARK: - GameSession lastNAccuracy (logic-364)

    @Test("lastNAccuracy for last 5 all correct")
    func lastNAllCorrect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.lastNAccuracy(n: 5) == 100.0)
    }

    @Test("lastNAccuracy returns 0 with no answers")
    func lastNEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.lastNAccuracy(n: 5) == 0)
    }

    @Test("lastNAccuracy clamps to available answers")
    func lastNClamped() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.lastNAccuracy(n: 10) == 50.0)
    }

    // MARK: - MathProblem isDoubleFact (logic-365)

    @Test("5+5 is a double fact")
    func isDoubleFactTrue() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(p.isDoubleFact)
    }

    @Test("5+3 is not a double fact")
    func isDoubleFactFalse() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(!p.isDoubleFact)
    }

    @Test("5x5 is not a double fact")
    func isDoubleFactNotMultiply() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .multiply)
        #expect(!p.isDoubleFact)
    }

    // MARK: - LevelSystem levelProgressBar (logic-366)

    @Test("Progress bar contains percentage")
    func progressBarPercentage() {
        let bar = LevelSystem.levelProgressBar(for: 50) // 50% into level 1
        #expect(bar.contains("%"))
    }

    @Test("Max level shows full bar")
    func progressBarMaxLevel() {
        let bar = LevelSystem.levelProgressBar(for: 5000)
        #expect(bar.contains("100%"))
    }

    // MARK: - Operation allPairs (logic-367)

    @Test("allPairs has 6 elements")
    func allPairsCount() {
        #expect(Operation.allPairs.count == 6)
    }

    @Test("Each pair has two different operations")
    func allPairsDifferent() {
        for pair in Operation.allPairs {
            #expect(pair.0 != pair.1)
        }
    }

    // MARK: - GameSession currentPace (logic-368)

    @Test("High accuracy session is ahead")
    func paceAhead() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.currentPace == .ahead)
    }

    @Test("Low accuracy session is behind")
    func paceBehind() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        for _ in 0..<5 { session.recordAnswer(correct: false) }
        #expect(session.currentPace == .behind)
    }

    @Test("New session is on pace")
    func paceNew() {
        let session = GameSession(difficulty: .easy)
        #expect(session.currentPace == .onPace)
    }
}
