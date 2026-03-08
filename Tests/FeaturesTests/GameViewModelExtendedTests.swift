import Testing
@testable import MathKids

@Suite("GameViewModel Extended Tests")
struct GameViewModelExtendedTests {
    // MARK: - Combo Multiplier Display (ui-144)

    @Test("Combo multiplier is 1 with no streak")
    @MainActor
    func comboMultiplierDefault() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.comboMultiplier == 1)
    }

    @Test("Combo multiplier is 2 at streak 3")
    @MainActor
    func comboMultiplierAt3() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()
        for _ in 0..<3 {
            let answer = vm.engine.currentProblem.correctAnswer
            vm.answerText = "\(answer)"
            vm.submitAnswer()
        }
        #expect(vm.comboMultiplier == 2)
    }

    @Test("Combo multiplier is 3 at streak 5")
    @MainActor
    func comboMultiplierAt5() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()
        for _ in 0..<5 {
            let answer = vm.engine.currentProblem.correctAnswer
            vm.answerText = "\(answer)"
            vm.submitAnswer()
        }
        #expect(vm.comboMultiplier == 3)
    }

    @Test("Combo multiplier is 4 at streak 10")
    @MainActor
    func comboMultiplierAt10() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()
        for _ in 0..<10 {
            let answer = vm.engine.currentProblem.correctAnswer
            vm.answerText = "\(answer)"
            vm.submitAnswer()
        }
        #expect(vm.comboMultiplier == 4)
    }

    // MARK: - Difficulty Label (ui-148)

    @Test("Engine reports correct difficulty")
    @MainActor
    func engineReportsCorrectDifficulty() {
        let easy = GameViewModel(difficulty: .easy)
        #expect(easy.engine.difficulty == .easy)
        let hard = GameViewModel(difficulty: .hard)
        #expect(hard.engine.difficulty == .hard)
    }
}
