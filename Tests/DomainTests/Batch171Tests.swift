import Testing
@testable import MathKids

@Suite("Batch 171 Tests")
struct Batch171Tests {

    // MARK: - logic-934: inverseOperation

    @Test
    func inverseOperation_add() {
        #expect(Operation.add.inverseOperation == .subtract)
    }

    @Test
    func inverseOperation_multiply() {
        #expect(Operation.multiply.inverseOperation == .divide)
    }

    // MARK: - logic-935: isBasicArithmetic

    @Test
    func isBasicArithmetic_add() {
        #expect(Operation.add.isBasicArithmetic == true)
    }

    @Test
    func isBasicArithmetic_multiply() {
        #expect(Operation.multiply.isBasicArithmetic == false)
    }

    // MARK: - logic-936: operationDescription

    @Test
    func operationDescription_add() {
        #expect(!Operation.add.operationDescription.isEmpty)
    }

    @Test
    func operationDescription_divide() {
        #expect(!Operation.divide.operationDescription.isEmpty)
    }

    // MARK: - logic-937: isAdvancedOperation

    @Test
    func isAdvancedOperation_multiply() {
        #expect(Operation.multiply.isAdvancedOperation == true)
    }

    @Test
    func isAdvancedOperation_add() {
        #expect(Operation.add.isAdvancedOperation == false)
    }

    // MARK: - logic-938: operationOrder

    @Test
    func operationOrder_add() {
        #expect(Operation.add.operationOrder == 0)
    }

    @Test
    func operationOrder_divide() {
        #expect(Operation.divide.operationOrder == 3)
    }
}
