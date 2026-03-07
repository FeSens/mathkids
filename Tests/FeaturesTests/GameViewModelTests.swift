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
}
