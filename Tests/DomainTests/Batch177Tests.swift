import Testing
@testable import MathKids

@Suite("Batch 177 Tests")
struct Batch177Tests {

    // MARK: - logic-964: canProduceZero

    @Test
    func canProduceZero_subtract() {
        #expect(Operation.subtract.canProduceZero == true)
    }

    @Test
    func canProduceZero_multiply() {
        #expect(Operation.multiply.canProduceZero == true)
    }

    // MARK: - logic-965: operationVerb

    @Test
    func operationVerb_add() {
        #expect(Operation.add.operationVerb == "add")
    }

    @Test
    func operationVerb_multiply() {
        #expect(Operation.multiply.operationVerb == "multiply")
    }

    // MARK: - logic-966: needsOrderedOperands

    @Test
    func needsOrderedOperands_subtract() {
        #expect(Operation.subtract.needsOrderedOperands == true)
    }

    @Test
    func needsOrderedOperands_add() {
        #expect(Operation.add.needsOrderedOperands == false)
    }

    // MARK: - logic-967: operationFamily

    @Test
    func operationFamily_add() {
        #expect(Operation.add.operationFamily == "additive")
    }

    @Test
    func operationFamily_multiply() {
        #expect(Operation.multiply.operationFamily == "multiplicative")
    }

    // MARK: - logic-968: operationAbbreviation

    @Test
    func operationAbbreviation_add() {
        #expect(Operation.add.operationAbbreviation == "A")
    }

    @Test
    func operationAbbreviation_divide() {
        #expect(Operation.divide.operationAbbreviation == "D")
    }
}
