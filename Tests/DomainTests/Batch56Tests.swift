import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 56 Tests")
struct Batch56Tests {

    // MARK: - GameSession accuracyForRange (logic-359)

    @Test("accuracyForRange for first half")
    func accuracyForRangeFirstHalf() {
        var session = GameSession(difficulty: .easy)
        // First 4: 3 correct, 1 wrong = 75%
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        // Next 4: 1 correct, 3 wrong
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: false)
        session.recordAnswer(correct: true)
        session.recordAnswer(correct: false)
        #expect(session.accuracyForRange(start: 0, end: 4) == 75.0)
    }

    @Test("accuracyForRange returns 0 for empty range")
    func accuracyForRangeEmpty() {
        let session = GameSession(difficulty: .easy)
        #expect(session.accuracyForRange(start: 0, end: 0) == 0)
    }

    // MARK: - MathProblem operandSum and operandProduct (logic-360)

    @Test("operandSum for 3+5 returns 8")
    func operandSum() {
        let p = MathProblem(operand1: 3, operand2: 5, operation: .add)
        #expect(p.operandSum == 8)
    }

    @Test("operandProduct for 4x3 returns 12")
    func operandProduct() {
        let p = MathProblem(operand1: 4, operand2: 3, operation: .multiply)
        #expect(p.operandProduct == 12)
    }

    @Test("operandSum works for subtraction")
    func operandSumSubtract() {
        let p = MathProblem(operand1: 10, operand2: 3, operation: .subtract)
        #expect(p.operandSum == 13)
    }

    // MARK: - LevelSystem isLevelBoundary (logic-361)

    @Test("0 XP is a level boundary")
    func boundaryAt0() {
        #expect(LevelSystem.isLevelBoundary(xp: 0))
    }

    @Test("100 XP is a level boundary")
    func boundaryAt100() {
        #expect(LevelSystem.isLevelBoundary(xp: 100))
    }

    @Test("50 XP is not a level boundary")
    func notBoundaryAt50() {
        #expect(!LevelSystem.isLevelBoundary(xp: 50))
    }
}

@MainActor
@Suite("Batch 56 Feature Tests")
struct Batch56FeatureTests {

    // MARK: - HomeViewModel streakStatusText (logic-362)

    @Test("streakStatusText shows streak when exists")
    func streakTextWithStreak() {
        let statsService = StatsService(modelContainer: try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)))
        let vm = HomeViewModel(statsService: statsService)
        vm.dailyStreak = 3
        #expect(vm.streakStatusText.contains("3"))
    }

    @Test("streakStatusText shows no streak when 0")
    func streakTextNoStreak() {
        let statsService = StatsService(modelContainer: try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true)))
        let vm = HomeViewModel(statsService: statsService)
        vm.dailyStreak = 0
        #expect(vm.streakStatusText.lowercased().contains("no streak") || vm.streakStatusText.contains("0"))
    }

    // MARK: - ResultsViewModel xpEarnedText (logic-363)

    @Test("xpEarnedText shows XP for correct answers")
    func xpEarnedWithCorrect() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.xpEarnedText.contains("XP"))
    }

    @Test("xpEarnedText shows 0 when no correct answers")
    func xpEarnedZero() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: false)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.xpEarnedText.contains("0"))
    }
}
