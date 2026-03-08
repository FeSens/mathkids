import Testing
@testable import MathKids

@Suite("Batch 192 Tests")
struct Batch192Tests {

    // MARK: - logic-1039: operationMinSingleDigitResult

    @Test
    func operationMinSingleDigitResult_add() {
        #expect(Operation.add.operationMinSingleDigitResult == 0)
    }

    @Test
    func operationMinSingleDigitResult_multiply() {
        #expect(Operation.multiply.operationMinSingleDigitResult == 0)
    }

    // MARK: - logic-1040: operationAlternateSymbol

    @Test
    func operationAlternateSymbol_multiply() {
        #expect(Operation.multiply.operationAlternateSymbol == "*")
    }

    @Test
    func operationAlternateSymbol_divide() {
        #expect(Operation.divide.operationAlternateSymbol == "/")
    }

    // MARK: - logic-1041: operationIsInverse

    @Test
    func operationIsInverse_subtract() {
        #expect(Operation.subtract.operationIsInverse == true)
    }

    @Test
    func operationIsInverse_add() {
        #expect(Operation.add.operationIsInverse == false)
    }

    // MARK: - logic-1042: operationSentence

    @Test
    func operationSentence_notEmpty() {
        for op in [Operation.add, .subtract, .multiply, .divide] {
            #expect(!op.operationSentence.isEmpty)
        }
    }

    // MARK: - logic-1043: operationEmoji

    @Test
    func operationEmoji_add() {
        #expect(Operation.add.operationEmoji == "➕")
    }

    @Test
    func operationEmoji_subtract() {
        #expect(Operation.subtract.operationEmoji == "➖")
    }
}
