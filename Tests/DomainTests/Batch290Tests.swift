import Testing
@testable import MathKids

@Suite("Batch 290 Tests")
struct Batch290Tests {

    // MARK: - logic-1529: achievementUnlockAnimation

    @Test
    func achievementUnlockAnimation_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementUnlockAnimation == "fireworks")
    }

    @Test
    func achievementUnlockAnimation_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementUnlockAnimation == "fade")
    }

    // MARK: - logic-1530: achievementAlertTitle

    @Test
    func achievementAlertTitle() {
        let a = Achievement(id: "streak_5", title: "Streak Master", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementAlertTitle.contains("Streak Master"))
    }

    // MARK: - logic-1531: achievementXpValue

    @Test
    func achievementXpValue_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementXpValue >= 100)
    }

    @Test
    func achievementXpValue_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementXpValue <= 25)
    }

    // MARK: - logic-1532: achievementIsLegendary

    @Test
    func achievementIsLegendary_rareMastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsLegendary == true)
    }

    @Test
    func achievementIsLegendary_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsLegendary == false)
    }

    // MARK: - logic-1533: achievementProgressPercentage

    @Test
    func achievementProgressPercentage_default() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressPercentage == 0)
    }
}
