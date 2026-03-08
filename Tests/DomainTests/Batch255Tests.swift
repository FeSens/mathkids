import Testing
@testable import MathKids

@Suite("Batch 255 Tests")
struct Batch255Tests {

    // MARK: - logic-1354: achievementCollectionGroup

    @Test
    func achievementCollectionGroup_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCollectionGroup == "Skill")
    }

    @Test
    func achievementCollectionGroup_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCollectionGroup == "Activity")
    }

    // MARK: - logic-1355: achievementRarityStars

    @Test
    func achievementRarityStars_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRarityStars == 5)
    }

    @Test
    func achievementRarityStars_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRarityStars == 1)
    }

    // MARK: - logic-1356: achievementCardSubtitle

    @Test
    func achievementCardSubtitle() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCardSubtitle.contains("Streak"))
        #expect(a.achievementCardSubtitle.contains("Silver"))
    }

    // MARK: - logic-1357: achievementIsCompletable

    @Test
    func achievementIsCompletable_withProgress() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: { _ in (1, 5) })
        #expect(a.achievementIsCompletable == true)
    }

    @Test
    func achievementIsCompletable_noProgress() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsCompletable == false)
    }

    // MARK: - logic-1358: achievementTrophyType

    @Test
    func achievementTrophyType_platinum() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTrophyType == "💎")
    }

    @Test
    func achievementTrophyType_bronze() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTrophyType == "🥉")
    }
}
