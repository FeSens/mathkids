import Testing
@testable import MathKids

@Suite("Batch 203 Tests")
struct Batch203Tests {

    // MARK: - logic-1094: difficultyQuestionCount

    @Test
    func difficultyQuestionCount_easy() {
        #expect(DifficultyLevel.easy.difficultyQuestionCount == DifficultyLevel.easy.estimatedProblemsPerGame)
    }

    // MARK: - logic-1095: difficultyRankLabel

    @Test
    func difficultyRankLabel_easy() {
        #expect(DifficultyLevel.easy.difficultyRankLabel == "Bronze")
    }

    @Test
    func difficultyRankLabel_hard() {
        #expect(DifficultyLevel.hard.difficultyRankLabel == "Gold")
    }

    // MARK: - logic-1096: difficultyIsCasual

    @Test
    func difficultyIsCasual_easy() {
        #expect(DifficultyLevel.easy.difficultyIsCasual == true)
    }

    @Test
    func difficultyIsCasual_hard() {
        #expect(DifficultyLevel.hard.difficultyIsCasual == false)
    }

    // MARK: - logic-1097: difficultyLevelNumber

    @Test
    func difficultyLevelNumber_easy() {
        #expect(DifficultyLevel.easy.difficultyLevelNumber == 1)
    }

    @Test
    func difficultyLevelNumber_hard() {
        #expect(DifficultyLevel.hard.difficultyLevelNumber == 3)
    }

    // MARK: - logic-1098: difficultyWarmUpText

    @Test
    func difficultyWarmUpText_notEmpty() {
        for level in [DifficultyLevel.easy, .medium, .hard] {
            #expect(!level.difficultyWarmUpText.isEmpty)
        }
    }
}
