import Testing
@testable import MathKids

@Suite("Batch 318 Tests")
struct Batch318Tests {

    // MARK: - logic-1669: achievementBadgeIconName

    @Test
    func achievementBadgeIconName_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBadgeIconName.contains("medal"))
    }

    @Test
    func achievementBadgeIconName_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBadgeIconName.contains("rosette"))
    }

    // MARK: - logic-1670: achievementSortable

    @Test
    func achievementSortable() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementSortable == true)
    }

    // MARK: - logic-1671: achievementDescriptionTruncated

    @Test
    func achievementDescriptionTruncated() {
        let a = Achievement(id: "streak_5", title: "Test", description: "This is a very long description that should be truncated for preview", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementDescriptionTruncated.count <= a.description.count)
    }

    // MARK: - logic-1672: achievementStarFilled

    @Test
    func achievementStarFilled_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStarFilled == true)
    }

    @Test
    func achievementStarFilled_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementStarFilled == false)
    }

    // MARK: - logic-1673: achievementProgressUnit

    @Test
    func achievementProgressUnit_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressUnit == "days")
    }

    @Test
    func achievementProgressUnit_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressUnit == "games")
    }
}
