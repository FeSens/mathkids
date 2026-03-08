import Testing
@testable import MathKids

@Suite("Batch 138 Tests")
struct Batch138Tests {

    // MARK: - logic-769: isAddition

    @Test
    func isAddition_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isAddition == true)
    }

    @Test
    func isAddition_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .subtract)
        #expect(problem.isAddition == false)
    }

    // MARK: - logic-770: isSubtraction

    @Test
    func isSubtraction_yes() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .subtract)
        #expect(problem.isSubtraction == true)
    }

    @Test
    func isSubtraction_no() {
        let problem = MathProblem(operand1: 5, operand2: 3, operation: .add)
        #expect(problem.isSubtraction == false)
    }

    // MARK: - logic-771: isMultiplication

    @Test
    func isMultiplication_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        #expect(problem.isMultiplication == true)
    }

    @Test
    func isMultiplication_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        #expect(problem.isMultiplication == false)
    }

    // MARK: - logic-772: isDivision

    @Test
    func isDivision_yes() {
        let problem = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        #expect(problem.isDivision == true)
    }

    @Test
    func isDivision_no() {
        let problem = MathProblem(operand1: 8, operand2: 4, operation: .multiply)
        #expect(problem.isDivision == false)
    }

    // MARK: - logic-773: problemCategoryText

    @Test
    func problemCategoryText_basic() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.problemCategoryText == "basic")
    }

    @Test
    func problemCategoryText_advanced() {
        let problem = MathProblem(operand1: 12, operand2: 8, operation: .multiply)
        #expect(problem.problemCategoryText == "advanced")
    }

    @Test
    func problemCategoryText_intermediate() {
        let problem = MathProblem(operand1: 7, operand2: 5, operation: .subtract)
        #expect(problem.problemCategoryText == "intermediate")
    }
}
