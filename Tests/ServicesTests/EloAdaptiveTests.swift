import Testing
@testable import MathKids

@Suite("Elo Adaptive Difficulty Tests")
struct EloAdaptiveTests {

    // MARK: - improve-001: Elo-driven problem difficulty

    @Test("GameEngine accepts eloRatings for per-operation ranges")
    @MainActor
    func gameEngineAcceptsEloRatings() {
        let ratings: [Operation: Double] = [.add: 1400, .subtract: 800, .multiply: 1000, .divide: 900]
        let engine = GameEngine(difficulty: .easy, allowedOperations: nil, eloRatings: ratings)
        #expect(engine.eloRatings != nil)
    }

    @Test("ProblemGenerator uses per-operation Elo range")
    func problemGeneratorUsesEloRange() {
        var gen = ProblemGenerator()
        let eloRanges: [Operation: ClosedRange<Int>] = [
            .add: 1...50,
            .subtract: 1...50,
            .multiply: 1...12,
            .divide: 1...10
        ]
        let problem = gen.generate(for: .easy, allowedOperations: [.add], eloRanges: eloRanges)
        // With Elo range 1...50, operands should be within that range
        #expect(problem.operand1 >= 1 && problem.operand1 <= 50)
        #expect(problem.operand2 >= 1 && problem.operand2 <= 50)
    }

    @Test("High Elo produces harder problems than low Elo")
    func highEloProducesHarderProblems() {
        let lowRange = EloSystem.operandRange(forRating: 800, operation: .add)
        let highRange = EloSystem.operandRange(forRating: 1400, operation: .add)
        #expect(highRange.upperBound > lowRange.upperBound)
    }

    // MARK: - improve-003: Per-operation accuracy breakdown

    @Test("ResultsViewModel computes per-operation accuracy")
    @MainActor
    func perOperationAccuracy() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4),
            AnsweredProblem(problem: MathProblem(operand1: 5, operand2: 2, operation: .subtract), userAnswer: 3),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: history, previouslyUnlockedIds: [])
        let breakdown = vm.operationAccuracyBreakdown
        #expect(breakdown[.add] == 50.0) // 1 correct out of 2
        #expect(breakdown[.subtract] == 100.0) // 1 correct out of 1
        #expect(breakdown[.multiply] == nil) // no attempts
    }

    @Test("Operations with 0 attempts not in breakdown")
    @MainActor
    func noAttemptsExcluded() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: history, previouslyUnlockedIds: [])
        let breakdown = vm.operationAccuracyBreakdown
        #expect(breakdown.count == 1)
        #expect(breakdown[.add] == 100.0)
    }

    // MARK: - improve-004: Elo milestone detection

    @Test("EloSystem detects skill level boundary crossing")
    func skillLevelBoundaryCrossing() {
        let oldRating = 890.0 // Learning
        let newRating = 910.0 // Intermediate
        let oldLevel = EloSystem.skillLevel(forRating: oldRating)
        let newLevel = EloSystem.skillLevel(forRating: newRating)
        #expect(oldLevel != newLevel)
        #expect(oldLevel == "Learning")
        #expect(newLevel == "Intermediate")
    }

    // MARK: - improve-005: Smart practice recommendation

    @Test("ResultsViewModel identifies weakest operation")
    @MainActor
    func weakestOperationRecommendation() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 2, operation: .divide), userAnswer: 1),
            AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 2, operation: .divide), userAnswer: 1),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: history, previouslyUnlockedIds: [])
        #expect(vm.weakestOperationThisGame == .divide)
    }

    @Test("No recommendation when all operations perfect")
    @MainActor
    func noRecommendationAllPerfect() {
        let history = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 2, operation: .divide), userAnswer: 3),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: history, previouslyUnlockedIds: [])
        #expect(vm.weakestOperationThisGame == nil)
    }
}
