import Testing
@testable import MathKids

@Suite("Batch 196 Tests")
struct Batch196Tests {

    // MARK: - logic-1059: difficultyEmoji

    @Test
    func difficultyEmoji_easy() {
        #expect(DifficultyLevel.easy.difficultyEmoji == "🟢")
    }

    @Test
    func difficultyEmoji_hard() {
        #expect(DifficultyLevel.hard.difficultyEmoji == "🔴")
    }

    // MARK: - logic-1060: difficultyStarRating

    @Test
    func difficultyStarRating_easy() {
        #expect(DifficultyLevel.easy.difficultyStarRating == 1)
    }

    @Test
    func difficultyStarRating_hard() {
        #expect(DifficultyLevel.hard.difficultyStarRating == 3)
    }

    // MARK: - logic-1061: difficultyCardLabel

    @Test
    func difficultyCardLabel_easy() {
        #expect(DifficultyLevel.easy.difficultyCardLabel.contains(DifficultyLevel.easy.displayName))
    }

    // MARK: - logic-1062: difficultyMotivationText

    @Test
    func difficultyMotivationText_notEmpty() {
        for level in [DifficultyLevel.easy, .medium, .hard] {
            #expect(!level.difficultyMotivationText.isEmpty)
        }
    }

    // MARK: - logic-1063: difficultyIsDefault

    @Test
    func difficultyIsDefault_easy() {
        #expect(DifficultyLevel.easy.difficultyIsDefault == true)
    }

    @Test
    func difficultyIsDefault_hard() {
        #expect(DifficultyLevel.hard.difficultyIsDefault == false)
    }
}
