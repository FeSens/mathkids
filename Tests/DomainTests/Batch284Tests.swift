import Testing
@testable import MathKids

@Suite("Batch 284 Tests")
struct Batch284Tests {

    // MARK: - logic-1499: achievementDifficultyEmoji

    @Test
    func achievementDifficultyEmoji_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDifficultyEmoji == "💀")
    }

    @Test
    func achievementDifficultyEmoji_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDifficultyEmoji == "😊")
    }

    // MARK: - logic-1500: achievementCategoryDescription

    @Test
    func achievementCategoryDescription_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCategoryDescription.lowercased().contains("streak"))
    }

    @Test
    func achievementCategoryDescription_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCategoryDescription.lowercased().contains("master"))
    }

    // MARK: - logic-1501: achievementUnlockEffect

    @Test
    func achievementUnlockEffect_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementUnlockEffect == "explosion")
    }

    @Test
    func achievementUnlockEffect_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementUnlockEffect == "glow")
    }

    // MARK: - logic-1502: achievementTotalRewards

    @Test
    func achievementTotalRewards_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTotalRewards == 150) // 100 coins + 5 gems * 10
    }

    @Test
    func achievementTotalRewards_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTotalRewards == 30) // 20 coins + 1 gem * 10
    }

    // MARK: - logic-1503: achievementBadgeShape

    @Test
    func achievementBadgeShape_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBadgeShape == "hexagon")
    }

    @Test
    func achievementBadgeShape_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBadgeShape == "circle")
    }
}
