import Testing
@testable import MathKids

@Suite("Improvement Round 2 Tests")
struct ImproveRound2Tests {

    // MARK: - improve-006: Elo delta display

    @Test("Elo deltas computed from problem history")
    func eloDeltas() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 5, operand2: 3, operation: .add), userAnswer: 8),
            AnsweredProblem(problem: MathProblem(operand1: 5, operand2: 3, operation: .add), userAnswer: 7),
            AnsweredProblem(problem: MathProblem(operand1: 10, operand2: 5, operation: .subtract), userAnswer: 5),
        ]
        let deltas = EloSystem.computeDeltas(from: history, initialRatings: [
            .add: 1000, .subtract: 1000, .multiply: 1000, .divide: 1000
        ])
        // Add: 1 correct + 1 wrong = some delta
        #expect(deltas[.add] != nil)
        #expect(deltas[.subtract] != nil)
        #expect(deltas[.multiply] == nil)
    }

    @Test("Positive elo delta for correct answers")
    func positiveEloDelta() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let deltas = EloSystem.computeDeltas(from: history, initialRatings: [
            .add: 1000, .subtract: 1000, .multiply: 1000, .divide: 1000
        ])
        #expect(deltas[.add]! > 0)
    }

    @Test("Negative elo delta for wrong answers")
    func negativeEloDelta() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4),
        ]
        let deltas = EloSystem.computeDeltas(from: history, initialRatings: [
            .add: 1000, .subtract: 1000, .multiply: 1000, .divide: 1000
        ])
        #expect(deltas[.add]! < 0)
    }

    // MARK: - improve-007: Adaptive operation weighting

    @Test("ProblemGenerator accepts operation weights")
    func generatorAcceptsWeights() {
        var gen = ProblemGenerator()
        let weights: [Operation: Double] = [.add: 0.1, .subtract: 0.1, .multiply: 0.4, .divide: 0.4]
        // Should not crash, should produce a problem
        let problem = gen.generate(for: .easy, allowedOperations: nil, operationWeights: weights)
        #expect(problem.operand1 > 0 || problem.operand1 == 0)
    }

    @Test("Single operation ignores weighting")
    func singleOperationIgnoresWeights() {
        var gen = ProblemGenerator()
        let weights: [Operation: Double] = [.add: 0.1, .subtract: 0.1, .multiply: 0.4, .divide: 0.4]
        let problem = gen.generate(for: .easy, allowedOperations: [.add], operationWeights: weights)
        #expect(problem.operation == .add)
    }

    // MARK: - improve-008: Response time per operation

    @Test("Average time per operation computed from history")
    @MainActor
    func averageTimePerOperation() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 2.0
        var p2 = AnsweredProblem(problem: MathProblem(operand1: 4, operand2: 3, operation: .add), userAnswer: 7)
        p2.timeTaken = 4.0
        var p3 = AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 2, operation: .subtract), userAnswer: 4)
        p3.timeTaken = 3.0

        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2, p3], previouslyUnlockedIds: [])
        let times = vm.averageTimePerOperation
        #expect(times[.add] == 3.0) // (2+4)/2
        #expect(times[.subtract] == 3.0)
        #expect(times[.multiply] == nil)
    }

    @Test("Slowest operation identified")
    @MainActor
    func slowestOperation() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 2.0
        var p2 = AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 2, operation: .subtract), userAnswer: 4)
        p2.timeTaken = 5.0

        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2], previouslyUnlockedIds: [])
        #expect(vm.slowestOperationThisGame == .subtract)
    }

    // MARK: - improve-009: Session comparison

    @Test("Above average accuracy shows positive comparison")
    @MainActor
    func aboveAverageAccuracy() {
        let stats = PlayerStats()
        stats.totalSolved = 100
        stats.totalCorrect = 70 // 70% average

        var session = GameSession(difficulty: .easy)
        // Record 10 answers, 9 correct = 90%
        for i in 0..<10 {
            session.recordAnswer(correct: i < 9, bonusPoints: 0)
        }

        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: stats, problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.accuracyVsAverage > 0) // 90% - 70% = +20
    }

    @Test("Below average shows negative comparison")
    @MainActor
    func belowAverageAccuracy() {
        let stats = PlayerStats()
        stats.totalSolved = 100
        stats.totalCorrect = 90 // 90% average

        var session = GameSession(difficulty: .easy)
        // Record 10 answers, 5 correct = 50%
        for i in 0..<10 {
            session.recordAnswer(correct: i < 5, bonusPoints: 0)
        }

        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: stats, problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.accuracyVsAverage < 0) // 50% - 90% = -40
    }
}
