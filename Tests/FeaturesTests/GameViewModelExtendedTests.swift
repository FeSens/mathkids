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

    // MARK: - Max Digit Limit (ui-154)

    @Test("Cannot exceed 6 digit limit")
    @MainActor
    func maxDigitLimit() {
        let vm = GameViewModel(difficulty: .easy)
        for _ in 0..<6 { vm.appendDigit(1) }
        #expect(vm.answerText.count == 6)
        vm.appendDigit(1)
        #expect(vm.answerText.count == 6) // Still 6, not 7
    }

    // MARK: - Negative Answer (ui-157)

    @Test("Toggle negative prepends minus sign")
    @MainActor
    func toggleNegativePrepends() {
        let vm = GameViewModel(difficulty: .easy)
        vm.appendDigit(5)
        vm.toggleNegative()
        #expect(vm.answerText == "-5")
    }

    @Test("Toggle negative twice removes minus sign")
    @MainActor
    func toggleNegativeTwice() {
        let vm = GameViewModel(difficulty: .easy)
        vm.appendDigit(5)
        vm.toggleNegative()
        vm.toggleNegative()
        #expect(vm.answerText == "5")
    }

    // MARK: - Streak Freeze (ui-158)

    @Test("Streak freeze not available at start")
    @MainActor
    func streakFreezeNotAvailableAtStart() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.hasStreakFreeze == false)
    }

    // MARK: - Practice End (ui-160)

    @Test("End practice stops the game")
    @MainActor
    func endPracticeStopsGame() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.endPractice()
        #expect(vm.isGameOver == true)
    }

}
