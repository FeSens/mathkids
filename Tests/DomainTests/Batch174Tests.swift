import Testing
@testable import MathKids

@Suite("Batch 174 Tests")
struct Batch174Tests {

    // MARK: - logic-949: operationTip

    @Test
    func operationTip_add() {
        #expect(!Operation.add.operationTip.isEmpty)
    }

    @Test
    func operationTip_divide() {
        #expect(!Operation.divide.operationTip.isEmpty)
    }

    // MARK: - logic-950: isSubtractOrDivide

    @Test
    func isSubtractOrDivide_subtract() {
        #expect(Operation.subtract.isSubtractOrDivide == true)
    }

    @Test
    func isSubtractOrDivide_add() {
        #expect(Operation.add.isSubtractOrDivide == false)
    }

    // MARK: - logic-951: operationLabel

    @Test
    func operationLabel_add() {
        let label = Operation.add.operationLabel
        #expect(label.contains("+"))
    }

    @Test
    func operationLabel_divide() {
        let label = Operation.divide.operationLabel
        #expect(!label.isEmpty)
    }

    // MARK: - logic-952: operationIndex

    @Test
    func operationIndex_add() {
        #expect(Operation.add.operationIndex == 0)
    }

    @Test
    func operationIndex_divide() {
        #expect(Operation.divide.operationIndex == 3)
    }

    // MARK: - logic-953: isAddOrMultiply

    @Test
    func isAddOrMultiply_add() {
        #expect(Operation.add.isAddOrMultiply == true)
    }

    @Test
    func isAddOrMultiply_subtract() {
        #expect(Operation.subtract.isAddOrMultiply == false)
    }
}
