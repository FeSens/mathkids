import Testing
@testable import MathKids

@Suite("Batch 144 Tests")
struct Batch144Tests {

    private var sampleAchievement: Achievement {
        Achievement.all.first!
    }

    // MARK: - logic-799: progressDescription

    @Test
    func progressDescription() {
        let desc = sampleAchievement.progressDescription
        #expect(!desc.isEmpty)
    }

    // MARK: - logic-800: isHidden

    @Test
    func isHidden_common() {
        // first_game is a common achievement
        #expect(sampleAchievement.isHidden == false)
    }

    @Test
    func isHidden_rare() {
        // Find a rare achievement
        let rareAch = Achievement.all.first { $0.isRareAchievement }
        if let ach = rareAch {
            #expect(ach.isHidden == true)
        }
    }

    // MARK: - logic-801: pointValue

    @Test
    func pointValue_common() {
        #expect(sampleAchievement.pointValue == 10)
    }

    // MARK: - logic-802: badgeColor

    @Test
    func badgeColor_games() {
        // first_game is in games category
        #expect(sampleAchievement.badgeColor == "blue")
    }

    @Test
    func badgeColor_streak() {
        let streakAch = Achievement.all.first { $0.category == .streak }
        if let ach = streakAch {
            #expect(ach.badgeColor == "orange")
        }
    }

    // MARK: - logic-803: shareText

    @Test
    func shareText_containsTitle() {
        let text = sampleAchievement.shareText
        #expect(text.contains(sampleAchievement.title))
    }
}
