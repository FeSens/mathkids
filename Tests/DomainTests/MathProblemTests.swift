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
}
