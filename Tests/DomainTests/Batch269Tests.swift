import Testing
@testable import MathKids

@Suite("Batch 269 Tests")
struct Batch269Tests {

    // MARK: - logic-1424: achievementRotationAngle

    @Test
    func achievementRotationAngle_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRotationAngle == 2)
    }

    @Test
    func achievementRotationAngle_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementRotationAngle == 0)
    }

    // MARK: - logic-1425: achievementStatusLabel

    @Test
    func achievementStatusLabel_locked() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStatusLabel == "Locked")
    }

    @Test
    func achievementStatusLabel_inProgress() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: { _ in (1, 5) })
        #expect(a.achievementStatusLabel == "In Progress")
    }

    // MARK: - logic-1426: achievementCategoryColorHex

    @Test
    func achievementCategoryColorHex_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCategoryColorHex == "FF8C00")
    }

    @Test
    func achievementCategoryColorHex_score() {
        let a = Achievement(id: "score_100", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCategoryColorHex == "007AFF")
    }

    // MARK: - logic-1427: achievementPreviewSummary

    @Test
    func achievementPreviewSummary() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementPreviewSummary.contains("On Fire"))
        #expect(a.achievementPreviewSummary.contains("pts"))
    }

    // MARK: - logic-1428: achievementIsPinnable

    @Test
    func achievementIsPinnable_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsPinnable == true)
    }

    @Test
    func achievementIsPinnable_secretMastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsPinnable == false)
    }
}
