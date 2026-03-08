import Testing
@testable import MathKids

@Suite("Batch 288 Tests")
struct Batch288Tests {

    // MARK: - logic-1519: achievementCompletionMessage

    @Test
    func achievementCompletionMessage_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCompletionMessage.lowercased().contains("congratulations"))
    }

    @Test
    func achievementCompletionMessage_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCompletionMessage.lowercased().contains("well done"))
    }

    // MARK: - logic-1520: achievementSortWeight

    @Test
    func achievementSortWeight_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementSortWeight >= 100)
    }

    @Test
    func achievementSortWeight_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementSortWeight < 50)
    }

    // MARK: - logic-1521: achievementIconSize

    @Test
    func achievementIconSize_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIconSize == 48)
    }

    @Test
    func achievementIconSize_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIconSize == 24)
    }

    // MARK: - logic-1522: achievementRetryAllowed

    @Test
    func achievementRetryAllowed_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRetryAllowed == true)
    }

    @Test
    func achievementRetryAllowed_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRetryAllowed == true)
    }

    // MARK: - logic-1523: achievementDisplayBadgeCount

    @Test
    func achievementDisplayBadgeCount_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDisplayBadgeCount > 1)
    }

    @Test
    func achievementDisplayBadgeCount_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDisplayBadgeCount == 1)
    }
}
