import Testing
@testable import MathKids

@Suite("Batch 175 Tests")
struct Batch175Tests {

    // MARK: - logic-954: operationQuizPrompt

    @Test
    func operationQuizPrompt_add() {
        #expect(!Operation.add.operationQuizPrompt.isEmpty)
    }

    @Test
    func operationQuizPrompt_multiply() {
        #expect(!Operation.multiply.operationQuizPrompt.isEmpty)
    }

    // MARK: - logic-955: isReductiveOperation

    @Test
    func isReductiveOperation_subtract() {
        #expect(Operation.subtract.isReductiveOperation == true)
    }

    @Test
    func isReductiveOperation_add() {
        #expect(Operation.add.isReductiveOperation == false)
    }

    // MARK: - logic-956: operationBadge

    @Test
    func operationBadge_unique() {
        let badges = Set([Operation.add.operationBadge, Operation.subtract.operationBadge,
                          Operation.multiply.operationBadge, Operation.divide.operationBadge])
        #expect(badges.count == 4)
    }

    @Test
    func operationBadge_singleChar() {
        #expect(Operation.add.operationBadge.count == 1)
    }

    // MARK: - logic-957: teachingOrder

    @Test
    func teachingOrder_add() {
        #expect(Operation.add.teachingOrder == 1)
    }

    @Test
    func teachingOrder_divide() {
        #expect(Operation.divide.teachingOrder == 4)
    }

    // MARK: - logic-958: operationAccessibilityLabel

    @Test
    func operationAccessibilityLabel_add() {
        #expect(!Operation.add.operationAccessibilityLabel.isEmpty)
    }

    @Test
    func operationAccessibilityLabel_divide() {
        #expect(!Operation.divide.operationAccessibilityLabel.isEmpty)
    }
}
