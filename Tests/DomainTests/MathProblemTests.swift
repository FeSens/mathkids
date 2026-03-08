import Testing
@testable import MathKids

@Suite("MathProblem Tests")
struct MathProblemTests {
    @Test("Addition computes correct answer")
    func additionCorrectAnswer() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.correctAnswer == 8)
    }

    @Test("Subtraction computes correct answer")
    func subtractionCorrectAnswer() {
        let problem = MathProblem(operand1: 10, operand2: 4, operation: .subtract)
        #expect(problem.correctAnswer == 6)
    }

    @Test("Multiplication computes correct answer")
    func multiplicationCorrectAnswer() {
        let problem = MathProblem(operand1: 7, operand2: 6, operation: .multiply)
        #expect(problem.correctAnswer == 42)
    }

    @Test("Division computes correct answer")
    func divisionCorrectAnswer() {
        let problem = MathProblem(operand1: 20, operand2: 5, operation: .divide)
        #expect(problem.correctAnswer == 4)
    }

    @Test("isCorrect returns true for correct answer")
    func isCorrectTrue() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isCorrect(answer: 7))
    }

    @Test("isCorrect returns false for wrong answer")
    func isCorrectFalse() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(!problem.isCorrect(answer: 8))
    }

    @Test("displayText formats correctly")
    func displayText() {
        let problem = MathProblem(operand1: 12, operand2: 3, operation: .multiply)
        #expect(problem.displayText == "12 x 3")
    }

    @Test("Operation accessibilityName returns readable names")
    func operationAccessibilityNames() {
        #expect(Operation.add.accessibilityName == "plus")
        #expect(Operation.subtract.accessibilityName == "minus")
        #expect(Operation.multiply.accessibilityName == "times")
        #expect(Operation.divide.accessibilityName == "divided by")
    }

    // MARK: - AnsweredProblem (ui-119)

    @Test("AnsweredProblem timeLabel formats correctly")
    func answeredProblemTimeLabel() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        var ap = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 2.5)
        #expect(ap.timeLabel == "2.5s")
    }

    @Test("AnsweredProblem timeLabel nil without time")
    func answeredProblemTimeLabelNil() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let ap = AnsweredProblem(problem: problem, userAnswer: 5)
        #expect(ap.timeLabel == nil)
    }

    // MARK: - Problem Difficulty Classification (logic-222)

    @Test("Simple addition is easy difficulty")
    func simpleAdditionIsEasy() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.problemDifficulty == .easy)
    }

    @Test("Large multiplication is hard difficulty")
    func largeMultiplicationIsHard() {
        let problem = MathProblem(operand1: 15, operand2: 8, operation: .multiply)
        #expect(problem.problemDifficulty == .hard)
    }

    @Test("Division is at least easy")
    func divisionDifficultyExists() {
        let problem = MathProblem(operand1: 6, operand2: 2, operation: .divide)
        let d = problem.problemDifficulty
        #expect(d == .easy || d == .moderate || d == .hard)
    }

    // MARK: - Operation Display Name (logic-226)

    @Test("Operation display names")
    func operationDisplayNames() {
        #expect(Operation.add.displayName == "Addition")
        #expect(Operation.subtract.displayName == "Subtraction")
        #expect(Operation.multiply.displayName == "Multiplication")
        #expect(Operation.divide.displayName == "Division")
    }

    // MARK: - Accessibility Text (logic-232)

    @Test("Accessibility text for addition")
    func accessibilityTextAdd() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.accessibilityText == "5 plus 3")
    }

    @Test("Accessibility text for multiplication")
    func accessibilityTextMultiply() {
        let problem = MathProblem(operand1: 8, operand2: 4, operation: .multiply)
        #expect(problem.accessibilityText == "8 times 4")
    }

    // MARK: - Operation Emoji (logic-236)

    @Test("All operations have emojis")
    func allOperationsHaveEmojis() {
        for op in Operation.allCases {
            #expect(!op.emoji.isEmpty)
        }
    }

    // MARK: - Answer Magnitude (logic-247)

    @Test("Small answer magnitude")
    func smallAnswerMagnitude() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add) // = 5
        #expect(problem.answerMagnitude == .small)
    }

    @Test("Medium answer magnitude")
    func mediumAnswerMagnitude() {
        let problem = MathProblem(operand1: 15, operand2: 20, operation: .add) // = 35
        #expect(problem.answerMagnitude == .medium)
    }

    @Test("Large answer magnitude")
    func largeAnswerMagnitude() {
        let problem = MathProblem(operand1: 50, operand2: 50, operation: .add) // = 100
        #expect(problem.answerMagnitude == .large)
    }

    // MARK: - Hint Text (logic-251)

    @Test("Addition hint mentions combining")
    func additionHint() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.hintText.lowercased().contains("combin"))
    }

    @Test("Subtraction hint mentions taking away")
    func subtractionHint() {
        let problem = MathProblem(operand1: 7, operand2: 3, operation: .subtract)
        #expect(problem.hintText.lowercased().contains("take") || problem.hintText.lowercased().contains("tak"))
    }

    @Test("Multiplication hint mentions groups")
    func multiplicationHint() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .multiply)
        #expect(problem.hintText.lowercased().contains("group"))
    }

    @Test("Division hint mentions splitting")
    func divisionHint() {
        let problem = MathProblem(operand1: 12, operand2: 3, operation: .divide)
        #expect(problem.hintText.lowercased().contains("split"))
    }

    // MARK: - Answer Digit Count (logic-257)

    @Test("Single digit answer has 1 digit")
    func singleDigitAnswer() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add) // = 5
        #expect(problem.answerDigitCount == 1)
    }

    @Test("Two digit answer has 2 digits")
    func twoDigitAnswer() {
        let problem = MathProblem(operand1: 15, operand2: 20, operation: .add) // = 35
        #expect(problem.answerDigitCount == 2)
    }

    @Test("Three digit answer has 3 digits")
    func threeDigitAnswer() {
        let problem = MathProblem(operand1: 50, operand2: 50, operation: .add) // = 100
        #expect(problem.answerDigitCount == 3)
    }

    // MARK: - Operation Inverse (logic-264)

    @Test("Add inverse is subtract")
    func addInverse() {
        #expect(Operation.add.inverse == .subtract)
    }

    @Test("Subtract inverse is add")
    func subtractInverse() {
        #expect(Operation.subtract.inverse == .add)
    }

    @Test("Multiply inverse is divide")
    func multiplyInverse() {
        #expect(Operation.multiply.inverse == .divide)
    }

    @Test("Divide inverse is multiply")
    func divideInverse() {
        #expect(Operation.divide.inverse == .multiply)
    }

    // MARK: - Wrong Answer Choices (logic-269)

    @Test("Generates exactly 3 wrong choices")
    func wrongChoicesCount() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        let choices = problem.wrongAnswerChoices
        #expect(choices.count == 3)
    }

    @Test("All wrong choices differ from correct answer")
    func wrongChoicesNotCorrect() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        let choices = problem.wrongAnswerChoices
        for choice in choices {
            #expect(choice != problem.correctAnswer)
        }
    }

    @Test("Wrong choices are all different from each other")
    func wrongChoicesUnique() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        let choices = problem.wrongAnswerChoices
        #expect(Set(choices).count == 3)
    }
}
