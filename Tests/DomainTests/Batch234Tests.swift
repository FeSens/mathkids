import Testing
@testable import MathKids

@Suite("Batch 234 Tests")
struct Batch234Tests {

    // MARK: - logic-1249: answeredProblemTeacherNote

    @Test
    func answeredProblemTeacherNote_correct() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemTeacherNote.contains("mastered"))
    }

    @Test
    func answeredProblemTeacherNote_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemTeacherNote.contains("needs review"))
    }

    // MARK: - logic-1250: answeredProblemIsCountingProblem

    @Test
    func answeredProblemIsCountingProblem_true() {
        let p = MathProblem(operand1: 5, operand2: 1, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 6)
        #expect(a.answeredProblemIsCountingProblem == true)
    }

    @Test
    func answeredProblemIsCountingProblem_false() {
        let p = MathProblem(operand1: 5, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 8)
        #expect(a.answeredProblemIsCountingProblem == false)
    }

    // MARK: - logic-1251: answeredProblemAbilityIndicator

    @Test
    func answeredProblemAbilityIndicator_strong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemAbilityIndicator == "strong")
    }

    @Test
    func answeredProblemAbilityIndicator_weak() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemAbilityIndicator == "weak")
    }

    // MARK: - logic-1252: answeredProblemHapticType

    @Test
    func answeredProblemHapticType_success() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemHapticType == "success")
    }

    @Test
    func answeredProblemHapticType_error() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemHapticType == "error")
    }

    // MARK: - logic-1253: answeredProblemNextStepSuggestion

    @Test
    func answeredProblemNextStepSuggestion_next() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemNextStepSuggestion.contains("next"))
    }

    @Test
    func answeredProblemNextStepSuggestion_practice() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemNextStepSuggestion.contains("practice"))
    }
}
