import Testing
@testable import MathKids

@Suite("Batch 200 Tests")
struct Batch200Tests {

    // MARK: - logic-1079: difficultyTimerWarningThreshold

    @Test
    func difficultyTimerWarningThreshold_easy() {
        #expect(DifficultyLevel.easy.difficultyTimerWarningThreshold == 30)
    }

    @Test
    func difficultyTimerWarningThreshold_hard() {
        #expect(DifficultyLevel.hard.difficultyTimerWarningThreshold == 15)
    }

    // MARK: - logic-1080: difficultyStarString

    @Test
    func difficultyStarString_easy() {
        #expect(DifficultyLevel.easy.difficultyStarString == "★")
    }

    @Test
    func difficultyStarString_hard() {
        #expect(DifficultyLevel.hard.difficultyStarString == "★★★")
    }

    // MARK: - logic-1081: difficultyShortDescription

    @Test
    func difficultyShortDescription_easy() {
        #expect(DifficultyLevel.easy.difficultyShortDescription == "Simple")
    }

    @Test
    func difficultyShortDescription_hard() {
        #expect(DifficultyLevel.hard.difficultyShortDescription == "Challenging")
    }

    // MARK: - logic-1082: difficultyHasTimePressure

    @Test
    func difficultyHasTimePressure_hard() {
        #expect(DifficultyLevel.hard.difficultyHasTimePressure == true)
    }

    @Test
    func difficultyHasTimePressure_easy() {
        #expect(DifficultyLevel.easy.difficultyHasTimePressure == false)
    }

    // MARK: - logic-1083: difficultyNextLevelName

    @Test
    func difficultyNextLevelName_easy() {
        #expect(DifficultyLevel.easy.difficultyNextLevelName == "Medium")
    }

    @Test
    func difficultyNextLevelName_hard() {
        #expect(DifficultyLevel.hard.difficultyNextLevelName == nil)
    }
}
