import Testing
@testable import MathKids

@Suite("Batch 249 Tests")
struct Batch249Tests {

    // MARK: - logic-1324: achievementRarityColor

    @Test
    func achievementRarityColor_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRarityColor == "purple")
    }

    @Test
    func achievementRarityColor_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRarityColor == "blue")
    }

    // MARK: - logic-1325: achievementIsStreakRelated

    @Test
    func achievementIsStreakRelated_true() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsStreakRelated == true)
    }

    @Test
    func achievementIsStreakRelated_false() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsStreakRelated == false)
    }

    // MARK: - logic-1326: achievementIconSystemName

    @Test
    func achievementIconSystemName_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIconSystemName == "flame.fill")
    }

    @Test
    func achievementIconSystemName_score() {
        let a = Achievement(id: "score_100", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIconSystemName == "trophy.fill")
    }

    // MARK: - logic-1327: achievementShareText

    @Test
    func achievementShareText() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementShareText.contains("On Fire"))
        #expect(a.achievementShareText.contains("🔥"))
    }

    // MARK: - logic-1328: achievementNotificationMessage

    @Test
    func achievementNotificationMessage() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementNotificationMessage.lowercased().contains("achievement"))
    }
}
