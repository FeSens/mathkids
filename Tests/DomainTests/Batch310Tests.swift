import Testing
@testable import MathKids

@Suite("Batch 310 Tests")
struct Batch310Tests {

    // MARK: - logic-1629: achievementCompactDescription

    @Test
    func achievementCompactDescription() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test desc", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(!a.achievementCompactDescription.isEmpty)
        #expect(a.achievementCompactDescription.count < 50)
    }

    // MARK: - logic-1630: achievementNotificationIcon

    @Test
    func achievementNotificationIcon_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementNotificationIcon.contains("trophy"))
    }

    @Test
    func achievementNotificationIcon_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementNotificationIcon.contains("flame"))
    }

    // MARK: - logic-1631: achievementShowConfetti

    @Test
    func achievementShowConfetti_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementShowConfetti == true)
    }

    @Test
    func achievementShowConfetti_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementShowConfetti == false)
    }

    // MARK: - logic-1632: achievementDetailURL

    @Test
    func achievementDetailURL() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDetailURL.contains("streak_5"))
    }

    // MARK: - logic-1633: achievementEarnedLabel

    @Test
    func achievementEarnedLabel() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementEarnedLabel == "Not Earned")
    }
}
