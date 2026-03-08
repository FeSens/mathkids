import Testing
@testable import MathKids

@Suite("Improvement Round 11 Tests")
struct ImproveRound11Tests {

    // MARK: - improve-050: Warm-up detection

    @Test("warmUpCount returns problems before first correct")
    @MainActor
    func warmUpBeforeFirstCorrect() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.warmUpCount == 2)
    }

    @Test("All correct from start returns 0")
    @MainActor
    func noWarmUp() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.warmUpCount == 0)
    }

    @Test("All wrong returns total count")
    @MainActor
    func allWrongWarmUp() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.warmUpCount == 2)
    }

    @Test("warmUpText returns descriptive string")
    @MainActor
    func warmUpText() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.warmUpText != nil)
    }

    // MARK: - improve-051: Error clustering

    @Test("errorClusterCount counts consecutive error runs")
    @MainActor
    func errorClusters() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong (same cluster)
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong (new cluster)
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.errorClusterCount == 2)
    }

    @Test("No errors returns 0 clusters")
    @MainActor
    func noErrorClusters() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.errorClusterCount == 0)
    }

    @Test("longestErrorRun returns max consecutive wrong")
    @MainActor
    func longestErrorRun() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.longestErrorRun == 3)
    }

    // MARK: - improve-052: Speed progression

    @Test("Getting faster returns .faster")
    @MainActor
    func speedProgressionFaster() {
        var problems: [AnsweredProblem] = []
        // First half: slow (5s each)
        for _ in 0..<4 {
            var p = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
            p.timeTaken = 5.0
            problems.append(p)
        }
        // Second half: fast (1s each)
        for _ in 0..<4 {
            var p = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
            p.timeTaken = 1.0
            problems.append(p)
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.speedProgression == .faster)
    }

    @Test("No time data returns .stable")
    @MainActor
    func speedProgressionNoData() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.speedProgression == .stable)
    }

    @Test("speedProgressionText returns descriptive string")
    @MainActor
    func speedProgressionTextPresent() {
        var problems: [AnsweredProblem] = []
        for _ in 0..<4 {
            var p = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
            p.timeTaken = 5.0
            problems.append(p)
        }
        for _ in 0..<4 {
            var p = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
            p.timeTaken = 1.0
            problems.append(p)
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.speedProgressionText != nil)
    }

    // MARK: - improve-053: Per-operation problem count

    @Test("Mixed operations counted correctly")
    @MainActor
    func problemCountMixed() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 5, operand2: 3, operation: .subtract), userAnswer: 2),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        let counts = vm.problemCountPerOperation
        #expect(counts[.add] == 2)
        #expect(counts[.subtract] == 1)
    }

    @Test("Empty history returns empty dictionary")
    @MainActor
    func problemCountEmpty() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.problemCountPerOperation.isEmpty)
    }

    // MARK: - improve-054: Consistency score

    @Test("All correct gives 100 consistency")
    @MainActor
    func allCorrectConsistency() {
        let problems = (0..<5).map { _ in
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.consistencyScore == 100)
    }

    @Test("All wrong gives 100 consistency")
    @MainActor
    func allWrongConsistency() {
        let problems = (0..<5).map { _ in
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4)
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.consistencyScore == 100)
    }

    @Test("Mixed results give lower consistency")
    @MainActor
    func mixedConsistency() {
        var problems: [AnsweredProblem] = []
        // Alternating correct/wrong
        for i in 0..<10 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: i % 2 == 0 ? 5 : 4))
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.consistencyScore < 100)
        #expect(vm.consistencyScore >= 0)
    }

    @Test("Empty history gives 0")
    @MainActor
    func emptyConsistency() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.consistencyScore == 0)
    }
}
