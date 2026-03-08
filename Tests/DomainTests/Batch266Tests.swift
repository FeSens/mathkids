import Testing
@testable import MathKids

@Suite("Batch 266 Tests")
struct Batch266Tests {

    // MARK: - logic-1409: achievementMinWidth

    @Test
    func achievementMinWidth_large() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMinWidth == 300)
    }

    @Test
    func achievementMinWidth_small() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMinWidth == 100)
    }

    // MARK: - logic-1410: achievementMaxWidth

    @Test
    func achievementMaxWidth_large() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMaxWidth == 600)
    }

    @Test
    func achievementMaxWidth_small() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementMaxWidth == 200)
    }

    // MARK: - logic-1411: achievementIconBackgroundColor

    @Test
    func achievementIconBackgroundColor_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIconBackgroundColor == "lightOrange")
    }

    @Test
    func achievementIconBackgroundColor_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIconBackgroundColor == "lightPurple")
    }

    // MARK: - logic-1412: achievementPulseSpeed

    @Test
    func achievementPulseSpeed_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementPulseSpeed == "fast")
    }

    @Test
    func achievementPulseSpeed_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementPulseSpeed == "slow")
    }

    // MARK: - logic-1413: achievementShowCheckmark

    @Test
    func achievementShowCheckmark_withProgress() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: { _ in (1, 5) })
        #expect(a.achievementShowCheckmark == true)
    }

    @Test
    func achievementShowCheckmark_locked() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementShowCheckmark == false)
    }
}
