import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 67 Tests")
struct Batch67Tests {

    // MARK: - GameSession wrongAnswerCount (logic-414)

    @Test("3 wrong out of 10")
    func wrong3() {
        var session = GameSession(difficulty: .easy)
        for i in 0..<10 { session.recordAnswer(correct: i < 7) }
        #expect(session.wrongAnswerCount == 3)
    }

    @Test("0 wrong when all correct")
    func wrongNone() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true) }
        #expect(session.wrongAnswerCount == 0)
    }

    // MARK: - MathProblem answerRange (logic-415)

    @Test("Range contains correct answer")
    func rangeContains() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        let range = p.answerRange
        #expect(range.min <= p.correctAnswer)
        #expect(range.max >= p.correctAnswer)
    }

    @Test("Min is less than max")
    func rangeOrdered() {
        let p = MathProblem(operand1: 7, operand2: 4, operation: .multiply)
        let range = p.answerRange
        #expect(range.min < range.max)
    }

    // MARK: - LevelSystem remainingLevels (logic-416)

    @Test("Level 1 has 9 remaining")
    func remaining9() {
        #expect(LevelSystem.remainingLevels(for: 0) == 9)
    }

    @Test("Max level has 0 remaining")
    func remaining0() {
        #expect(LevelSystem.remainingLevels(for: 5000) == 0)
    }

    @Test("Level 5 has 5 remaining")
    func remaining5() {
        #expect(LevelSystem.remainingLevels(for: 1000) == 5)
    }

    // MARK: - DifficultyLevel scoringDescription (logic-418)

    @Test("Easy shows correct values")
    func scoringEasy() {
        let desc = DifficultyLevel.easy.scoringDescription
        #expect(desc.contains("10"))
        #expect(desc.contains("2"))
    }

    @Test("Hard shows higher values")
    func scoringHard() {
        let desc = DifficultyLevel.hard.scoringDescription
        #expect(desc.contains("30"))
        #expect(desc.contains("10"))
    }

    @Test("Contains pts text")
    func scoringPts() {
        #expect(DifficultyLevel.medium.scoringDescription.contains("pts"))
    }
}

@MainActor
@Suite("Batch 67 Feature Tests")
struct Batch67FeatureTests {

    // MARK: - HomeViewModel hasPlayedBefore (logic-417)

    @Test("False when no problems solved")
    func notPlayed() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = HomeViewModel(statsService: StatsService(modelContainer: container))
        vm.totalSolved = 0
        #expect(!vm.hasPlayedBefore)
    }

    @Test("True when problems solved")
    func hasPlayed() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = HomeViewModel(statsService: StatsService(modelContainer: container))
        vm.totalSolved = 10
        #expect(vm.hasPlayedBefore)
    }
}
