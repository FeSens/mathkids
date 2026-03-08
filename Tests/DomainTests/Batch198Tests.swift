import Testing
@testable import MathKids

@Suite("Batch 198 Tests")
struct Batch198Tests {

    // MARK: - logic-1069: difficultyShareText

    @Test
    func difficultyShareText_containsName() {
        #expect(DifficultyLevel.easy.difficultyShareText.contains("Easy"))
    }

    // MARK: - logic-1070: difficultyIsAdvanced

    @Test
    func difficultyIsAdvanced_hard() {
        #expect(DifficultyLevel.hard.difficultyIsAdvanced == true)
    }

    @Test
    func difficultyIsAdvanced_easy() {
        #expect(DifficultyLevel.easy.difficultyIsAdvanced == false)
    }

    // MARK: - logic-1071: difficultyRewardMultiplier

    @Test
    func difficultyRewardMultiplier_easy() {
        #expect(DifficultyLevel.easy.difficultyRewardMultiplier == 1)
    }

    @Test
    func difficultyRewardMultiplier_hard() {
        #expect(DifficultyLevel.hard.difficultyRewardMultiplier == 3)
    }

    // MARK: - logic-1072: difficultyIconName

    @Test
    func difficultyIconName_notEmpty() {
        for level in [DifficultyLevel.easy, .medium, .hard] {
            #expect(!level.difficultyIconName.isEmpty)
        }
    }

    // MARK: - logic-1073: difficultyCompletionMessage

    @Test
    func difficultyCompletionMessage_notEmpty() {
        for level in [DifficultyLevel.easy, .medium, .hard] {
            #expect(!level.difficultyCompletionMessage.isEmpty)
        }
    }
}
