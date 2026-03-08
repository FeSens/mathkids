import Testing
import Foundation
import SwiftData
@testable import MathKids

@Suite("Batch 85 Tests - logic-504 to logic-508")
struct Batch85Tests {

    // MARK: - logic-504: HomeViewModel.selectedOperationNames

    @MainActor
    @Test("selectedOperationNames contains operation names")
    func selectedOperationNamesContent() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = HomeViewModel(statsService: service)
        vm.selectedOperations = [.add, .subtract]
        let names = vm.selectedOperationNames
        #expect(names.contains("Addition") || names.contains("Subtraction"))
    }

    // MARK: - logic-505: StatsViewModel.totalCorrectText

    @MainActor
    @Test("totalCorrectText includes count and correct word")
    func totalCorrectTextFormat() throws {
        let container = try ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        let vm = StatsViewModel(statsService: service)
        vm.totalCorrect = 42
        #expect(vm.totalCorrectText.contains("42"))
        #expect(vm.totalCorrectText.contains("correct"))
    }

    // MARK: - logic-506: ResultsViewModel.accuracyBarWidth

    @MainActor
    @Test("accuracyBarWidth returns value between 0 and 1")
    func accuracyBarWidthRange() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyBarWidth >= 0.0)
        #expect(vm.accuracyBarWidth <= 1.0)
    }

    @MainActor
    @Test("accuracyBarWidth 100% returns 1.0")
    func accuracyBarWidthPerfect() {
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracyBarWidth == 1.0)
    }

    // MARK: - logic-507: MathProblem.isDivisionByOne

    @Test("isDivisionByOne true for 5/1")
    func isDivisionByOneTrue() {
        let problem = MathProblem(operand1: 5, operand2: 1, operation: .divide)
        #expect(problem.isDivisionByOne == true)
    }

    @Test("isDivisionByOne false for 5/2")
    func isDivisionByOneFalse() {
        let problem = MathProblem(operand1: 5, operand2: 2, operation: .divide)
        #expect(problem.isDivisionByOne == false)
    }

    @Test("isDivisionByOne false for addition")
    func isDivisionByOneWrongOp() {
        let problem = MathProblem(operand1: 5, operand2: 1, operation: .add)
        #expect(problem.isDivisionByOne == false)
    }

    // MARK: - logic-508: Operation.displayNameWithEmoji

    @Test("add displayNameWithEmoji contains emoji and Addition")
    func addDisplayNameWithEmoji() {
        let text = Operation.add.displayNameWithEmoji
        #expect(text.contains("➕"))
        #expect(text.contains("Addition"))
    }

    @Test("multiply displayNameWithEmoji contains emoji and Multiplication")
    func multiplyDisplayNameWithEmoji() {
        let text = Operation.multiply.displayNameWithEmoji
        #expect(text.contains("✖️"))
        #expect(text.contains("Multiplication"))
    }
}
