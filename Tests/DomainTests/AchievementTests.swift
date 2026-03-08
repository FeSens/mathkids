import Testing
@testable import MathKids

@Suite("Achievement Tests")
struct AchievementTests {
    @Test("All achievements have unique IDs")
    func uniqueIds() {
        let ids = Achievement.all.map(\.id)
        let uniqueIds = Set(ids)
        #expect(ids.count == uniqueIds.count)
    }

    @Test("First Game achievement unlocks after 1 game")
    func firstGameUnlocks() {
        let stats = PlayerStats()
        let achievement = Achievement.all.first { $0.id == "first_game" }!
        #expect(!achievement.isUnlocked(stats: stats))

        stats.gamesPlayed = 1
        #expect(achievement.isUnlocked(stats: stats))
    }

    @Test("Streak Master unlocks at 10 streak")
    func streakMaster() {
        let stats = PlayerStats()
        let achievement = Achievement.all.first { $0.id == "streak_10" }!
        stats.bestStreak = 9
        #expect(!achievement.isUnlocked(stats: stats))

        stats.bestStreak = 10
        #expect(achievement.isUnlocked(stats: stats))
    }

    @Test("Century Club unlocks at 100 solved")
    func centuryClub() {
        let stats = PlayerStats()
        let achievement = Achievement.all.first { $0.id == "century" }!
        stats.totalSolved = 99
        #expect(!achievement.isUnlocked(stats: stats))

        stats.totalSolved = 100
        #expect(achievement.isUnlocked(stats: stats))
    }

    @Test("Speed Demon unlocks after hard game")
    func speedDemon() {
        let stats = PlayerStats()
        let achievement = Achievement.all.first { $0.id == "hard_player" }!
        #expect(!achievement.isUnlocked(stats: stats))

        stats.hardGamesPlayed = 1
        #expect(achievement.isUnlocked(stats: stats))
    }

    @Test("Sharp Mind requires both accuracy and volume")
    func sharpMind() {
        let stats = PlayerStats()
        let achievement = Achievement.all.first { $0.id == "accuracy_90" }!

        // High accuracy but low volume
        stats.totalSolved = 10
        stats.totalCorrect = 10
        #expect(!achievement.isUnlocked(stats: stats))

        // Enough volume with high accuracy
        stats.totalSolved = 50
        stats.totalCorrect = 46
        #expect(achievement.isUnlocked(stats: stats))
    }

    @Test("High Scorer unlocks at 100 points")
    func highScorer() {
        let stats = PlayerStats()
        let achievement = Achievement.all.first { $0.id == "score_100" }!
        stats.bestScore = 99
        #expect(!achievement.isUnlocked(stats: stats))

        stats.bestScore = 100
        #expect(achievement.isUnlocked(stats: stats))
    }

    @Test("There are 15 achievements defined")
    func achievementCount() {
        #expect(Achievement.all.count == 15)
    }

    @Test("All achievements have progress functions")
    func allHaveProgress() {
        for achievement in Achievement.all {
            #expect(achievement.progress != nil, "Achievement \(achievement.id) missing progress")
        }
    }

    @Test("Progress returns correct values for ten_games")
    func tenGamesProgress() {
        let stats = PlayerStats()
        stats.gamesPlayed = 7
        let achievement = Achievement.all.first { $0.id == "ten_games" }!
        let prog = achievement.progress!(stats)
        #expect(prog.current == 7)
        #expect(prog.target == 10)
    }

    @Test("Progress caps at target when exceeded")
    func progressCapsAtTarget() {
        let stats = PlayerStats()
        stats.gamesPlayed = 15
        let achievement = Achievement.all.first { $0.id == "ten_games" }!
        let prog = achievement.progress!(stats)
        #expect(prog.current == 10)
        #expect(prog.target == 10)
    }

    // MARK: - Mastery Achievements (logic-216)

    @Test("Easy mastery achievement exists")
    func easyMasteryExists() {
        let a = Achievement.all.first { $0.id == "easy_mastery" }
        #expect(a != nil)
    }

    @Test("Easy mastery unlocks at 5 mastery games")
    func easyMasteryUnlocks() {
        let stats = PlayerStats()
        let a = Achievement.all.first { $0.id == "easy_mastery" }!
        stats.easyMasteryCount = 4
        #expect(!a.isUnlocked(stats: stats))
        stats.easyMasteryCount = 5
        #expect(a.isUnlocked(stats: stats))
    }

    @Test("Hard mastery achievement exists")
    func hardMasteryExists() {
        let a = Achievement.all.first { $0.id == "hard_mastery" }
        #expect(a != nil)
    }

    // MARK: - Achievement Count (logic-233)

    @Test("New player has 0 unlocked achievements")
    func newPlayerZeroUnlocked() {
        let stats = PlayerStats()
        #expect(Achievement.unlockedCount(for: stats) == 0)
    }

    @Test("Unlocked count after unlocking first game")
    func unlockedCountAfterFirstGame() {
        let stats = PlayerStats()
        stats.gamesPlayed = 1
        #expect(Achievement.unlockedCount(for: stats) >= 1)
    }

    @Test("Total equals unlocked plus locked")
    func totalEqualsUnlockedPlusLocked() {
        let stats = PlayerStats()
        stats.gamesPlayed = 5
        let unlocked = Achievement.unlockedCount(for: stats)
        let locked = Achievement.lockedCount(for: stats)
        #expect(unlocked + locked == Achievement.all.count)
    }
}
