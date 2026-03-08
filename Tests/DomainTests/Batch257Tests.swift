import Testing
@testable import MathKids

@Suite("Batch 257 Tests")
struct Batch257Tests {

    // MARK: - logic-1364: achievementCompactLabel

    @Test
    func achievementCompactLabel() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCompactLabel.hasPrefix("🔥"))
        #expect(a.achievementCompactLabel.contains("On Fire"))
    }

    // MARK: - logic-1365: achievementIsTrackable

    @Test
    func achievementIsTrackable_withProgress() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: { _ in (1, 5) })
        #expect(a.achievementIsTrackable == true)
    }

    @Test
    func achievementIsTrackable_noProgress() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsTrackable == false)
    }

    // MARK: - logic-1366: achievementWidgetText

    @Test
    func achievementWidgetText() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementWidgetText.contains("🔥"))
        #expect(a.achievementWidgetText.contains("On Fire"))
    }

    // MARK: - logic-1367: achievementConfettiCount

    @Test
    func achievementConfettiCount_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementConfettiCount == 50)
    }

    @Test
    func achievementConfettiCount_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementConfettiCount == 20)
    }

    // MARK: - logic-1368: achievementIsSecret

    @Test
    func achievementIsSecret_lockedMastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsSecret == true)
    }

    @Test
    func achievementIsSecret_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsSecret == false)
    }
}
