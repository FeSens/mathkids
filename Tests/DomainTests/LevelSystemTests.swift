import Testing
@testable import MathKids

@Suite("LevelSystem Tests")
struct LevelSystemTests {
    @Test("Level 1 at 0 XP")
    func level1At0XP() {
        #expect(LevelSystem.level(for: 0) == 1)
    }

    @Test("Level 2 at 100 XP")
    func level2At100XP() {
        #expect(LevelSystem.level(for: 100) == 2)
    }

    @Test("Level 3 at 300 XP")
    func level3At300XP() {
        #expect(LevelSystem.level(for: 300) == 3)
    }

    @Test("Max level at high XP")
    func maxLevelAtHighXP() {
        #expect(LevelSystem.level(for: 99999) == LevelSystem.thresholds.count)
    }

    @Test("Progress to next level at 0 XP is 0")
    func progressAt0() {
        let progress = LevelSystem.progressToNextLevel(for: 0)
        #expect(progress >= 0 && progress <= 1)
    }

    @Test("Progress midway through level")
    func progressMidway() {
        // Level 1: 0-99 XP, so 50 XP = 50% progress
        let progress = LevelSystem.progressToNextLevel(for: 50)
        #expect(progress > 0.4 && progress < 0.6)
    }

    @Test("Level name exists for each level")
    func levelNamesExist() {
        for xp in [0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500] {
            let name = LevelSystem.levelName(for: xp)
            #expect(!name.isEmpty)
        }
    }

    @Test("XP for correct answer with streak bonus")
    func xpForAnswer() {
        let base = LevelSystem.xpForCorrectAnswer(streak: 0)
        #expect(base == 10)
        let withStreak = LevelSystem.xpForCorrectAnswer(streak: 5)
        #expect(withStreak > base)
    }

    // MARK: - XP Needed For Next Level (logic-211)

    @Test("XP needed at 0 is 100")
    func xpNeededAt0() {
        #expect(LevelSystem.xpNeededForNextLevel(currentXP: 0) == 100)
    }

    @Test("XP needed at 50 is 50")
    func xpNeededAt50() {
        #expect(LevelSystem.xpNeededForNextLevel(currentXP: 50) == 50)
    }

    @Test("XP needed at max level is 0")
    func xpNeededAtMax() {
        #expect(LevelSystem.xpNeededForNextLevel(currentXP: 99999) == 0)
    }

    // MARK: - Level Title (logic-221)

    @Test("Level title at 0 XP")
    func levelTitleAt0() {
        #expect(LevelSystem.levelTitle(for: 0) == "Lv. 1 Beginner")
    }

    @Test("Level title at 300 XP")
    func levelTitleAt300() {
        #expect(LevelSystem.levelTitle(for: 300) == "Lv. 3 Explorer")
    }

    // MARK: - Max Level Check (logic-231)

    @Test("Not max level at 0 XP")
    func notMaxAt0() {
        #expect(LevelSystem.isMaxLevel(for: 0) == false)
    }

    @Test("Max level at high XP")
    func maxAtHighXP() {
        #expect(LevelSystem.isMaxLevel(for: 99999) == true)
    }
}
