import Testing
@testable import MathKids

@Suite("Batch 341 Tests")
struct Batch341Tests {

    // MARK: - logic-1784: achievementCardTagColor

    @Test
    func achievementCardTagColor_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardTagColor == "purple")
    }

    @Test
    func achievementCardTagColor_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardTagColor == "red")
    }

    // MARK: - logic-1785: achievementMinGamesPlayed

    @Test
    func achievementMinGamesPlayed_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMinGamesPlayed >= 10)
    }

    @Test
    func achievementMinGamesPlayed_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMinGamesPlayed == 1)
    }

    // MARK: - logic-1786: achievementCardLayoutMode

    @Test
    func achievementCardLayoutMode_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardLayoutMode == "expanded")
    }

    @Test
    func achievementCardLayoutMode_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardLayoutMode == "compact")
    }

    // MARK: - logic-1787: achievementIsEnduranceBased

    @Test
    func achievementIsEnduranceBased_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsEnduranceBased == true)
    }

    @Test
    func achievementIsEnduranceBased_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsEnduranceBased == false)
    }

    // MARK: - logic-1788: achievementCardSubtitleText

    @Test
    func achievementCardSubtitleText() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardSubtitleText.contains(a.category.displayName))
    }
}
