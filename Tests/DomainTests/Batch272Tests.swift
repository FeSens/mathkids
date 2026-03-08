import Testing
@testable import MathKids

@Suite("Batch 272 Tests")
struct Batch272Tests {

    // MARK: - logic-1439: achievementStreakIcon

    @Test
    func achievementStreakIcon_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStreakIcon == "flame")
    }

    @Test
    func achievementStreakIcon_nonStreak() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStreakIcon == "")
    }

    // MARK: - logic-1440: achievementCompletionPercentageLabel

    @Test
    func achievementCompletionPercentageLabel_locked() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCompletionPercentageLabel == "0%")
    }

    @Test
    func achievementCompletionPercentageLabel_hasProgress() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: { _ in (1, 5) })
        #expect(a.achievementCompletionPercentageLabel != "0%")
    }

    // MARK: - logic-1441: achievementTierBadgeColor

    @Test
    func achievementTierBadgeColor_platinum() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTierBadgeColor == "platinum")
    }

    @Test
    func achievementTierBadgeColor_bronze() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTierBadgeColor == "bronze")
    }

    // MARK: - logic-1442: achievementShowTimer

    @Test
    func achievementShowTimer_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementShowTimer == true)
    }

    @Test
    func achievementShowTimer_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementShowTimer == false)
    }

    // MARK: - logic-1443: achievementCardGradientStart

    @Test
    func achievementCardGradientStart_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardGradientStart == "lightOrange")
    }

    @Test
    func achievementCardGradientStart_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardGradientStart == "lightPurple")
    }
}
