import Testing
@testable import MathKids

@Suite("Batch 271 Tests")
struct Batch271Tests {

    // MARK: - logic-1434: achievementTimeEstimate

    @Test
    func achievementTimeEstimate_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTimeEstimate == 60)
    }

    @Test
    func achievementTimeEstimate_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTimeEstimate == 10)
    }

    // MARK: - logic-1435: achievementBannerText

    @Test
    func achievementBannerText() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBannerText.contains("🔥"))
        #expect(a.achievementBannerText.contains("On Fire"))
    }

    // MARK: - logic-1436: achievementIsDailyChallenge

    @Test
    func achievementIsDailyChallenge_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsDailyChallenge == true)
    }

    @Test
    func achievementIsDailyChallenge_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsDailyChallenge == false)
    }

    // MARK: - logic-1437: achievementOutlineColor

    @Test
    func achievementOutlineColor_locked() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementOutlineColor == "gray")
    }

    @Test
    func achievementOutlineColor_unlocked() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: { _ in (1, 5) })
        #expect(a.achievementOutlineColor == "orange")
    }

    // MARK: - logic-1438: achievementXpMultiplier

    @Test
    func achievementXpMultiplier_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementXpMultiplier == 2.0)
    }

    @Test
    func achievementXpMultiplier_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementXpMultiplier == 1.0)
    }
}
