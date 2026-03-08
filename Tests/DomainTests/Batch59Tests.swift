import Testing
@testable import MathKids

@Suite("Batch 59 Tests")
struct Batch59Tests {

    // MARK: - GameSession answeredAllCorrectly (logic-374)

    @Test("All correct returns true")
    func allCorrect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.answeredAllCorrectly)
    }

    @Test("One wrong returns false")
    func oneWrong() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<4 { session.recordAnswer(correct: true) }
        session.recordAnswer(correct: false)
        #expect(!session.answeredAllCorrectly)
    }

    @Test("No answers returns false")
    func noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(!session.answeredAllCorrectly)
    }

    // MARK: - MathProblem isNearDoubleFact (logic-375)

    @Test("5+6 is near double fact")
    func nearDouble56() {
        let p = MathProblem(operand1: 5, operand2: 6, operation: .add)
        #expect(p.isNearDoubleFact)
    }

    @Test("5+5 is not near double")
    func nearDoubleActualDouble() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(!p.isNearDoubleFact)
    }

    @Test("5+3 is not near double")
    func nearDoubleFar() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(!p.isNearDoubleFact)
    }

    // MARK: - LevelSystem xpSummary (logic-376)

    @Test("xpSummary contains level number")
    func summaryLevel() {
        let summary = LevelSystem.xpSummary(for: 150)
        #expect(summary.contains("2"))
    }

    @Test("xpSummary contains level name")
    func summaryName() {
        let summary = LevelSystem.xpSummary(for: 150)
        #expect(summary.contains("Learner"))
    }

    @Test("xpSummary contains XP amount")
    func summaryXP() {
        let summary = LevelSystem.xpSummary(for: 150)
        #expect(summary.contains("150"))
    }

    // MARK: - Operation sortedByDifficulty (logic-377)

    @Test("First is add")
    func sortedFirst() {
        #expect(Operation.sortedByDifficulty.first == .add)
    }

    @Test("Last is divide")
    func sortedLast() {
        #expect(Operation.sortedByDifficulty.last == .divide)
    }

    @Test("Count matches allCases")
    func sortedCount() {
        #expect(Operation.sortedByDifficulty.count == Operation.allCases.count)
    }

    // MARK: - GameSession isHotStreak (logic-378)

    @Test("Streak 5 is hot")
    func hotStreak5() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.isHotStreak)
    }

    @Test("Streak 4 is not hot")
    func hotStreak4() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<4 { session.recordAnswer(correct: true) }
        #expect(!session.isHotStreak)
    }

    @Test("Streak 10 is hot")
    func hotStreak10() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        #expect(session.isHotStreak)
    }
}
