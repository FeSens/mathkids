import Testing
@testable import MathKids

@Suite("Batch 186 Tests")
struct Batch186Tests {

    // MARK: - logic-1009: achievementRequiresMultipleGames

    @Test
    func achievementRequiresMultipleGames_tenGames() {
        let a = Achievement.all.first { $0.id == "ten_games" }!
        #expect(a.achievementRequiresMultipleGames == true)
    }

    @Test
    func achievementRequiresMultipleGames_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementRequiresMultipleGames == false)
    }

    // MARK: - logic-1010: achievementShareMessage

    @Test
    func achievementShareMessage_containsTitle() {
        let a = Achievement.all[0]
        #expect(a.achievementShareMessage.contains(a.title))
    }

    @Test
    func achievementShareMessage_containsDescription() {
        let a = Achievement.all[0]
        #expect(a.achievementShareMessage.contains(a.description))
    }

    // MARK: - logic-1011: achievementNotificationTitle

    @Test
    func achievementNotificationTitle_format() {
        let a = Achievement.all[0]
        #expect(a.achievementNotificationTitle.contains("Achievement Unlocked"))
    }

    // MARK: - logic-1012: achievementNotificationBody

    @Test
    func achievementNotificationBody_containsTitle() {
        let a = Achievement.all[0]
        #expect(a.achievementNotificationBody.contains(a.title))
    }

    // MARK: - logic-1013: categoryDisplayOrder

    @Test
    func categoryDisplayOrder_games() {
        #expect(Achievement.Category.games.categoryDisplayOrder == 0)
    }

    @Test
    func categoryDisplayOrder_mastery() {
        #expect(Achievement.Category.mastery.categoryDisplayOrder == 3)
    }
}
