import Testing
@testable import MathKids

@Suite("Batch 191 Tests")
struct Batch191Tests {

    // MARK: - logic-1034: operationSpokenPhrase

    @Test
    func operationSpokenPhrase_add() {
        #expect(Operation.add.operationSpokenPhrase == "plus")
    }

    @Test
    func operationSpokenPhrase_multiply() {
        #expect(Operation.multiply.operationSpokenPhrase == "times")
    }

    // MARK: - logic-1035: operationKeyboardHint

    @Test
    func operationKeyboardHint_add() {
        #expect(Operation.add.operationKeyboardHint == "+")
    }

    @Test
    func operationKeyboardHint_multiply() {
        #expect(Operation.multiply.operationKeyboardHint == "*")
    }

    // MARK: - logic-1036: operationPropertyName

    @Test
    func operationPropertyName_add() {
        #expect(Operation.add.operationPropertyName == "addition")
    }

    @Test
    func operationPropertyName_multiply() {
        #expect(Operation.multiply.operationPropertyName == "multiplication")
    }

    // MARK: - logic-1037: operationHasAssociativeProperty

    @Test
    func operationHasAssociativeProperty_add() {
        #expect(Operation.add.operationHasAssociativeProperty == true)
    }

    @Test
    func operationHasAssociativeProperty_subtract() {
        #expect(Operation.subtract.operationHasAssociativeProperty == false)
    }

    // MARK: - logic-1038: operationMaxSingleDigitResult

    @Test
    func operationMaxSingleDigitResult_add() {
        #expect(Operation.add.operationMaxSingleDigitResult == 18)
    }

    @Test
    func operationMaxSingleDigitResult_multiply() {
        #expect(Operation.multiply.operationMaxSingleDigitResult == 81)
    }
}
