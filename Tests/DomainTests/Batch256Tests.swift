import Testing
@testable import MathKids

@Suite("Batch 256 Tests")
struct Batch256Tests {

    // MARK: - logic-1359: achievementSearchKeywords

    @Test
    func achievementSearchKeywords() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Get a streak", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        let keywords = a.achievementSearchKeywords
        #expect(keywords.contains("On Fire"))
        #expect(keywords.contains("Streak"))
    }

    // MARK: - logic-1360: achievementDisplayOrder

    @Test
    func achievementDisplayOrder_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Master", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDisplayOrder.hasPrefix("4"))
    }

    @Test
    func achievementDisplayOrder_games() {
        let a = Achievement(id: "first_game", title: "Starter", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDisplayOrder.hasPrefix("1"))
    }

    // MARK: - logic-1361: achievementIsFeatured

    @Test
    func achievementIsFeatured_true() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsFeatured == true)
    }

    @Test
    func achievementIsFeatured_false() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsFeatured == false)
    }

    // MARK: - logic-1362: achievementUnlockMessage

    @Test
    func achievementUnlockMessage() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementUnlockMessage.contains("On Fire"))
        #expect(a.achievementUnlockMessage.contains("points"))
    }

    // MARK: - logic-1363: achievementCardFooter

    @Test
    func achievementCardFooter() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardFooter.contains("\(a.pointValue)"))
    }
}
