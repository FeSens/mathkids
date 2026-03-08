import Testing
@testable import MathKids

@Suite("Batch 150 Tests")
struct Batch150Tests {

    // MARK: - logic-829: badgeText

    @Test
    func badgeText_easy() {
        #expect(DifficultyLevel.easy.badgeText == "E")
    }

    @Test
    func badgeText_hard() {
        #expect(DifficultyLevel.hard.badgeText == "H")
    }

    // MARK: - logic-830: averageAccuracy

    @Test
    func averageAccuracy_easyHigher() {
        #expect(DifficultyLevel.easy.averageAccuracy > DifficultyLevel.hard.averageAccuracy)
    }

    @Test
    func averageAccuracy_valid() {
        #expect(DifficultyLevel.medium.averageAccuracy > 0)
        #expect(DifficultyLevel.medium.averageAccuracy <= 100)
    }

    // MARK: - logic-831: isBasicFact

    @Test
    func isBasicFact_yes() {
        let problem = MathProblem(operand1: 5, operand2: 7, operation: .add)
        #expect(problem.isBasicFact == true)
    }

    @Test
    func isBasicFact_no() {
        let problem = MathProblem(operand1: 15, operand2: 7, operation: .add)
        #expect(problem.isBasicFact == false)
    }

    // MARK: - logic-832: estimatedDifficulty

    @Test
    func estimatedDifficulty_simple() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.estimatedDifficulty <= 2)
    }

    @Test
    func estimatedDifficulty_complex() {
        let problem = MathProblem(operand1: 12, operand2: 8, operation: .multiply)
        #expect(problem.estimatedDifficulty >= 3)
    }

    // MARK: - logic-833: isMultiDigitResult

    @Test
    func isMultiDigitResult_yes() {
        let problem = MathProblem(operand1: 7, operand2: 5, operation: .add)
        // 12 is multi-digit
        #expect(problem.isMultiDigitResult == true)
    }

    @Test
    func isMultiDigitResult_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        // 7 is single digit
        #expect(problem.isMultiDigitResult == false)
    }
}
