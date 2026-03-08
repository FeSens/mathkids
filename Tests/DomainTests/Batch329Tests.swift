import Testing
@testable import MathKids

@Suite("Batch 329 Tests")
struct Batch329Tests {

    // MARK: - logic-1724: achievementStatsSummary

    @Test
    func achievementStatsSummary() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStatsSummary.contains(a.category.displayName))
        #expect(a.achievementStatsSummary.contains("pts"))
    }

    // MARK: - logic-1725: achievementCardRadius

    @Test
    func achievementCardRadius_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRadius >= 12)
    }

    @Test
    func achievementCardRadius_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRadius <= 10)
    }

    // MARK: - logic-1726: achievementIsDailyQuest

    @Test
    func achievementIsDailyQuest_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsDailyQuest == true)
    }

    @Test
    func achievementIsDailyQuest_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsDailyQuest == false)
    }

    // MARK: - logic-1727: achievementBadgeTag

    @Test
    func achievementBadgeTag() {
        let a = Achievement(id: "streak_5", title: "Hot Streak", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBadgeTag.contains("🔥"))
        #expect(a.achievementBadgeTag.contains("Hot Streak"))
    }

    // MARK: - logic-1728: achievementEffortDescription

    @Test
    func achievementEffortDescription_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementEffortDescription.lowercased().contains("practice"))
    }

    @Test
    func achievementEffortDescription_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementEffortDescription.lowercased().contains("playing"))
    }
}
