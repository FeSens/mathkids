import Testing
@testable import MathKids

@Suite("Batch 134 Tests")
struct Batch134Tests {

    // MARK: - logic-749: detailedOverview

    @Test
    func detailedOverview_easy() {
        let desc = DifficultyLevel.easy.detailedOverview
        #expect(!desc.isEmpty)
        #expect(desc.contains("Easy"))
    }

    @Test
    func detailedOverview_hard() {
        let desc = DifficultyLevel.hard.detailedOverview
        #expect(desc.contains("Hard"))
    }

    // MARK: - logic-750: isRecommendedFor

    @Test
    func isRecommendedFor_easy_lowAccuracy() {
        #expect(DifficultyLevel.easy.isRecommendedFor(accuracy: 50) == true)
    }

    @Test
    func isRecommendedFor_hard_lowAccuracy() {
        #expect(DifficultyLevel.hard.isRecommendedFor(accuracy: 50) == false)
    }

    @Test
    func isRecommendedFor_hard_highAccuracy() {
        #expect(DifficultyLevel.hard.isRecommendedFor(accuracy: 95) == true)
    }

    // MARK: - logic-751: timeLimitFormatted

    @Test
    func timeLimitFormatted_easy() {
        #expect(DifficultyLevel.easy.timeLimitFormatted == "1:00")
    }

    @Test
    func timeLimitFormatted_hard() {
        let formatted = DifficultyLevel.hard.timeLimitFormatted
        #expect(formatted.contains(":"))
    }

    // MARK: - logic-752: operationList

    @Test
    func operationList_easy() {
        let list = DifficultyLevel.easy.operationList
        #expect(!list.isEmpty)
    }

    @Test
    func operationList_hard() {
        let list = DifficultyLevel.hard.operationList
        #expect(list.contains(",") || !list.isEmpty)
    }

    // MARK: - logic-753: scoreRangeText

    @Test
    func scoreRangeText_easy() {
        let text = DifficultyLevel.easy.scoreRangeText
        #expect(text.contains("-"))
    }

    @Test
    func scoreRangeText_hard() {
        let text = DifficultyLevel.hard.scoreRangeText
        #expect(!text.isEmpty)
    }
}
