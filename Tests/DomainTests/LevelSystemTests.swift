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

    // MARK: - XP To Max (logic-246)

    @Test("XP to max level returns highest threshold")
    func xpToMaxLevel() {
        #expect(LevelSystem.xpToMaxLevel == 4500)
    }

    @Test("XP remaining to max at 0")
    func xpRemainingToMaxAt0() {
        #expect(LevelSystem.xpRemainingToMax(currentXP: 0) == 4500)
    }

    @Test("XP remaining to max at max")
    func xpRemainingToMaxAtMax() {
        #expect(LevelSystem.xpRemainingToMax(currentXP: 99999) == 0)
    }

    // MARK: - XP Breakdown (logic-261)

    @Test("Base XP from 0 streak is 10")
    func baseXPIs10() {
        #expect(LevelSystem.baseXPPerAnswer == 10)
    }

    @Test("Streak bonus XP calculated separately")
    func streakBonusXP() {
        let bonus = LevelSystem.streakBonusXP(streak: 5)
        #expect(bonus == 10) // 5 * 2
    }

    @Test("Total XP is base + streak bonus")
    func totalXPIsBaseAndBonus() {
        let total = LevelSystem.xpForCorrectAnswer(streak: 5)
        let base = LevelSystem.baseXPPerAnswer
        let bonus = LevelSystem.streakBonusXP(streak: 5)
        #expect(total == base + bonus)
    }

    // MARK: - Level Emoji (logic-273)

    @Test("Level 1 has an emoji")
    func level1HasEmoji() {
        #expect(!LevelSystem.levelEmoji(for: 0).isEmpty)
    }

    @Test("Each level has a unique emoji")
    func uniqueEmojis() {
        var emojis: Set<String> = []
        for xp in LevelSystem.thresholds {
            emojis.insert(LevelSystem.levelEmoji(for: xp))
        }
        #expect(emojis.count == LevelSystem.thresholds.count)
    }

    @Test("Max level has an emoji")
    func maxLevelHasEmoji() {
        #expect(!LevelSystem.levelEmoji(for: 99999).isEmpty)
    }

    // MARK: - XP Percentage (logic-282)

    @Test("0 XP shows 0%")
    func xpPercentageAt0() {
        #expect(LevelSystem.xpPercentageText(for: 0) == "0%")
    }

    @Test("50 XP shows 50%")
    func xpPercentageAt50() {
        #expect(LevelSystem.xpPercentageText(for: 50) == "50%")
    }

    @Test("Max level shows 100%")
    func xpPercentageAtMax() {
        #expect(LevelSystem.xpPercentageText(for: 99999) == "100%")
    }
}
