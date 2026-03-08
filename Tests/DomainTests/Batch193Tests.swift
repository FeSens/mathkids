import Testing
@testable import MathKids

@Suite("Batch 193 Tests")
struct Batch193Tests {

    // MARK: - logic-1044: operationGradeDescription

    @Test
    func operationGradeDescription_add() {
        #expect(Operation.add.operationGradeDescription == "1st grade")
    }

    @Test
    func operationGradeDescription_multiply() {
        #expect(Operation.multiply.operationGradeDescription == "3rd grade")
    }

    // MARK: - logic-1045: operationNumberOfOperands

    @Test
    func operationNumberOfOperands_all() {
        #expect(Operation.add.operationNumberOfOperands == 2)
        #expect(Operation.divide.operationNumberOfOperands == 2)
    }

    // MARK: - logic-1046: operationIsClosedOnNaturals

    @Test
    func operationIsClosedOnNaturals_add() {
        #expect(Operation.add.operationIsClosedOnNaturals == true)
    }

    @Test
    func operationIsClosedOnNaturals_subtract() {
        #expect(Operation.subtract.operationIsClosedOnNaturals == false)
    }

    // MARK: - logic-1047: operationTableSize

    @Test
    func operationTableSize_multiply() {
        #expect(Operation.multiply.operationTableSize == 100)
    }

    @Test
    func operationTableSize_add() {
        #expect(Operation.add.operationTableSize == 100)
    }

    // MARK: - logic-1048: operationFlashcardLabel

    @Test
    func operationFlashcardLabel_add() {
        #expect(Operation.add.operationFlashcardLabel.contains("+"))
    }

    @Test
    func operationFlashcardLabel_multiply() {
        #expect(Operation.multiply.operationFlashcardLabel.contains("x"))
    }
}
