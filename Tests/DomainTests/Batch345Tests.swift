import Testing
@testable import MathKids

@Suite("Batch 345 Tests")
struct Batch345Tests {

    // MARK: - logic-1804: achievementCardStatusText

    @Test
    func achievementCardStatusText_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardStatusText.contains("Rare"))
    }

    @Test
    func achievementCardStatusText_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardStatusText == "Achievement")
    }

    // MARK: - logic-1805: achievementDaysToComplete

    @Test
    func achievementDaysToComplete_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDaysToComplete >= 30)
    }

    @Test
    func achievementDaysToComplete_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDaysToComplete == 1)
    }

    // MARK: - logic-1806: achievementCardProgressStyle

    @Test
    func achievementCardProgressStyle_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardProgressStyle == "circular")
    }

    @Test
    func achievementCardProgressStyle_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardProgressStyle == "step")
    }

    // MARK: - logic-1807: achievementIsSpeedBased

    @Test
    func achievementIsSpeedBased_score() {
        let a = Achievement(id: "score_10", title: "Test", description: "Test", emoji: "🎯",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsSpeedBased == true)
    }

    @Test
    func achievementIsSpeedBased_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsSpeedBased == false)
    }

    // MARK: - logic-1808: achievementCardRewardIcon

    @Test
    func achievementCardRewardIcon_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRewardIcon == "crown")
    }

    @Test
    func achievementCardRewardIcon_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRewardIcon.contains("flame"))
    }
}
