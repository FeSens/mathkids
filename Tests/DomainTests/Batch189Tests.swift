import Testing
@testable import MathKids

@Suite("Batch 189 Tests")
struct Batch189Tests {

    // MARK: - logic-1024: operationInputLabel

    @Test
    func operationInputLabel_add() {
        #expect(Operation.add.operationInputLabel == "addends")
    }

    @Test
    func operationInputLabel_multiply() {
        #expect(Operation.multiply.operationInputLabel == "factors")
    }

    // MARK: - logic-1025: operationMathDomain

    @Test
    func operationMathDomain_all() {
        #expect(Operation.add.operationMathDomain == "arithmetic")
        #expect(Operation.divide.operationMathDomain == "arithmetic")
    }

    // MARK: - logic-1026: operationIdentityElement

    @Test
    func operationIdentityElement_add() {
        #expect(Operation.add.operationIdentityElement == 0)
    }

    @Test
    func operationIdentityElement_multiply() {
        #expect(Operation.multiply.operationIdentityElement == 1)
    }

    // MARK: - logic-1027: operationSignificance

    @Test
    func operationSignificance_notEmpty() {
        for op in [Operation.add, .subtract, .multiply, .divide] {
            #expect(!op.operationSignificance.isEmpty)
        }
    }

    // MARK: - logic-1028: operationRelatedSymbols

    @Test
    func operationRelatedSymbols_add() {
        #expect(Operation.add.operationRelatedSymbols.contains("+"))
    }

    @Test
    func operationRelatedSymbols_multiply() {
        #expect(Operation.multiply.operationRelatedSymbols.contains("×"))
    }
}
