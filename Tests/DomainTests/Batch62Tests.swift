import Testing
import SwiftData
@testable import MathKids

@Suite("Batch 62 Tests")
struct Batch62Tests {

    // MARK: - GameSession pointsPerMinute (logic-389)

    @Test("60 points in 30 seconds = 120 per minute")
    func ppm120() {
        var session = GameSession(difficulty: .easy) // 10 pts/correct
        for _ in 0..<30 { session.tick() }
        for _ in 0..<6 { session.recordAnswer(correct: true) } // 60 pts
        #expect(session.pointsPerMinute == 120.0)
    }

    @Test("0 when no time played")
    func ppmZero() {
        let session = GameSession(difficulty: .easy)
        #expect(session.pointsPerMinute == 0)
    }

    // MARK: - MathProblem isTablesFact (logic-390)

    @Test("5x7 is a tables fact")
    func tablesFact() {
        let p = MathProblem(operand1: 5, operand2: 7, operation: .multiply)
        #expect(p.isTablesFact)
    }

    @Test("13x5 is not a tables fact")
    func notTablesFact() {
        let p = MathProblem(operand1: 13, operand2: 5, operation: .multiply)
        #expect(!p.isTablesFact)
    }

    @Test("5+7 is not a tables fact")
    func notTablesFactWrongOp() {
        let p = MathProblem(operand1: 5, operand2: 7, operation: .add)
        #expect(!p.isTablesFact)
    }

    // MARK: - LevelSystem allLevelInfo (logic-391)

    @Test("Count matches totalLevels")
    func allInfoCount() {
        #expect(LevelSystem.allLevelInfo.count == LevelSystem.totalLevels)
    }

    @Test("First is level 1 Beginner threshold 0")
    func allInfoFirst() {
        let first = LevelSystem.allLevelInfo[0]
        #expect(first.level == 1)
        #expect(first.name == "Beginner")
        #expect(first.threshold == 0)
    }

    @Test("Last is level 10 Math Wizard")
    func allInfoLast() {
        let last = LevelSystem.allLevelInfo.last!
        #expect(last.level == 10)
        #expect(last.name == "Math Wizard")
    }

    // MARK: - Operation symbolWithSpaces (logic-393)

    @Test("Add returns spaced +")
    func spacedAdd() {
        #expect(Operation.add.symbolWithSpaces == " + ")
    }

    @Test("Subtract returns spaced -")
    func spacedSubtract() {
        #expect(Operation.subtract.symbolWithSpaces == " - ")
    }

    @Test("Multiply returns spaced x")
    func spacedMultiply() {
        #expect(Operation.multiply.symbolWithSpaces == " x ")
    }
}

@MainActor
@Suite("Batch 62 Feature Tests")
struct Batch62FeatureTests {

    // MARK: - StatsViewModel formattedTimePlayed (logic-392)

    @Test("0 minutes shows 0m")
    func time0() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.totalTimePlayedMinutes = 0
        #expect(vm.formattedTimePlayed == "0m")
    }

    @Test("90 minutes shows 1h 30m")
    func time90() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.totalTimePlayedMinutes = 90
        #expect(vm.formattedTimePlayed == "1h 30m")
    }

    @Test("45 minutes shows 45m")
    func time45() {
        let container = try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let vm = StatsViewModel(statsService: StatsService(modelContainer: container))
        vm.totalTimePlayedMinutes = 45
        #expect(vm.formattedTimePlayed == "45m")
    }
}
