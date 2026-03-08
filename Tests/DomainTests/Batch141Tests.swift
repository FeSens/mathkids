import Testing
@testable import MathKids

@Suite("Batch 141 Tests")
struct Batch141Tests {

    // MARK: - logic-784: requiresOrdering

    @Test
    func requiresOrdering_subtract() {
        #expect(Operation.subtract.requiresOrdering == true)
    }

    @Test
    func requiresOrdering_add() {
        #expect(Operation.add.requiresOrdering == false)
    }

    @Test
    func requiresOrdering_divide() {
        #expect(Operation.divide.requiresOrdering == true)
    }

    // MARK: - logic-785: resultVerb

    @Test
    func resultVerb_add() {
        #expect(Operation.add.resultVerb == "sum")
    }

    @Test
    func resultVerb_subtract() {
        #expect(Operation.subtract.resultVerb == "difference")
    }

    @Test
    func resultVerb_multiply() {
        #expect(Operation.multiply.resultVerb == "product")
    }

    @Test
    func resultVerb_divide() {
        #expect(Operation.divide.resultVerb == "quotient")
    }

    // MARK: - logic-786: difficultyWeight

    @Test
    func difficultyWeight_add() {
        #expect(Operation.add.difficultyWeight == 1)
    }

    @Test
    func difficultyWeight_divide() {
        #expect(Operation.divide.difficultyWeight == 4)
    }

    // MARK: - logic-787: helpText

    @Test
    func helpText_add() {
        #expect(Operation.add.helpText.contains("together"))
    }

    @Test
    func helpText_subtract() {
        #expect(!Operation.subtract.helpText.isEmpty)
    }

    // MARK: - logic-788: isInverse

    @Test
    func isInverse_addSubtract() {
        #expect(Operation.add.isInverse(of: .subtract) == true)
    }

    @Test
    func isInverse_multiplyDivide() {
        #expect(Operation.multiply.isInverse(of: .divide) == true)
    }

    @Test
    func isInverse_addMultiply() {
        #expect(Operation.add.isInverse(of: .multiply) == false)
    }
}
