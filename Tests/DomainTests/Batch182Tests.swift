import Testing
@testable import MathKids

@Suite("Batch 182 Tests")
struct Batch182Tests {

    // MARK: - logic-989: achievementEmojiLabel

    @Test
    func achievementEmojiLabel_containsEmoji() {
        let a = Achievement.all[0]
        #expect(a.achievementEmojiLabel.contains(a.emoji))
    }

    @Test
    func achievementEmojiLabel_containsCategoryName() {
        let a = Achievement.all.first { $0.category == .streak }!
        #expect(a.achievementEmojiLabel.contains("Streak"))
    }

    // MARK: - logic-990: achievementIsStreak

    @Test
    func achievementIsStreak_streak5() {
        let a = Achievement.all.first { $0.id == "streak_5" }!
        #expect(a.achievementIsStreak == true)
    }

    @Test
    func achievementIsStreak_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsStreak == false)
    }

    // MARK: - logic-991: achievementIsMastery

    @Test
    func achievementIsMastery_easyMastery() {
        let a = Achievement.all.first { $0.id == "easy_mastery" }!
        #expect(a.achievementIsMastery == true)
    }

    @Test
    func achievementIsMastery_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIsMastery == false)
    }

    // MARK: - logic-992: achievementRarityLabel

    @Test
    func achievementRarityLabel_rare() {
        let a = Achievement.all.first { $0.isRareAchievement }!
        #expect(a.achievementRarityLabel == "Rare")
    }

    @Test
    func achievementRarityLabel_common() {
        let a = Achievement.all.first { !$0.isRareAchievement }!
        #expect(a.achievementRarityLabel == "Common")
    }

    // MARK: - logic-993: achievementIdPrefix

    @Test
    func achievementIdPrefix_firstGame() {
        let a = Achievement.all.first { $0.id == "first_game" }!
        #expect(a.achievementIdPrefix == "first")
    }

    @Test
    func achievementIdPrefix_streak5() {
        let a = Achievement.all.first { $0.id == "streak_5" }!
        #expect(a.achievementIdPrefix == "streak")
    }
}
