import Testing
@testable import MathKids

@Suite("GameViewModel Tests")
struct GameViewModelTests {
    @Test("Starts with countdown visible")
    @MainActor
    func startsWithCountdown() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.showCountdown == true)
    }

    @Test("Countdown finished starts game and hides countdown")
    @MainActor
    func countdownFinished() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()
        #expect(vm.showCountdown == false)
    }

    @Test("Append digit adds to answer text")
    @MainActor
    func appendDigit() {
        let vm = GameViewModel(difficulty: .easy)
        vm.appendDigit(5)
        #expect(vm.answerText == "5")
        vm.appendDigit(3)
        #expect(vm.answerText == "53")
    }

    @Test("Delete digit removes last character")
    @MainActor
    func deleteDigit() {
        let vm = GameViewModel(difficulty: .easy)
        vm.appendDigit(4)
        vm.appendDigit(2)
        vm.deleteDigit()
        #expect(vm.answerText == "4")
    }

    @Test("Toggle negative adds/removes minus sign")
    @MainActor
    func toggleNegative() {
        let vm = GameViewModel(difficulty: .easy)
        vm.appendDigit(5)
        vm.toggleNegative()
        #expect(vm.answerText == "-5")
        vm.toggleNegative()
        #expect(vm.answerText == "5")
    }

    @Test("Submit answer clears answer text")
    @MainActor
    func submitClearsAnswer() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()
        vm.appendDigit(1)
        vm.submitAnswer()
        #expect(vm.answerText == "")
    }

    @Test("Score popup added on correct answer")
    @MainActor
    func scorePopupOnCorrect() async throws {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        // Get the correct answer and submit it
        let correctAnswer = vm.engine.currentProblem.correctAnswer
        let digits = String(abs(correctAnswer))
        if correctAnswer < 0 {
            vm.toggleNegative()
        }
        for char in digits {
            vm.appendDigit(Int(String(char))!)
        }
        vm.submitAnswer()

        #expect(vm.showCelebration == true)
        #expect(!vm.scorePopups.isEmpty)
    }

    @Test("Max 6 digits in answer")
    @MainActor
    func maxDigits() {
        let vm = GameViewModel(difficulty: .easy)
        for i in 0..<8 {
            vm.appendDigit(i % 10)
        }
        #expect(vm.answerText.count == 6)
    }

    @Test("Practice mode has no countdown")
    @MainActor
    func practiceModeNoCountdown() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        #expect(vm.showCountdown == false)
        #expect(vm.isPracticeMode == true)
    }

    @Test("Practice mode does not start timer")
    @MainActor
    func practiceModeNoTimer() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.startGame()
        #expect(vm.isGameOver == false)
    }

    @Test("Practice mode end practice stops game")
    @MainActor
    func practiceEndStopsGame() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.endPractice()
        #expect(vm.isGameOver == true)
    }

    @Test("Character mood starts as neutral")
    @MainActor
    func characterMoodStartsNeutral() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.characterMood == .neutral)
    }

    @Test("Character mood changes to happy on correct answer")
    @MainActor
    func characterMoodHappyOnCorrect() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        let correctAnswer = vm.engine.currentProblem.correctAnswer
        let digits = String(abs(correctAnswer))
        if correctAnswer < 0 { vm.toggleNegative() }
        for char in digits { vm.appendDigit(Int(String(char))!) }
        vm.submitAnswer()

        #expect(vm.characterMood == .happy || vm.characterMood == .excited)
    }

    @Test("Character mood changes to sad on wrong answer")
    @MainActor
    func characterMoodSadOnWrong() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        // Submit a definitely wrong answer (999)
        vm.appendDigit(9)
        vm.appendDigit(9)
        vm.appendDigit(9)
        vm.submitAnswer()

        #expect(vm.characterMood == .sad)
    }

    @Test("Daily challenge mode has no countdown")
    @MainActor
    func dailyChallengeNoCountdown() {
        let vm = GameViewModel(difficulty: .medium, mode: .dailyChallenge)
        #expect(vm.showCountdown == false)
        #expect(vm.isDailyChallenge == true)
    }

    @Test("Daily challenge ends after 10 problems")
    @MainActor
    func dailyChallengeEndsAfter10() {
        let vm = GameViewModel(difficulty: .easy, mode: .dailyChallenge)
        vm.startGame()

        for _ in 0..<10 {
            // Submit answer (wrong is fine, just need to submit)
            vm.appendDigit(9)
            vm.appendDigit(9)
            vm.appendDigit(9)
            vm.submitAnswer()
        }

        #expect(vm.isGameOver == true)
        #expect(vm.dailyChallengeProblemsAnswered == 10)
    }

    @Test("Daily challenge tracks elapsed time")
    @MainActor
    func dailyChallengeElapsedTime() {
        let vm = GameViewModel(difficulty: .easy, mode: .dailyChallenge)
        #expect(vm.elapsedSeconds == 0)
    }

    @Test("Combo multiplier starts at 1")
    @MainActor
    func comboMultiplierStartsAt1() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.comboMultiplier == 1)
    }

    @Test("Combo multiplier is 2x after 3 correct answers")
    @MainActor
    func comboMultiplier2xAt3() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        for _ in 0..<3 {
            let correct = vm.engine.currentProblem.correctAnswer
            let digits = String(abs(correct))
            if correct < 0 { vm.toggleNegative() }
            for char in digits { vm.appendDigit(Int(String(char))!) }
            vm.submitAnswer()
        }

        #expect(vm.comboMultiplier == 2)
    }

    @Test("Combo multiplier is 3x after 5 correct answers")
    @MainActor
    func comboMultiplier3xAt5() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        for _ in 0..<5 {
            let correct = vm.engine.currentProblem.correctAnswer
            let digits = String(abs(correct))
            if correct < 0 { vm.toggleNegative() }
            for char in digits { vm.appendDigit(Int(String(char))!) }
            vm.submitAnswer()
        }

        #expect(vm.comboMultiplier == 3)
    }

    @Test("Combo multiplier is 4x after 10 correct answers")
    @MainActor
    func comboMultiplier4xAt10() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        for _ in 0..<10 {
            let correct = vm.engine.currentProblem.correctAnswer
            let digits = String(abs(correct))
            if correct < 0 { vm.toggleNegative() }
            for char in digits { vm.appendDigit(Int(String(char))!) }
            vm.submitAnswer()
        }

        #expect(vm.comboMultiplier == 4)
    }

    @Test("Combo multiplier resets on wrong answer")
    @MainActor
    func comboMultiplierResetsOnWrong() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        // Get 3 correct for 2x
        for _ in 0..<3 {
            let correct = vm.engine.currentProblem.correctAnswer
            let digits = String(abs(correct))
            if correct < 0 { vm.toggleNegative() }
            for char in digits { vm.appendDigit(Int(String(char))!) }
            vm.submitAnswer()
        }
        #expect(vm.comboMultiplier == 2)

        // Wrong answer resets
        vm.appendDigit(9)
        vm.appendDigit(9)
        vm.appendDigit(9)
        vm.submitAnswer()
        #expect(vm.comboMultiplier == 1)
    }

    @Test("Wrong answer shows correct answer hint")
    @MainActor
    func wrongAnswerShowsHint() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        let correctAnswer = vm.engine.currentProblem.correctAnswer

        // Submit wrong answer
        vm.appendDigit(9)
        vm.appendDigit(9)
        vm.appendDigit(9)
        vm.submitAnswer()

        #expect(vm.correctAnswerHint == correctAnswer)
    }

    @Test("Correct answer does not show hint")
    @MainActor
    func correctAnswerNoHint() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()

        let correct = vm.engine.currentProblem.correctAnswer
        let digits = String(abs(correct))
        if correct < 0 { vm.toggleNegative() }
        for char in digits { vm.appendDigit(Int(String(char))!) }
        vm.submitAnswer()

        #expect(vm.correctAnswerHint == nil)
    }

    @Test("Hint is nil before any submission")
    @MainActor
    func hintNilInitially() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.correctAnswerHint == nil)
    }

    @Test("Problem number starts at 1")
    @MainActor
    func problemNumberStartsAt1() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.problemNumber == 1)
    }

    @Test("Problem number increments on submit")
    @MainActor
    func problemNumberIncrements() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()
        vm.appendDigit(1)
        vm.submitAnswer()
        #expect(vm.problemNumber == 2)
    }

    @Test("Clear answer empties answer text")
    @MainActor
    func clearAnswerWorks() {
        let vm = GameViewModel(difficulty: .easy)
        vm.appendDigit(5)
        vm.appendDigit(3)
        vm.clearAnswer()
        #expect(vm.answerText == "")
    }

    @Test("Clear answer does nothing when empty")
    @MainActor
    func clearAnswerWhenEmpty() {
        let vm = GameViewModel(difficulty: .easy)
        vm.clearAnswer()
        #expect(vm.answerText == "")
    }

    @Test("Skip problem advances to next in practice mode")
    @MainActor
    func skipProblemInPractice() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        let firstProblem = vm.problemText
        vm.appendDigit(5)
        vm.skipProblem()
        #expect(vm.answerText == "")
        #expect(vm.problemNumber == 2)
    }

    @Test("Skip problem does nothing in timed mode")
    @MainActor
    func skipProblemNotInTimed() {
        let vm = GameViewModel(difficulty: .easy, mode: .timed)
        let firstNumber = vm.problemNumber
        vm.skipProblem()
        #expect(vm.problemNumber == firstNumber)
    }

    @Test("Pause starts as false")
    @MainActor
    func pauseStartsFalse() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.isPaused == false)
    }

    @Test("Toggle pause in timed mode")
    @MainActor
    func togglePauseInTimed() {
        let vm = GameViewModel(difficulty: .easy, mode: .timed)
        vm.countdownFinished()
        vm.togglePause()
        #expect(vm.isPaused == true)
        vm.togglePause()
        #expect(vm.isPaused == false)
    }

    @Test("Toggle pause does nothing in practice mode")
    @MainActor
    func togglePauseNotInPractice() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.togglePause()
        #expect(vm.isPaused == false)
    }

    // MARK: - Countdown Tick Sounds (ui-089)

    @Test("Should play tick in last 5 seconds of timed mode")
    @MainActor
    func shouldPlayTickInLast5Seconds() {
        let vm = GameViewModel(difficulty: .easy, mode: .timed)
        #expect(vm.shouldPlayTick(timeRemaining: 5) == true)
        #expect(vm.shouldPlayTick(timeRemaining: 3) == true)
        #expect(vm.shouldPlayTick(timeRemaining: 1) == true)
    }

    @Test("Should not play tick above 5 seconds")
    @MainActor
    func shouldNotPlayTickAbove5() {
        let vm = GameViewModel(difficulty: .easy, mode: .timed)
        #expect(vm.shouldPlayTick(timeRemaining: 6) == false)
        #expect(vm.shouldPlayTick(timeRemaining: 30) == false)
    }

    @Test("Should not play tick at 0 seconds")
    @MainActor
    func shouldNotPlayTickAt0() {
        let vm = GameViewModel(difficulty: .easy, mode: .timed)
        #expect(vm.shouldPlayTick(timeRemaining: 0) == false)
    }

    @Test("Should not play tick in practice mode")
    @MainActor
    func shouldNotPlayTickInPractice() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        #expect(vm.shouldPlayTick(timeRemaining: 3) == false)
    }

    // MARK: - Skip Penalty (ui-092)

    @Test("Skip count starts at 0")
    @MainActor
    func skipCountStartsAt0() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        #expect(vm.skippedCount == 0)
    }

    @Test("Skip increments skip count")
    @MainActor
    func skipIncrementsCount() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.skipProblem()
        #expect(vm.skippedCount == 1)
        vm.skipProblem()
        #expect(vm.skippedCount == 2)
    }

    @Test("Show skip indicator after skip")
    @MainActor
    func showSkipIndicator() {
        let vm = GameViewModel(difficulty: .easy, mode: .practice)
        vm.skipProblem()
        #expect(vm.showSkipIndicator == true)
    }

    // MARK: - Streak Milestone Text (ui-097)

    @Test("Streak milestone text at 5")
    @MainActor
    func streakMilestoneAt5() {
        #expect(GameViewModel.streakMilestoneText(for: 5) == "On Fire!")
    }

    @Test("Streak milestone text at 10")
    @MainActor
    func streakMilestoneAt10() {
        #expect(GameViewModel.streakMilestoneText(for: 10) == "Unstoppable!")
    }

    @Test("Streak milestone text at 15")
    @MainActor
    func streakMilestoneAt15() {
        #expect(GameViewModel.streakMilestoneText(for: 15) == "LEGENDARY!")
    }

    @Test("No milestone text for non-milestone streak")
    @MainActor
    func noMilestoneTextAt4() {
        #expect(GameViewModel.streakMilestoneText(for: 4) == nil)
    }

    // MARK: - Problem Count Goal (ui-098)

    @Test("Problem goal progress starts at 0")
    @MainActor
    func problemGoalStartsAt0() {
        let vm = GameViewModel(difficulty: .easy)
        #expect(vm.problemGoalProgress == 0.0)
    }

    @Test("Problem goal progress increases with answers")
    @MainActor
    func problemGoalIncreases() {
        let vm = GameViewModel(difficulty: .easy)
        vm.countdownFinished()
        vm.appendDigit(1)
        vm.submitAnswer()
        #expect(vm.problemGoalProgress > 0.0)
    }

}
