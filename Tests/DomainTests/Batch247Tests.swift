import Testing
@testable import MathKids

@Suite("Batch 247 Tests")
struct Batch247Tests {

    // MARK: - logic-1314: achievementTitleWithEmoji

    @Test
    func achievementTitleWithEmoji() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTitleWithEmoji == "🔥 On Fire")
    }

    // MARK: - logic-1315: achievementIsLocked

    @Test
    func achievementIsLocked_noProgress() {
        let a = Achievement(id: "test", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsLocked == true)
    }

    // MARK: - logic-1316: achievementCardColor

    @Test
    func achievementCardColor_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardColor == "orange")
    }

    @Test
    func achievementCardColor_score() {
        let a = Achievement(id: "score_100", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardColor == "blue")
    }

    // MARK: - logic-1317: achievementRewardText

    @Test
    func achievementRewardText_containsPoints() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRewardText.contains("points"))
    }

    // MARK: - logic-1318: achievementIsEpic

    @Test
    func achievementIsEpic_true() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsEpic == true)
    }

    @Test
    func achievementIsEpic_false() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsEpic == false)
    }
}
