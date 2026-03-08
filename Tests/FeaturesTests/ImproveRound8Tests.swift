import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 8 Tests")
struct ImproveRound8Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - improve-035: Streak frequency analysis

    @Test("Streak counts computed from problem history")
    @MainActor
    func streakCounts() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        let freq = vm.streakFrequency
        #expect(freq.threePlus >= 2) // two streaks of 3+
        #expect(freq.fivePlus >= 1) // one streak of 5+
        #expect(freq.tenPlus == 0)
    }

    @Test("Empty history returns all zeros")
    @MainActor
    func emptyStreakFrequency() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        let freq = vm.streakFrequency
        #expect(freq.threePlus == 0)
        #expect(freq.fivePlus == 0)
        #expect(freq.tenPlus == 0)
    }

    // MARK: - improve-036: Operation ranking by Elo

    @Test("Operations sorted by Elo descending")
    @MainActor
    func operationRanking() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.eloAdd = 1200
        vm.eloSubtract = 900
        vm.eloMultiply = 1400
        vm.eloDivide = 1000
        let ranking = vm.operationRanking
        #expect(ranking.first?.symbol == "×")
        #expect(ranking.last?.symbol == "-")
        #expect(ranking.count == 4)
    }

    // MARK: - improve-037: Problems solved by difficulty

    @Test("StatsViewModel exposes problems solved per difficulty")
    @MainActor
    func problemsSolvedByDifficulty() {
        let stats = PlayerStats()
        stats.problemsSolvedEasy = 50
        stats.problemsSolvedMedium = 30
        stats.problemsSolvedHard = 10
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadProblemsSolved(from: stats)
        #expect(vm.problemsSolvedEasy == 50)
        #expect(vm.problemsSolvedMedium == 30)
        #expect(vm.problemsSolvedHard == 10)
    }

    @Test("Default problems solved are 0")
    @MainActor
    func defaultProblemsSolved() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        #expect(vm.problemsSolvedEasy == 0)
        #expect(vm.problemsSolvedMedium == 0)
        #expect(vm.problemsSolvedHard == 0)
    }

    // MARK: - improve-038: Answer speed classification

    @Test("Answers classified as fast, normal, or slow")
    @MainActor
    func speedClassification() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 1.0 // fast
        var p2 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p2.timeTaken = 3.0 // normal
        var p3 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p3.timeTaken = 7.0 // slow

        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2, p3], previouslyUnlockedIds: [])
        let dist = vm.answerSpeedDistribution
        #expect(dist.fast == 1)
        #expect(dist.normal == 1)
        #expect(dist.slow == 1)
    }

    @Test("No time data returns empty distribution")
    @MainActor
    func noTimeSpeedDistribution() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        let dist = vm.answerSpeedDistribution
        #expect(dist.fast == 0)
        #expect(dist.normal == 0)
        #expect(dist.slow == 0)
    }

    // MARK: - improve-039: Most improved operation

    @Test("Most improved operation identified")
    @MainActor
    func mostImprovedOperation() {
        // Early add: wrong, Late add: correct => improved
        // Early subtract: correct, Late subtract: correct => stable
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 5, operand2: 2, operation: .subtract), userAnswer: 3), // correct
            AnsweredProblem(problem: MathProblem(operand1: 3, operand2: 1, operation: .add), userAnswer: 4), // correct
            AnsweredProblem(problem: MathProblem(operand1: 6, operand2: 1, operation: .subtract), userAnswer: 5), // correct
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        // add went from 0% to 100%, subtract stayed at 100%
        #expect(vm.mostImprovedOperation == .add)
    }

    @Test("Returns nil with insufficient data")
    @MainActor
    func insufficientDataMostImproved() {
        let p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1], previouslyUnlockedIds: [])
        #expect(vm.mostImprovedOperation == nil)
    }
}
