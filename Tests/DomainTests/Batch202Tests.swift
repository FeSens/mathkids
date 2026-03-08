import Testing
@testable import MathKids

@Suite("Batch 202 Tests")
struct Batch202Tests {

    // MARK: - logic-1089: difficultyProgressBarSegments

    @Test
    func difficultyProgressBarSegments_easy() {
        #expect(DifficultyLevel.easy.difficultyProgressBarSegments == 3)
    }

    @Test
    func difficultyProgressBarSegments_hard() {
        #expect(DifficultyLevel.hard.difficultyProgressBarSegments == 5)
    }

    // MARK: - logic-1090: difficultyEncouragementMessage

    @Test
    func difficultyEncouragementMessage_notEmpty() {
        for level in [DifficultyLevel.easy, .medium, .hard] {
            #expect(!level.difficultyEncouragementMessage.isEmpty)
        }
    }

    // MARK: - logic-1091: difficultyTotalTimeDisplay

    @Test
    func difficultyTotalTimeDisplay_containsTime() {
        let display = DifficultyLevel.easy.difficultyTotalTimeDisplay
        #expect(display.contains("s") || display.contains("min"))
    }

    // MARK: - logic-1092: difficultyIsMaxLevel

    @Test
    func difficultyIsMaxLevel_hard() {
        #expect(DifficultyLevel.hard.difficultyIsMaxLevel == true)
    }

    @Test
    func difficultyIsMaxLevel_easy() {
        #expect(DifficultyLevel.easy.difficultyIsMaxLevel == false)
    }

    // MARK: - logic-1093: difficultySelectionLabel

    @Test
    func difficultySelectionLabel_containsName() {
        let label = DifficultyLevel.easy.difficultySelectionLabel
        #expect(label.contains("Easy"))
    }

    @Test
    func difficultySelectionLabel_containsEmoji() {
        let label = DifficultyLevel.easy.difficultySelectionLabel
        #expect(label.contains("🟢"))
    }
}
