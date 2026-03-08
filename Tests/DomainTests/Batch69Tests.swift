import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 69 Tests")
struct Batch69Tests {

    // MARK: - GameSession hasAnswered (logic-424)

    @Test("False at start")
    func noAnswers() {
        let session = GameSession(difficulty: .easy)
        #expect(!session.hasAnswered)
    }

    @Test("True after one answer")
    func oneAnswer() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        #expect(session.hasAnswered)
    }

    // MARK: - MathProblem isSubtractionToZero (logic-425)

    @Test("5-5 is subtraction to zero")
    func sub55() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .subtract)
        #expect(p.isSubtractionToZero)
    }

    @Test("5-3 is not")
    func sub53() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(!p.isSubtractionToZero)
    }

    @Test("5+5 is not (wrong op)")
    func add55() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(!p.isSubtractionToZero)
    }

    // MARK: - LevelSystem currentLevelName (logic-426)

    @Test("0 XP returns Beginner")
    func name0() {
        #expect(LevelSystem.currentLevelName(for: 0) == "Beginner")
    }

    @Test("100 XP returns Learner")
    func name100() {
        #expect(LevelSystem.currentLevelName(for: 100) == "Learner")
    }

    @Test("Matches levelName")
    func matchesLevelName() {
        for xp in [0, 100, 300, 600, 1000, 4500] {
            #expect(LevelSystem.currentLevelName(for: xp) == LevelSystem.levelName(for: xp))
        }
    }

    // MARK: - DifficultyLevel totalGameTimeText (logic-428)

    @Test("Easy shows 60 seconds")
    func timeEasy() {
        #expect(DifficultyLevel.easy.totalGameTimeText == "60 seconds")
    }

    @Test("Medium shows 45 seconds")
    func timeMedium() {
        #expect(DifficultyLevel.medium.totalGameTimeText == "45 seconds")
    }

    @Test("Hard shows 30 seconds")
    func timeHard() {
        #expect(DifficultyLevel.hard.totalGameTimeText == "30 seconds")
    }
}

@MainActor
@Suite("Batch 69 Feature Tests")
struct Batch69FeatureTests {

    // MARK: - StatsViewModel bestStreakText (logic-427)

    @Test("Shows streak number")
    func streakText() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.bestStreak = 12
        #expect(vm.bestStreakText.contains("12"))
    }

    @Test("Shows 0 when no streak")
    func streakZero() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.bestStreak = 0
        #expect(vm.bestStreakText.contains("0"))
    }
}
