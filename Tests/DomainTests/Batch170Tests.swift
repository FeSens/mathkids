import Testing
@testable import MathKids

@Suite("Batch 170 Tests")
struct Batch170Tests {

    // MARK: - logic-929: answerAsString

    @Test
    func answerAsString_positive() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerAsString == "7")
    }

    @Test
    func answerAsString_negative() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: -3)
        #expect(answered.answerAsString == "-3")
    }

    // MARK: - logic-930: difficultyIsMax

    @Test
    func difficultyIsMax_hard() {
        #expect(DifficultyLevel.hard.difficultyIsMax == true)
    }

    @Test
    func difficultyIsMax_easy() {
        #expect(DifficultyLevel.easy.difficultyIsMax == false)
    }

    // MARK: - logic-931: problemIsHard

    @Test
    func problemIsHard_yes() {
        let problem = MathProblem(operand1: 12, operand2: 8, operation: .divide)
        #expect(problem.problemIsHard == true)
    }

    @Test
    func problemIsHard_no() {
        let problem = MathProblem(operand1: 2, operand2: 3, operation: .add)
        #expect(problem.problemIsHard == false)
    }

    // MARK: - logic-932: answerWasPositive

    @Test
    func answerWasPositive_yes() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: 7)
        #expect(answered.answerWasPositive == true)
    }

    @Test
    func answerWasPositive_no() {
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let answered = AnsweredProblem(problem: problem, userAnswer: -3)
        #expect(answered.answerWasPositive == false)
    }

    // MARK: - logic-933: difficultyHasTimeLimit

    @Test
    func difficultyHasTimeLimit_all() {
        #expect(DifficultyLevel.easy.difficultyHasTimeLimit == true)
        #expect(DifficultyLevel.medium.difficultyHasTimeLimit == true)
        #expect(DifficultyLevel.hard.difficultyHasTimeLimit == true)
    }
}
