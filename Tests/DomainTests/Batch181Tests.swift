import Testing
@testable import MathKids

@Suite("Batch 181 Tests")
struct Batch181Tests {

    // MARK: - logic-984: achievementDifficultyLabel

    @Test
    func achievementDifficultyLabel_rare() {
        let a = Achievement.all.first { $0.isRareAchievement }!
        #expect(a.achievementDifficultyLabel == "Hard")
    }

    @Test
    func achievementDifficultyLabel_common() {
        let a = Achievement.all.first { !$0.isRareAchievement }!
        #expect(a.achievementDifficultyLabel == "Easy")
    }

    // MARK: - logic-985: achievementCategoryIcon

    @Test
    func achievementCategoryIcon_streak() {
        let a = Achievement.all.first { $0.category == .streak }!
        #expect(a.achievementCategoryIcon == "flame")
    }

    @Test
    func achievementCategoryIcon_games() {
        let a = Achievement.all.first { $0.category == .games }!
        #expect(a.achievementCategoryIcon == "gamecontroller")
    }

    // MARK: - logic-986: achievementSortKey

    @Test
    func achievementSortKey_notEmpty() {
        let a = Achievement.all[0]
        #expect(!a.achievementSortKey.isEmpty)
    }

    // MARK: - logic-987: achievementIsCommon

    @Test
    func achievementIsCommon_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsCommon == true)
    }

    @Test
    func achievementIsCommon_century() {
        let a = Achievement.all.first { $0.id == "century" }!
        #expect(a.achievementIsCommon == false)
    }

    // MARK: - logic-988: achievementAccessibilityLabel

    @Test
    func achievementAccessibilityLabel_containsTitle() {
        let a = Achievement.all[0]
        #expect(a.achievementAccessibilityLabel.contains(a.title))
    }

    @Test
    func achievementAccessibilityLabel_containsCategory() {
        let a = Achievement.all.first { $0.category == .streak }!
        #expect(a.achievementAccessibilityLabel.contains("Streak"))
    }
}
