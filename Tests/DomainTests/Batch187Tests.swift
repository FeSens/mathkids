import Testing
@testable import MathKids

@Suite("Batch 187 Tests")
struct Batch187Tests {

    // MARK: - logic-1014: achievementIsGameCount

    @Test
    func achievementIsGameCount_tenGames() {
        let a = Achievement.all.first { $0.id == "ten_games" }!
        #expect(a.achievementIsGameCount == true)
    }

    @Test
    func achievementIsGameCount_streak5() {
        let a = Achievement.all.first { $0.id == "streak_5" }!
        #expect(a.achievementIsGameCount == false)
    }

    // MARK: - logic-1015: achievementPointBadge

    @Test
    func achievementPointBadge_containsNumber() {
        let a = Achievement.all[0]
        #expect(a.achievementPointBadge.contains("\(a.pointValue)"))
    }

    // MARK: - logic-1016: achievementIsAccuracyBased

    @Test
    func achievementIsAccuracyBased_accuracy90() {
        let a = Achievement.all.first { $0.id == "accuracy_90" }!
        #expect(a.achievementIsAccuracyBased == true)
    }

    @Test
    func achievementIsAccuracyBased_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsAccuracyBased == false)
    }

    // MARK: - logic-1017: categoryPluralName

    @Test
    func categoryPluralName_streak() {
        #expect(Achievement.Category.streak.categoryPluralName == "Streaks")
    }

    @Test
    func categoryPluralName_games() {
        #expect(Achievement.Category.games.categoryPluralName == "Games")
    }

    // MARK: - logic-1018: categoryIsMilestone

    @Test
    func categoryIsMilestone_games() {
        #expect(Achievement.Category.games.categoryIsMilestone == true)
    }

    @Test
    func categoryIsMilestone_streak() {
        #expect(Achievement.Category.streak.categoryIsMilestone == false)
    }
}
