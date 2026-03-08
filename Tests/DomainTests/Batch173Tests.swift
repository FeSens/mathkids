import Testing
@testable import MathKids

@Suite("Batch 173 Tests")
struct Batch173Tests {

    // MARK: - logic-944: operationKeyword

    @Test
    func operationKeyword_add() {
        #expect(Operation.add.operationKeyword == "plus")
    }

    @Test
    func operationKeyword_multiply() {
        #expect(Operation.multiply.operationKeyword == "times")
    }

    // MARK: - logic-945: isLastInOrder

    @Test
    func isLastInOrder_divide() {
        #expect(Operation.divide.isLastInOrder == true)
    }

    @Test
    func isLastInOrder_add() {
        #expect(Operation.add.isLastInOrder == false)
    }

    // MARK: - logic-946: operationPairName

    @Test
    func operationPairName_add() {
        #expect(Operation.add.operationPairName.contains("addition"))
    }

    @Test
    func operationPairName_multiply() {
        #expect(Operation.multiply.operationPairName.contains("multiplication"))
    }

    // MARK: - logic-947: gradeLevel

    @Test
    func gradeLevel_add() {
        #expect(Operation.add.gradeLevel <= 2)
    }

    @Test
    func gradeLevel_divide() {
        #expect(Operation.divide.gradeLevel >= 3)
    }

    // MARK: - logic-948: operationSortKey

    @Test
    func operationSortKey_ordering() {
        #expect(Operation.add.operationSortKey < Operation.multiply.operationSortKey)
    }

    @Test
    func operationSortKey_unique() {
        let keys = Set([Operation.add.operationSortKey, Operation.subtract.operationSortKey,
                        Operation.multiply.operationSortKey, Operation.divide.operationSortKey])
        #expect(keys.count == 4)
    }
}
