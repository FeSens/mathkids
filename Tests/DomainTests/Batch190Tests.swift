import Testing
@testable import MathKids

@Suite("Batch 190 Tests")
struct Batch190Tests {

    // MARK: - logic-1029: operationUnicodeSymbol

    @Test
    func operationUnicodeSymbol_add() {
        #expect(Operation.add.operationUnicodeSymbol == "+")
    }

    @Test
    func operationUnicodeSymbol_divide() {
        #expect(Operation.divide.operationUnicodeSymbol == "÷")
    }

    // MARK: - logic-1030: operationLatexSymbol

    @Test
    func operationLatexSymbol_multiply() {
        #expect(Operation.multiply.operationLatexSymbol == "\\times")
    }

    @Test
    func operationLatexSymbol_divide() {
        #expect(Operation.divide.operationLatexSymbol == "\\div")
    }

    // MARK: - logic-1031: operationWordProblemPhrase

    @Test
    func operationWordProblemPhrase_add() {
        #expect(Operation.add.operationWordProblemPhrase.contains("more than"))
    }

    @Test
    func operationWordProblemPhrase_subtract() {
        #expect(Operation.subtract.operationWordProblemPhrase.contains("less than"))
    }

    // MARK: - logic-1032: operationInverseSymbol

    @Test
    func operationInverseSymbol_add() {
        #expect(Operation.add.operationInverseSymbol == "-")
    }

    @Test
    func operationInverseSymbol_multiply() {
        #expect(Operation.multiply.operationInverseSymbol == "÷")
    }

    // MARK: - logic-1033: operationPrecedence

    @Test
    func operationPrecedence_add() {
        #expect(Operation.add.operationPrecedence == 1)
    }

    @Test
    func operationPrecedence_multiply() {
        #expect(Operation.multiply.operationPrecedence == 2)
    }
}
