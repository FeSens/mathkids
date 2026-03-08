import Testing
@testable import MathKids

@Suite("Batch 342 Tests")
struct Batch342Tests {

    // MARK: - logic-1789: achievementCardEmojiOffset

    @Test
    func achievementCardEmojiOffset_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardEmojiOffset < 0)
    }

    @Test
    func achievementCardEmojiOffset_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardEmojiOffset == 0)
    }

    // MARK: - logic-1790: achievementStreakMultiplierValue

    @Test
    func achievementStreakMultiplierValue_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStreakMultiplierValue > 1.0)
    }

    @Test
    func achievementStreakMultiplierValue_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStreakMultiplierValue == 1.0)
    }

    // MARK: - logic-1791: achievementCardBorderColor

    @Test
    func achievementCardBorderColor_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardBorderColor == "indigo")
    }

    @Test
    func achievementCardBorderColor_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardBorderColor == "gray")
    }

    // MARK: - logic-1792: achievementIsGoalOriented

    @Test
    func achievementIsGoalOriented_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsGoalOriented == true)
    }

    @Test
    func achievementIsGoalOriented_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsGoalOriented == false)
    }

    // MARK: - logic-1793: achievementCardInfoLabel

    @Test
    func achievementCardInfoLabel() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardInfoLabel.contains(a.category.displayName))
        #expect(a.achievementCardInfoLabel.contains("pts"))
    }
}
