import Testing
@testable import MathKids

@Suite("Batch 302 Tests")
struct Batch302Tests {

    // MARK: - logic-1589: achievementStatLabel

    @Test
    func achievementStatLabel_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStatLabel.lowercased().contains("days"))
    }

    @Test
    func achievementStatLabel_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStatLabel.lowercased().contains("operations"))
    }

    // MARK: - logic-1590: achievementCardHeight

    @Test
    func achievementCardHeight_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardHeight == 120)
    }

    @Test
    func achievementCardHeight_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardHeight == 80)
    }

    // MARK: - logic-1591: achievementIsNew

    @Test
    func achievementIsNew() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsNew == false)
    }

    // MARK: - logic-1592: achievementProgressColor

    @Test
    func achievementProgressColor_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressColor == "purple")
    }

    @Test
    func achievementProgressColor_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressColor == "green")
    }

    // MARK: - logic-1593: achievementInfoText

    @Test
    func achievementInfoText() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementInfoText.contains("\(a.pointValue)"))
    }
}
