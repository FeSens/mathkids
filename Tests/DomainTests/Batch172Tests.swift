import Testing
@testable import MathKids

@Suite("Batch 172 Tests")
struct Batch172Tests {

    // MARK: - logic-939: operationSymbolName

    @Test
    func operationSymbolName_add() {
        #expect(Operation.add.operationSymbolName == "plus")
    }

    @Test
    func operationSymbolName_subtract() {
        #expect(Operation.subtract.operationSymbolName == "minus")
    }

    // MARK: - logic-940: operationShortName

    @Test
    func operationShortName_add() {
        #expect(Operation.add.operationShortName == "ADD")
    }

    @Test
    func operationShortName_multiply() {
        #expect(Operation.multiply.operationShortName == "MUL")
    }

    // MARK: - logic-941: isFirstInOrder

    @Test
    func isFirstInOrder_add() {
        #expect(Operation.add.isFirstInOrder == true)
    }

    @Test
    func isFirstInOrder_subtract() {
        #expect(Operation.subtract.isFirstInOrder == false)
    }

    // MARK: - logic-942: operationComplexity

    @Test
    func operationComplexity_add() {
        #expect(Operation.add.operationComplexity == "basic")
    }

    @Test
    func operationComplexity_divide() {
        #expect(Operation.divide.operationComplexity == "advanced")
    }

    // MARK: - logic-943: symbolForDisplay

    @Test
    func symbolForDisplay_add() {
        #expect(Operation.add.symbolForDisplay == "+")
    }

    @Test
    func symbolForDisplay_multiply() {
        #expect(Operation.multiply.symbolForDisplay == "×")
    }
}
