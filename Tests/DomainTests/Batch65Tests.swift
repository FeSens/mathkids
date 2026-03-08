import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 65 Tests")
struct Batch65Tests {

    // MARK: - GameSession isCloseToFinishing (logic-404)

    @Test("True when 10 seconds remain")
    func close10() {
        var session = GameSession(difficulty: .easy) // 60s
        for _ in 0..<50 { session.tick() } // 10 remaining
        #expect(session.isCloseToFinishing)
    }

    @Test("False when 30 seconds remain")
    func notClose30() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        #expect(!session.isCloseToFinishing)
    }

    @Test("False when game is finished")
    func notCloseFinished() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<60 { session.tick() } // finished
        #expect(!session.isCloseToFinishing)
    }

    // MARK: - MathProblem operandDifference (logic-405)

    @Test("8-3 difference is 5")
    func diff83() {
        let p = MathProblem(operand1: 8, operand2: 3, operation: .subtract)
        #expect(p.operandDifference == 5)
    }

    @Test("3+8 difference is 5")
    func diff38() {
        let p = MathProblem(operand1: 3, operand2: 8, operation: .add)
        #expect(p.operandDifference == 5)
    }

    @Test("5+5 difference is 0")
    func diff55() {
        let p = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(p.operandDifference == 0)
    }

    // MARK: - Achievement unlockedAchievements (logic-406)

    @Test("New player has 0 unlocked")
    func noUnlocked() {
        let stats = PlayerStats()
        let unlocked = Achievement.unlockedAchievements(for: stats)
        #expect(unlocked.isEmpty)
    }

    @Test("Player with 1 game has first_game")
    func firstGameUnlocked() {
        let stats = PlayerStats()
        stats.gamesPlayed = 1
        let unlocked = Achievement.unlockedAchievements(for: stats)
        #expect(unlocked.contains { $0.id == "first_game" })
    }

    // MARK: - DifficultyLevel timePerProblemText (logic-408)

    @Test("Easy shows 6s")
    func timeEasy() {
        #expect(DifficultyLevel.easy.timePerProblemText == "6s per problem")
    }

    @Test("Medium shows 4s")
    func timeMedium() {
        #expect(DifficultyLevel.medium.timePerProblemText == "4s per problem")
    }

    @Test("Hard shows 3s")
    func timeHard() {
        #expect(DifficultyLevel.hard.timePerProblemText == "3s per problem")
    }
}

@MainActor
@Suite("Batch 65 Feature Tests")
struct Batch65FeatureTests {

    // MARK: - StatsViewModel totalProblemsSolvedText (logic-407)

    @Test("Shows count with text")
    func solvedText() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.totalSolved = 42
        #expect(vm.totalProblemsSolvedText.contains("42"))
        #expect(vm.totalProblemsSolvedText.contains("problem"))
    }

    @Test("0 shows 0 problems")
    func solvedZero() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.totalSolved = 0
        #expect(vm.totalProblemsSolvedText.contains("0"))
    }
}
