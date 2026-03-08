import Testing
@testable import MathKids

@Suite("Batch 185 Tests")
struct Batch185Tests {

    // MARK: - logic-1004: achievementDescriptionLength

    @Test
    func achievementDescriptionLength_positive() {
        #expect(Achievement.all[0].achievementDescriptionLength > 0)
    }

    // MARK: - logic-1005: achievementIsHighValue

    @Test
    func achievementIsHighValue_mastery() {
        let a = Achievement.all.first { $0.category == .mastery }!
        #expect(a.achievementIsHighValue == true)
    }

    @Test
    func achievementIsHighValue_games() {
        let a = Achievement.all.first { $0.category == .games && !$0.isRareAchievement }!
        #expect(a.achievementIsHighValue == false)
    }

    // MARK: - logic-1006: achievementIdSuffix

    @Test
    func achievementIdSuffix_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIdSuffix == "game")
    }

    @Test
    func achievementIdSuffix_streak5() {
        let a = Achievement.all.first { $0.id == "streak_5" }!
        #expect(a.achievementIdSuffix == "5")
    }

    // MARK: - logic-1007: categoryAccessibilityLabel

    @Test
    func categoryAccessibilityLabel_streak() {
        #expect(Achievement.Category.streak.categoryAccessibilityLabel.contains("Streak"))
    }

    @Test
    func categoryAccessibilityLabel_mastery() {
        #expect(Achievement.Category.mastery.categoryAccessibilityLabel.contains("Mastery"))
    }

    // MARK: - logic-1008: categoryIsEndgame

    @Test
    func categoryIsEndgame_mastery() {
        #expect(Achievement.Category.mastery.categoryIsEndgame == true)
    }

    @Test
    func categoryIsEndgame_games() {
        #expect(Achievement.Category.games.categoryIsEndgame == false)
    }
}
