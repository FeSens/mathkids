import Testing
@testable import MathKids

@Suite("Batch 354 Tests")
struct Batch354Tests {

    // MARK: - logic-1849: achievementCardRibbonStyle

    @Test
    func achievementCardRibbonStyle_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRibbonStyle == "banner")
    }

    @Test
    func achievementCardRibbonStyle_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardRibbonStyle == "tag")
    }

    // MARK: - logic-1850: achievementEstimatedMinutes

    @Test
    func achievementEstimatedMinutes_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementEstimatedMinutes >= 300)
    }

    @Test
    func achievementEstimatedMinutes_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementEstimatedMinutes <= 10)
    }

    // MARK: - logic-1851: achievementCardBadgeShape

    @Test
    func achievementCardBadgeShape_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardBadgeShape == "hexagon")
    }

    @Test
    func achievementCardBadgeShape_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardBadgeShape == "circle")
    }

    // MARK: - logic-1852: achievementIsEngagementBased

    @Test
    func achievementIsEngagementBased_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsEngagementBased == true)
    }

    @Test
    func achievementIsEngagementBased_score() {
        let a = Achievement(id: "score_10", title: "Test", description: "Test", emoji: "🎯",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsEngagementBased == false)
    }

    // MARK: - logic-1853: achievementCardProgressText

    @Test
    func achievementCardProgressText() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardProgressText.contains(a.category.displayName))
    }
}
