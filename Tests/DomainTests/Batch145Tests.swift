import Testing
@testable import MathKids

@Suite("Batch 145 Tests")
struct Batch145Tests {

    private var sampleAchievement: Achievement {
        Achievement.all.first!
    }

    // MARK: - logic-804: requirementSummary

    @Test
    func requirementSummary() {
        #expect(sampleAchievement.requirementSummary == sampleAchievement.description)
    }

    // MARK: - logic-805: categoryLabel

    @Test
    func categoryLabel() {
        let label = sampleAchievement.categoryLabel
        #expect(label.contains(sampleAchievement.category.displayName))
        #expect(label.contains(sampleAchievement.category.emoji))
    }

    // MARK: - logic-806: isEarlyGame

    @Test
    func isEarlyGame_firstGame() {
        let firstGame = Achievement.all.first { $0.id == "first_game" }
        #expect(firstGame?.isEarlyGame == true)
    }

    @Test
    func isEarlyGame_mastery() {
        let mastery = Achievement.all.first { $0.category == .mastery }
        if let ach = mastery {
            #expect(ach.isEarlyGame == false)
        }
    }

    // MARK: - logic-807: rewardText

    @Test
    func rewardText() {
        let text = sampleAchievement.rewardText
        #expect(text.contains("pts"))
    }

    // MARK: - logic-808: displayTitle

    @Test
    func displayTitle() {
        let title = sampleAchievement.displayTitle
        #expect(title.contains(sampleAchievement.emoji))
        #expect(title.contains(sampleAchievement.title))
    }
}
