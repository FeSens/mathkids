import Testing
@testable import MathKids

@Suite("Batch 232 Tests")
struct Batch232Tests {

    // MARK: - logic-1239: answeredProblemIsTableFactProblem

    @Test
    func answeredProblemIsTableFactProblem_true() {
        let p = MathProblem(operand1: 3, operand2: 4, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 12)
        #expect(a.answeredProblemIsTableFactProblem == true)
    }

    @Test
    func answeredProblemIsTableFactProblem_false() {
        let p = MathProblem(operand1: 15, operand2: 3, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 45)
        #expect(a.answeredProblemIsTableFactProblem == false)
    }

    // MARK: - logic-1240: answeredProblemGradeEmoji

    @Test
    func answeredProblemGradeEmoji_trophy() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemGradeEmoji == "🏆")
    }

    @Test
    func answeredProblemGradeEmoji_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemGradeEmoji == "❌")
    }

    // MARK: - logic-1241: answeredProblemPracticeCount

    @Test
    func answeredProblemPracticeCount_mastered() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemPracticeCount == 0)
    }

    @Test
    func answeredProblemPracticeCount_wrong() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemPracticeCount == 5)
    }

    // MARK: - logic-1242: answeredProblemIsHardProblem

    @Test
    func answeredProblemIsHardProblem_true() {
        let p = MathProblem(operand1: 9, operand2: 8, operation: .multiply)
        let a = AnsweredProblem(problem: p, userAnswer: 72)
        #expect(a.answeredProblemIsHardProblem == true)
    }

    @Test
    func answeredProblemIsHardProblem_false() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5)
        #expect(a.answeredProblemIsHardProblem == false)
    }

    // MARK: - logic-1243: answeredProblemFlashcardStatus

    @Test
    func answeredProblemFlashcardStatus_learned() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 5, timeTaken: 1.0)
        #expect(a.answeredProblemFlashcardStatus == "learned")
    }

    @Test
    func answeredProblemFlashcardStatus_new() {
        let p = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let a = AnsweredProblem(problem: p, userAnswer: 4)
        #expect(a.answeredProblemFlashcardStatus == "new")
    }
}
