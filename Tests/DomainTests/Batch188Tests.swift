import Testing
@testable import MathKids

@Suite("Batch 188 Tests")
struct Batch188Tests {

    // MARK: - logic-1019: achievementIsStreakBased

    @Test
    func achievementIsStreakBased_streak5() {
        let a = Achievement.all.first { $0.id == "streak_5" }!
        #expect(a.achievementIsStreakBased == true)
    }

    @Test
    func achievementIsStreakBased_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsStreakBased == false)
    }

    // MARK: - logic-1020: achievementCardTitle

    @Test
    func achievementCardTitle_containsEmoji() {
        let a = Achievement.all[0]
        #expect(a.achievementCardTitle.contains(a.emoji))
    }

    @Test
    func achievementCardTitle_containsTitle() {
        let a = Achievement.all[0]
        #expect(a.achievementCardTitle.contains(a.title))
    }

    // MARK: - logic-1021: categoryShortLabel

    @Test
    func categoryShortLabel_streak() {
        #expect(Achievement.Category.streak.categoryShortLabel == "S")
    }

    @Test
    func categoryShortLabel_games() {
        #expect(Achievement.Category.games.categoryShortLabel == "G")
    }

    // MARK: - logic-1022: operationResultName

    @Test
    func operationResultName_add() {
        #expect(Operation.add.operationResultName == "sum")
    }

    @Test
    func operationResultName_multiply() {
        #expect(Operation.multiply.operationResultName == "product")
    }

    // MARK: - logic-1023: operationIsCommutative

    @Test
    func operationIsCommutative_add() {
        #expect(Operation.add.operationIsCommutative == true)
    }

    @Test
    func operationIsCommutative_subtract() {
        #expect(Operation.subtract.operationIsCommutative == false)
    }
}
