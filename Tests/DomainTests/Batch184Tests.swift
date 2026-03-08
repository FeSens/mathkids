import Testing
@testable import MathKids

@Suite("Batch 184 Tests")
struct Batch184Tests {

    // MARK: - logic-999: achievementTitleLength

    @Test
    func achievementTitleLength_positive() {
        #expect(Achievement.all[0].achievementTitleLength > 0)
    }

    // MARK: - logic-1000: achievementHasProgress

    @Test
    func achievementHasProgress_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementHasProgress == true)
    }

    // MARK: - logic-1001: categorySortOrder

    @Test
    func categorySortOrder_streak() {
        #expect(Achievement.Category.streak.categorySortOrder == 0)
    }

    @Test
    func categorySortOrder_mastery() {
        #expect(Achievement.Category.mastery.categorySortOrder == 3)
    }

    @Test
    func categorySortOrder_score() {
        #expect(Achievement.Category.score.categorySortOrder == 1)
    }

    @Test
    func categorySortOrder_games() {
        #expect(Achievement.Category.games.categorySortOrder == 2)
    }

    // MARK: - logic-1002: categoryIsCompetitive

    @Test
    func categoryIsCompetitive_streak() {
        #expect(Achievement.Category.streak.categoryIsCompetitive == true)
    }

    @Test
    func categoryIsCompetitive_games() {
        #expect(Achievement.Category.games.categoryIsCompetitive == false)
    }

    // MARK: - logic-1003: categoryBadgeColor

    @Test
    func categoryBadgeColor_streak() {
        #expect(Achievement.Category.streak.categoryBadgeColor == "red")
    }

    @Test
    func categoryBadgeColor_mastery() {
        #expect(Achievement.Category.mastery.categoryBadgeColor == "indigo")
    }
}
