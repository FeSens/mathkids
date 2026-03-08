import Testing
@testable import MathKids

@Suite("Batch 194 Tests")
struct Batch194Tests {

    // MARK: - logic-1049: operationQuizInstruction

    @Test
    func operationQuizInstruction_add() {
        #expect(Operation.add.operationQuizInstruction.contains("Find the sum"))
    }

    @Test
    func operationQuizInstruction_divide() {
        #expect(!Operation.divide.operationQuizInstruction.isEmpty)
    }

    // MARK: - logic-1050: operationHasDistributiveProperty

    @Test
    func operationHasDistributiveProperty_multiply() {
        #expect(Operation.multiply.operationHasDistributiveProperty == true)
    }

    @Test
    func operationHasDistributiveProperty_add() {
        #expect(Operation.add.operationHasDistributiveProperty == false)
    }

    // MARK: - logic-1051: operationCountingDirection

    @Test
    func operationCountingDirection_add() {
        #expect(Operation.add.operationCountingDirection == "up")
    }

    @Test
    func operationCountingDirection_subtract() {
        #expect(Operation.subtract.operationCountingDirection == "down")
    }

    // MARK: - logic-1052: operationDifficultyStars

    @Test
    func operationDifficultyStars_add() {
        #expect(Operation.add.operationDifficultyStars == 1)
    }

    @Test
    func operationDifficultyStars_divide() {
        #expect(Operation.divide.operationDifficultyStars == 4)
    }

    // MARK: - logic-1053: operationPracticeGoal

    @Test
    func operationPracticeGoal_add() {
        #expect(Operation.add.operationPracticeGoal == 20)
    }

    @Test
    func operationPracticeGoal_divide() {
        #expect(Operation.divide.operationPracticeGoal == 10)
    }
}
