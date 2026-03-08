import Testing
@testable import MathKids

@Suite("Batch 201 Tests")
struct Batch201Tests {

    // MARK: - logic-1084: difficultyPreviousLevelName

    @Test
    func difficultyPreviousLevelName_medium() {
        #expect(DifficultyLevel.medium.difficultyPreviousLevelName == "Easy")
    }

    @Test
    func difficultyPreviousLevelName_easy() {
        #expect(DifficultyLevel.easy.difficultyPreviousLevelName == nil)
    }

    // MARK: - logic-1085: difficultyTimePerQuestion

    @Test
    func difficultyTimePerQuestion_easy() {
        #expect(DifficultyLevel.easy.difficultyTimePerQuestion == DifficultyLevel.easy.recommendedSecondsPerProblem)
    }

    // MARK: - logic-1086: difficultyIsLocked

    @Test
    func difficultyIsLocked_easy() {
        #expect(DifficultyLevel.easy.difficultyIsLocked == false)
    }

    @Test
    func difficultyIsLocked_hard() {
        #expect(DifficultyLevel.hard.difficultyIsLocked == true)
    }

    // MARK: - logic-1087: difficultyXpBonusLabel

    @Test
    func difficultyXpBonusLabel_containsMultiplier() {
        #expect(DifficultyLevel.hard.difficultyXpBonusLabel.contains("x"))
    }

    // MARK: - logic-1088: difficultyOperationCountLabel

    @Test
    func difficultyOperationCountLabel_containsOperations() {
        #expect(DifficultyLevel.easy.difficultyOperationCountLabel.contains("operations"))
    }
}
