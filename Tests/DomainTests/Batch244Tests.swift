import Testing
@testable import MathKids

@Suite("Batch 244 Tests")
struct Batch244Tests {

    // MARK: - logic-1299: answeredProblemDefenseBonus

    @Test
    func answeredProblemDefenseBonus_hard() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemDefenseBonus > 0)
    }

    @Test
    func answeredProblemDefenseBonus_easy() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDefenseBonus == 0)
    }

    // MARK: - logic-1300: answeredProblemExperiencePoints

    @Test
    func answeredProblemExperiencePoints_correctFast() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemExperiencePoints > 10)
    }

    @Test
    func answeredProblemExperiencePoints_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemExperiencePoints == 0)
    }

    // MARK: - logic-1301: answeredProblemIsClutchAnswer

    @Test
    func answeredProblemIsClutchAnswer_true() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2, timeTaken: 0.8)
        #expect(a.answeredProblemIsClutchAnswer == true)
    }

    @Test
    func answeredProblemIsClutchAnswer_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsClutchAnswer == false)
    }

    // MARK: - logic-1302: answeredProblemMedalType

    @Test
    func answeredProblemMedalType_diamond() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 0.5)
        #expect(a.answeredProblemMedalType == "diamond")
    }

    @Test
    func answeredProblemMedalType_none() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemMedalType == "none")
    }

    // MARK: - logic-1303: answeredProblemPointsBreakdown

    @Test
    func answeredProblemPointsBreakdown_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemPointsBreakdown.contains("Base"))
        #expect(a.answeredProblemPointsBreakdown.contains("Total"))
    }

    @Test
    func answeredProblemPointsBreakdown_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemPointsBreakdown.contains("0"))
    }
}
