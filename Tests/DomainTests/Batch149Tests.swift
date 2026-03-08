import Testing
@testable import MathKids

@Suite("Batch 149 Tests")
struct Batch149Tests {

    // MARK: - logic-824: actionWord

    @Test
    func actionWord_add() {
        #expect(Operation.add.actionWord == "adding")
    }

    @Test
    func actionWord_multiply() {
        #expect(Operation.multiply.actionWord == "multiplying")
    }

    // MARK: - logic-825: isPrimaryOperation

    @Test
    func isPrimaryOperation_add() {
        #expect(Operation.add.isPrimaryOperation == true)
    }

    @Test
    func isPrimaryOperation_multiply() {
        #expect(Operation.multiply.isPrimaryOperation == false)
    }

    // MARK: - logic-826: Category.color

    @Test
    func categoryColor_streak() {
        #expect(Achievement.Category.streak.color == "orange")
    }

    @Test
    func categoryColor_score() {
        #expect(Achievement.Category.score.color == "gold")
    }

    // MARK: - logic-827: Category.iconName

    @Test
    func categoryIconName_games() {
        #expect(!Achievement.Category.games.iconName.isEmpty)
    }

    @Test
    func categoryIconName_mastery() {
        #expect(!Achievement.Category.mastery.iconName.isEmpty)
    }

    // MARK: - logic-828: Category.description

    @Test
    func categoryDescription_mastery() {
        let desc = Achievement.Category.mastery.categoryDescription
        #expect(!desc.isEmpty)
    }

    @Test
    func categoryDescription_streak() {
        let desc = Achievement.Category.streak.categoryDescription
        #expect(!desc.isEmpty)
    }
}
