import Testing
@testable import MathKids

@Suite("Batch 252 Tests")
struct Batch252Tests {

    // MARK: - logic-1339: achievementDescriptionWithPoints

    @Test
    func achievementDescriptionWithPoints() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Get a streak", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDescriptionWithPoints.contains("Get a streak"))
        #expect(a.achievementDescriptionWithPoints.contains("points"))
    }

    // MARK: - logic-1340: achievementIsHighValue

    @Test
    func achievementIsHighValue_true() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsHighValueReward == true)
    }

    @Test
    func achievementIsHighValue_false() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsHighValueReward == false)
    }

    // MARK: - logic-1341: achievementDisplaySize

    @Test
    func achievementDisplaySize_large() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDisplaySize == "large")
    }

    @Test
    func achievementDisplaySize_small() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDisplaySize == "small")
    }

    // MARK: - logic-1342: achievementTooltipText

    @Test
    func achievementTooltipText() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Get a streak", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementTooltipText.contains("🔥"))
        #expect(a.achievementTooltipText.contains("On Fire"))
        #expect(a.achievementTooltipText.contains("Get a streak"))
    }

    // MARK: - logic-1343: achievementUnlockSound

    @Test
    func achievementUnlockSound_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementUnlockSound == "fanfare")
    }

    @Test
    func achievementUnlockSound_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementUnlockSound == "chime")
    }
}
