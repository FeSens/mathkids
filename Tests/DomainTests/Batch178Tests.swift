import Testing
@testable import MathKids

@Suite("Batch 178 Tests")
struct Batch178Tests {

    // MARK: - logic-969: operationExample

    @Test
    func operationExample_add() {
        #expect(Operation.add.operationExample.contains("="))
    }

    @Test
    func operationExample_multiply() {
        #expect(Operation.multiply.operationExample.contains("="))
    }

    // MARK: - logic-970: operationPlural

    @Test
    func operationPlural_add() {
        #expect(Operation.add.operationPlural == "additions")
    }

    @Test
    func operationPlural_multiply() {
        #expect(Operation.multiply.operationPlural == "multiplications")
    }

    // MARK: - logic-971: maximumResult

    @Test
    func maximumResult_add() {
        #expect(Operation.add.maximumResult == 18)
    }

    @Test
    func maximumResult_multiply() {
        #expect(Operation.multiply.maximumResult == 81)
    }

    // MARK: - logic-972: operationMinAge

    @Test
    func operationMinAge_add() {
        #expect(Operation.add.operationMinAge == 5)
    }

    @Test
    func operationMinAge_divide() {
        #expect(Operation.divide.operationMinAge == 8)
    }

    // MARK: - logic-973: isSingleStepOperation

    @Test
    func isSingleStepOperation_add() {
        #expect(Operation.add.isSingleStepOperation == true)
    }

    @Test
    func isSingleStepOperation_multiply() {
        #expect(Operation.multiply.isSingleStepOperation == false)
    }
}
