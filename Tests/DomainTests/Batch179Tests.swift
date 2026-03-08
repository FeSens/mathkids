import Testing
@testable import MathKids

@Suite("Batch 179 Tests")
struct Batch179Tests {

    // MARK: - logic-974: operationQuestion

    @Test
    func operationQuestion_add() {
        #expect(Operation.add.operationQuestion.contains("plus"))
    }

    @Test
    func operationQuestion_divide() {
        #expect(!Operation.divide.operationQuestion.isEmpty)
    }

    // MARK: - logic-975: isLastTaught

    @Test
    func isLastTaught_divide() {
        #expect(Operation.divide.isLastTaught == true)
    }

    @Test
    func isLastTaught_add() {
        #expect(Operation.add.isLastTaught == false)
    }

    // MARK: - logic-976: usesTimesTable

    @Test
    func usesTimesTable_multiply() {
        #expect(Operation.multiply.usesTimesTable == true)
    }

    @Test
    func usesTimesTable_add() {
        #expect(Operation.add.usesTimesTable == false)
    }

    // MARK: - logic-977: operationCategory

    @Test
    func operationCategory_all() {
        #expect(Operation.add.operationCategory == "arithmetic")
        #expect(Operation.multiply.operationCategory == "arithmetic")
    }

    // MARK: - logic-978: operationTagLine

    @Test
    func operationTagLine_add() {
        #expect(!Operation.add.operationTagLine.isEmpty)
    }

    @Test
    func operationTagLine_divide() {
        #expect(!Operation.divide.operationTagLine.isEmpty)
    }
}
