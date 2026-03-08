import Testing
@testable import MathKids

@Suite("Batch 230 Tests")
struct Batch230Tests {

    // MARK: - logic-1229: answeredProblemDifficultyRank

    @Test
    func answeredProblemDifficultyRank_add() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemDifficultyRank == 1)
    }

    @Test
    func answeredProblemDifficultyRank_divide() {
        let p = MathProblem(operand1: 8, operand2: 4, operation: .divide)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemDifficultyRank == 4)
    }

    // MARK: - logic-1230: answeredProblemIsTimedOut

    @Test
    func answeredProblemIsTimedOut_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 20.0)
        #expect(a.answeredProblemIsTimedOut == true)
    }

    @Test
    func answeredProblemIsTimedOut_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 5.0)
        #expect(a.answeredProblemIsTimedOut == false)
    }

    // MARK: - logic-1231: answeredProblemAnswerLength

    @Test
    func answeredProblemAnswerLength_single() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemAnswerLength == 1)
    }

    @Test
    func answeredProblemAnswerLength_double() {
        let p = MathProblem(operand1: 5, operand2: 7, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemAnswerLength == 2)
    }

    // MARK: - logic-1232: answeredProblemProblemKey

    @Test
    func answeredProblemProblemKey() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemProblemKey == "add_2_3")
    }

    // MARK: - logic-1233: answeredProblemIsRepeatMistake

    @Test
    func answeredProblemIsRepeatMistake_true() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 2)
        #expect(a.answeredProblemIsRepeatMistake == true)
    }

    @Test
    func answeredProblemIsRepeatMistake_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 7)
        #expect(a.answeredProblemIsRepeatMistake == false)
    }
}
