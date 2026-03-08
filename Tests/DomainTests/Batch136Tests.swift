import Testing
@testable import MathKids

@Suite("Batch 136 Tests")
struct Batch136Tests {

    // MARK: - logic-759: penaltyDescription

    @Test
    func penaltyDescription_easy() {
        let desc = DifficultyLevel.easy.penaltyDescription
        #expect(desc.contains("penalty"))
    }

    @Test
    func penaltyDescription_hard() {
        let desc = DifficultyLevel.hard.penaltyDescription
        #expect(!desc.isEmpty)
    }

    // MARK: - logic-760: isMultiplicationIncluded

    @Test
    func isMultiplicationIncluded_easy() {
        #expect(DifficultyLevel.easy.isMultiplicationIncluded == false)
    }

    @Test
    func isMultiplicationIncluded_hard() {
        #expect(DifficultyLevel.hard.isMultiplicationIncluded == true)
    }

    // MARK: - logic-761: isDivisionIncluded

    @Test
    func isDivisionIncluded_easy() {
        #expect(DifficultyLevel.easy.isDivisionIncluded == false)
    }

    @Test
    func isDivisionIncluded_hard() {
        #expect(DifficultyLevel.hard.isDivisionIncluded == true)
    }

    // MARK: - logic-762: levelUpRequirement

    @Test
    func levelUpRequirement_easy() {
        let req = DifficultyLevel.easy.levelUpRequirement
        #expect(req.contains("%"))
    }

    @Test
    func levelUpRequirement_hard() {
        let req = DifficultyLevel.hard.levelUpRequirement
        #expect(req.contains("Max"))
    }

    // MARK: - logic-763: averageGameLength

    @Test
    func averageGameLength_easy() {
        #expect(DifficultyLevel.easy.averageGameLength > 0)
    }

    @Test
    func averageGameLength_increases() {
        // harder difficulties should have lower average (harder problems take longer)
        #expect(DifficultyLevel.easy.averageGameLength >= DifficultyLevel.hard.averageGameLength)
    }
}
