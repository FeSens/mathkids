import Testing
@testable import MathKids

@Suite("Batch 180 Tests")
struct Batch180Tests {

    // MARK: - logic-979: operationIconName

    @Test
    func operationIconName_add() {
        #expect(Operation.add.operationIconName == "plus.circle")
    }

    @Test
    func operationIconName_multiply() {
        #expect(Operation.multiply.operationIconName == "multiply.circle")
    }

    // MARK: - logic-980: isFirstTaught

    @Test
    func isFirstTaught_add() {
        #expect(Operation.add.isFirstTaught == true)
    }

    @Test
    func isFirstTaught_subtract() {
        #expect(Operation.subtract.isFirstTaught == false)
    }

    // MARK: - logic-981: achievementTier

    @Test
    func achievementTier_mastery() {
        let a = Achievement.all.first { $0.category == .mastery }!
        #expect(a.achievementTier == "gold")
    }

    @Test
    func achievementTier_games() {
        let a = Achievement.all.first { $0.category == .games }!
        #expect(a.achievementTier == "bronze")
    }

    // MARK: - logic-982: achievementShortDescription

    @Test
    func achievementShortDescription_notEmpty() {
        #expect(!Achievement.all[0].achievementShortDescription.isEmpty)
    }

    // MARK: - logic-983: achievementPointLabel

    @Test
    func achievementPointLabel_containsPts() {
        #expect(Achievement.all[0].achievementPointLabel.contains("pts"))
    }
}
