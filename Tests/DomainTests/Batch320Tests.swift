import Testing
@testable import MathKids

@Suite("Batch 320 Tests")
struct Batch320Tests {

    // MARK: - logic-1679: achievementPreviewText

    @Test
    func achievementPreviewText() {
        let a = Achievement(id: "streak_5", title: "Hot Streak", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementPreviewText.contains("🔥"))
        #expect(a.achievementPreviewText.contains("Hot Streak"))
    }

    // MARK: - logic-1680: achievementRarityTintColor

    @Test
    func achievementRarityTintColor_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRarityTintColor == "gold")
    }

    @Test
    func achievementRarityTintColor_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRarityTintColor == "gray")
    }

    // MARK: - logic-1681: achievementIsAchievable

    @Test
    func achievementIsAchievable() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsAchievable == true)
    }

    // MARK: - logic-1682: achievementDetailDescription

    @Test
    func achievementDetailDescription() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Keep going", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDetailDescription.contains("Keep going"))
        #expect(a.achievementDetailDescription.contains(a.category.displayName))
    }

    // MARK: - logic-1683: achievementProgressTarget

    @Test
    func achievementProgressTarget_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressTarget >= 50)
    }

    @Test
    func achievementProgressTarget_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressTarget == 1)
    }
}
