import Testing
@testable import MathKids

@Suite("Batch 137 Tests")
struct Batch137Tests {

    // MARK: - logic-764: maxOperandDisplay

    @Test
    func maxOperandDisplay_easy() {
        let text = DifficultyLevel.easy.maxOperandDisplay
        #expect(text.contains("up to"))
    }

    @Test
    func maxOperandDisplay_hard() {
        let text = DifficultyLevel.hard.maxOperandDisplay
        #expect(!text.isEmpty)
    }

    // MARK: - logic-765: speedRequirement

    @Test
    func speedRequirement_easy() {
        let req = DifficultyLevel.easy.speedRequirement
        #expect(req.contains("seconds"))
    }

    @Test
    func speedRequirement_hard() {
        let req = DifficultyLevel.hard.speedRequirement
        #expect(!req.isEmpty)
    }

    // MARK: - logic-766: bonusPointsAvailable

    @Test
    func bonusPointsAvailable_positive() {
        #expect(DifficultyLevel.easy.bonusPointsAvailable > 0)
    }

    @Test
    func bonusPointsAvailable_hardHigher() {
        #expect(DifficultyLevel.hard.bonusPointsAvailable >= DifficultyLevel.easy.bonusPointsAvailable)
    }

    // MARK: - logic-767: isBeginnerFriendly

    @Test
    func isBeginnerFriendly_easy() {
        #expect(DifficultyLevel.easy.isBeginnerFriendly == true)
    }

    @Test
    func isBeginnerFriendly_hard() {
        #expect(DifficultyLevel.hard.isBeginnerFriendly == false)
    }

    // MARK: - logic-768: completionMessage

    @Test
    func completionMessage_easy() {
        let msg = DifficultyLevel.easy.completionMessage
        #expect(!msg.isEmpty)
    }

    @Test
    func completionMessage_unique() {
        #expect(DifficultyLevel.easy.completionMessage != DifficultyLevel.hard.completionMessage)
    }
}
