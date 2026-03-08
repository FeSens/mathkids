import Testing
@testable import MathKids

@Suite("Improvement Round 9 Tests")
struct ImproveRound9Tests {

    // MARK: - improve-040: Session performance grade

    @Test("95%+ accuracy earns A+")
    @MainActor
    func gradeAPlus() {
        var session = GameSession(difficulty: .easy)
        for i in 0..<20 { session.recordAnswer(correct: i < 19, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.sessionGrade == "A+")
    }

    @Test("Below 60% accuracy earns F")
    @MainActor
    func gradeF() {
        var session = GameSession(difficulty: .easy)
        for i in 0..<10 { session.recordAnswer(correct: i < 5, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.sessionGrade == "F")
    }

    // MARK: - improve-041: Net score

    @Test("All correct gives positive net score")
    @MainActor
    func allCorrectNetScore() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.netScore > 0)
    }

    @Test("Net score never goes below 0")
    @MainActor
    func netScoreNonNegative() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: false, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.netScore >= 0)
    }

    // MARK: - improve-042: Accuracy by position

    @Test("Accuracy for early, middle, and late problems")
    @MainActor
    func accuracyByPosition() {
        var problems: [AnsweredProblem] = []
        // 5 wrong, 5 mixed, 5 correct
        for _ in 0..<5 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4))
        }
        for i in 0..<5 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: i < 3 ? 5 : 4))
        }
        for _ in 0..<5 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5))
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        let positional = vm.accuracyByPosition
        #expect(positional != nil)
        #expect(positional!.early < positional!.late)
    }

    @Test("Insufficient data returns nil")
    @MainActor
    func insufficientPositionalData() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        ], previouslyUnlockedIds: [])
        #expect(vm.accuracyByPosition == nil)
    }

    // MARK: - improve-043: Average operand size

    @Test("Average operand computed per operation")
    @MainActor
    func avgOperandPerOp() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 4, operand2: 6, operation: .add), userAnswer: 10),
            AnsweredProblem(problem: MathProblem(operand1: 8, operand2: 2, operation: .add), userAnswer: 10),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        let avg = vm.averageOperandSize
        #expect(avg[.add] == 5.0) // (4+6+8+2)/4
    }

    @Test("No data returns empty dictionary")
    @MainActor
    func emptyOperandAvg() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.averageOperandSize.isEmpty)
    }

    // MARK: - improve-044: Efficiency score

    @Test("Perfect accuracy with fast time gives high score")
    @MainActor
    func highEfficiency() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 1.0
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1], previouslyUnlockedIds: [])
        #expect(vm.efficiencyScore > 50)
    }

    @Test("No answers gives 0 efficiency")
    @MainActor
    func zeroEfficiency() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.efficiencyScore == 0)
    }
}
