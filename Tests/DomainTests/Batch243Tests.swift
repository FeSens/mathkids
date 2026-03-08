import Testing
@testable import MathKids

@Suite("Batch 243 Tests")
struct Batch243Tests {

    // MARK: - logic-1294: answeredProblemShieldValue

    @Test
    func answeredProblemShieldValue_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemShieldValue == 1)
    }

    @Test
    func answeredProblemShieldValue_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemShieldValue == 0)
    }

    // MARK: - logic-1295: answeredProblemComboBreaker

    @Test
    func answeredProblemComboBreaker_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemComboBreaker == true)
    }

    @Test
    func answeredProblemComboBreaker_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemComboBreaker == false)
    }

    // MARK: - logic-1296: answeredProblemBossHitDamage

    @Test
    func answeredProblemBossHitDamage_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemBossHitDamage > 0)
    }

    @Test
    func answeredProblemBossHitDamage_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemBossHitDamage == 0)
    }

    // MARK: - logic-1297: answeredProblemCurrencyDisplay

    @Test
    func answeredProblemCurrencyDisplay_correct() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemCurrencyDisplay.contains("coins"))
    }

    @Test
    func answeredProblemCurrencyDisplay_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemCurrencyDisplay == "0 coins")
    }

    // MARK: - logic-1298: answeredProblemIsDoublePayout

    @Test
    func answeredProblemIsDoublePayout_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12, timeTaken: 1.0)
        #expect(a.answeredProblemIsDoublePayout == true)
    }

    @Test
    func answeredProblemIsDoublePayout_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsDoublePayout == false)
    }
}
