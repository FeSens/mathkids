import Testing
@testable import MathKids

@Suite("Batch 160 Tests")
struct Batch160Tests {

    // MARK: - logic-879: hasNegativeAnswer

    @Test
    func hasNegativeAnswer_yes() {
        let problem = MathProblem(operand1: 3, operand2: 8, operation: .subtract)
        #expect(problem.hasNegativeAnswer == true)
    }

    @Test
    func hasNegativeAnswer_no() {
        let problem = MathProblem(operand1: 8, operand2: 3, operation: .subtract)
        #expect(problem.hasNegativeAnswer == false)
    }

    // MARK: - logic-880: operandProductIsLarge

    @Test
    func operandProductIsLarge_yes() {
        let problem = MathProblem(operand1: 10, operand2: 6, operation: .multiply)
        #expect(problem.operandProductIsLarge == true)
    }

    @Test
    func operandProductIsLarge_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(problem.operandProductIsLarge == false)
    }

    // MARK: - logic-881: isQuickWrongAnswer

    @Test
    func isQuickWrongAnswer_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 2.0)
        #expect(answered.isQuickWrongAnswer == true)
    }

    @Test
    func isQuickWrongAnswer_slow() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 5, timeTaken: 5.0)
        #expect(answered.isQuickWrongAnswer == false)
    }

    @Test
    func isQuickWrongAnswer_correct() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7, timeTaken: 2.0)
        #expect(answered.isQuickWrongAnswer == false)
    }

    // MARK: - logic-882: difficultyProgressText

    @Test
    func difficultyProgressText_easy() {
        #expect(!DifficultyLevel.easy.difficultyProgressText.isEmpty)
    }

    @Test
    func difficultyProgressText_hard() {
        #expect(!DifficultyLevel.hard.difficultyProgressText.isEmpty)
    }

    // MARK: - logic-883: isSubtractionFromSelf

    @Test
    func isSubtractionFromSelf_yes() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .subtract)
        #expect(problem.isSubtractionFromSelf == true)
    }

    @Test
    func isSubtractionFromSelf_notSubtract() {
        let problem = MathProblem(operand1: 5, operand2: 5, operation: .add)
        #expect(problem.isSubtractionFromSelf == false)
    }

    @Test
    func isSubtractionFromSelf_differentOperands() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(problem.isSubtractionFromSelf == false)
    }
}
