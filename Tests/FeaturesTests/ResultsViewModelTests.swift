import Testing
@testable import MathKids

@MainActor
@Suite("ResultsViewModel Tests")
struct ResultsViewModelTests {

    private func makeSession(correct: Int, total: Int, difficulty: DifficultyLevel = .easy) -> GameSession {
        var session = GameSession(difficulty: difficulty)
        for i in 0..<total {
            session.recordAnswer(correct: i < correct, bonusPoints: 0)
        }
        return session
    }

    // MARK: - Encouragement Messages (ui-056)

    @Test("Encouragement message for 90%+ accuracy")
    func encouragementHighAccuracy() {
        let session = makeSession(correct: 10, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let options = ["You're a math superstar!", "Incredible performance!", "Math genius level!"]
        #expect(options.contains(vm.encouragementMessage))
    }

    @Test("Encouragement message for 70-89% accuracy")
    func encouragementGoodAccuracy() {
        let session = makeSession(correct: 8, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let options = ["Great work, keep it up!", "You're getting stronger!", "Almost perfect!"]
        #expect(options.contains(vm.encouragementMessage))
    }

    @Test("Encouragement message for 50-69% accuracy")
    func encouragementMediumAccuracy() {
        let session = makeSession(correct: 6, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let options = ["Good effort!", "Practice makes perfect!", "You're improving!"]
        #expect(options.contains(vm.encouragementMessage))
    }

    @Test("Encouragement message for below 50% accuracy")
    func encouragementLowAccuracy() {
        let session = makeSession(correct: 3, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let options = ["Don't give up!", "Every try makes you better!", "You'll get there!"]
        #expect(options.contains(vm.encouragementMessage))
    }

    // MARK: - Problem History (ui-057)

    @Test("Problem history is stored from init parameter")
    func problemHistoryStored() {
        let session = makeSession(correct: 1, total: 1)
        let problem = MathProblem(operand1: 3, operand2: 4, operation: .add)
        let history = [AnsweredProblem(problem: problem, userAnswer: 7)]
        let vm = ResultsViewModel(session: session, previousBestScore: 0, problemHistory: history)
        #expect(vm.problemHistory.count == 1)
        #expect(vm.problemHistory[0].isCorrect == true)
    }

    @Test("Problem history defaults to empty")
    func problemHistoryDefaultsEmpty() {
        let session = makeSession(correct: 1, total: 1)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.problemHistory.isEmpty)
    }

    @Test("Problem history tracks correct and wrong answers")
    func problemHistoryTracksCorrectness() {
        let session = makeSession(correct: 1, total: 2)
        let p1 = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let p2 = MathProblem(operand1: 5, operand2: 2, operation: .subtract)
        let history = [
            AnsweredProblem(problem: p1, userAnswer: 5),
            AnsweredProblem(problem: p2, userAnswer: 4)
        ]
        let vm = ResultsViewModel(session: session, previousBestScore: 0, problemHistory: history)
        #expect(vm.problemHistory[0].isCorrect == true)
        #expect(vm.problemHistory[1].isCorrect == false)
    }

    // MARK: - Score Breakdown

    @Test("Base points calculated correctly")
    func basePoints() {
        let session = makeSession(correct: 5, total: 5, difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.basePoints == 5 * DifficultyLevel.easy.pointsPerCorrect)
    }

    @Test("Bonus points are score minus base")
    func bonusPoints() {
        let session = makeSession(correct: 5, total: 5, difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.bonusPoints == session.score - vm.basePoints)
    }

    // MARK: - Fun Fact

    @Test("Fun fact returns a string")
    func funFactExists() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(!vm.funFact.isEmpty)
    }
}
