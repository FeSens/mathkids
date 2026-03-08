import Testing
@testable import MathKids

@Suite("Batch 338 Tests")
struct Batch338Tests {

    // MARK: - logic-1769: achievementCardGlowColor

    @Test
    func achievementCardGlowColor_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardGlowColor == "gold")
    }

    @Test
    func achievementCardGlowColor_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardGlowColor == "clear")
    }

    // MARK: - logic-1770: achievementMasteryPercentage

    @Test
    func achievementMasteryPercentage_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMasteryPercentage == 100)
    }

    @Test
    func achievementMasteryPercentage_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMasteryPercentage == 0)
    }

    // MARK: - logic-1771: achievementCardRibbonColor

    @Test
    func achievementCardRibbonColor_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRibbonColor == "purple")
    }

    @Test
    func achievementCardRibbonColor_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRibbonColor == "red")
    }

    // MARK: - logic-1772: achievementIsExclusiveReward

    @Test
    func achievementIsExclusiveReward_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsExclusiveReward == true)
    }

    @Test
    func achievementIsExclusiveReward_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsExclusiveReward == false)
    }

    // MARK: - logic-1773: achievementOneLinerSummary

    @Test
    func achievementOneLinerSummary() {
        let a = Achievement(id: "streak_5", title: "Hot Streak", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementOneLinerSummary.contains("Hot Streak"))
        #expect(a.achievementOneLinerSummary.contains(a.category.displayName))
    }
}
