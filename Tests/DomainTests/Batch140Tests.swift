import Testing
@testable import MathKids

@Suite("Batch 140 Tests")
struct Batch140Tests {

    // MARK: - logic-779: formattedProblem

    @Test
    func formattedProblem_add() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.formattedProblem == "3 + 4 = ?")
    }

    @Test
    func formattedProblem_multiply() {
        let problem = MathProblem(operand1: 5, operand2: 6, operation: .multiply)
        #expect(problem.formattedProblem == "5 x 6 = ?")
    }

    // MARK: - logic-780: isDoubleDigitAnswer

    @Test
    func isDoubleDigitAnswer_yes() {
        let problem = MathProblem(operand1: 7, operand2: 5, operation: .add)
        #expect(problem.isDoubleDigitAnswer == true)
    }

    @Test
    func isDoubleDigitAnswer_no() {
        let problem = MathProblem(operand1: 3, operand2: 2, operation: .add)
        #expect(problem.isDoubleDigitAnswer == false)
    }

    // MARK: - logic-781: operationSymbol

    @Test
    func operationSymbol_add() {
        let problem = MathProblem(operand1: 1, operand2: 1, operation: .add)
        #expect(problem.operationSymbol == "+")
    }

    @Test
    func operationSymbol_divide() {
        let problem = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        #expect(problem.operationSymbol == "/")
    }

    // MARK: - logic-782: hasSmallOperands

    @Test
    func hasSmallOperands_yes() {
        let problem = MathProblem(operand1: 3, operand2: 7, operation: .add)
        #expect(problem.hasSmallOperands == true)
    }

    @Test
    func hasSmallOperands_no() {
        let problem = MathProblem(operand1: 12, operand2: 3, operation: .add)
        #expect(problem.hasSmallOperands == false)
    }

    // MARK: - logic-783: correctAnswerText

    @Test
    func correctAnswerText() {
        let problem = MathProblem(operand1: 20, operand2: 22, operation: .add)
        #expect(problem.correctAnswerText == "42")
    }
}
