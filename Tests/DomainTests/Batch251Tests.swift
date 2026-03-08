import Testing
@testable import MathKids

@Suite("Batch 251 Tests")
struct Batch251Tests {

    // MARK: - logic-1334: achievementProgressDisplayText

    @Test
    func achievementProgressDisplayText_locked() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementProgressDisplayText.lowercased().contains("locked"))
    }

    @Test
    func achievementProgressDisplayText_hasProgress() {
        let a = Achievement(id: "streak_5", title: "On Fire", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: { _ in (3, 5) })
        #expect(a.achievementProgressDisplayText == "In Progress")
    }

    // MARK: - logic-1335: achievementSortPriority

    @Test
    func achievementSortPriority_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementSortPriority == 4)
    }

    @Test
    func achievementSortPriority_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementSortPriority == 1)
    }

    @Test
    func achievementSortPriority_streak() {
        let a = Achievement(id: "streak_5", title: "Test", description: "Test", emoji: "🔥",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementSortPriority == 2)
    }

    // MARK: - logic-1336: achievementBadgeStyle

    @Test
    func achievementBadgeStyle_rare() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBadgeStyle == "epic")
    }

    @Test
    func achievementBadgeStyle_common() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementBadgeStyle == "standard")
    }

    // MARK: - logic-1337: achievementIsNewPlayerFriendly

    @Test
    func achievementIsNewPlayerFriendly_games() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsNewPlayerFriendly == true)
    }

    @Test
    func achievementIsNewPlayerFriendly_mastery() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementIsNewPlayerFriendly == false)
    }

    // MARK: - logic-1338: achievementCelebrationType

    @Test
    func achievementCelebrationType_highValue() {
        let a = Achievement(id: "easy_mastery", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCelebrationType == "fireworks")
    }

    @Test
    func achievementCelebrationType_lowValue() {
        let a = Achievement(id: "first_game", title: "Test", description: "Test", emoji: "🏆",
                            requirement: { _ in false }, progress: nil)
        #expect(a.achievementCelebrationType == "confetti")
    }
}
