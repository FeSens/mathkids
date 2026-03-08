import Testing
@testable import MathKids

@Suite("Improvement Round 6 Tests")
struct ImproveRound6Tests {

    // MARK: - improve-025: Fastest answer time per operation

    @Test("Fastest time per operation computed from history")
    @MainActor
    func fastestTimePerOp() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 3.0
        var p2 = AnsweredProblem(problem: MathProblem(operand1: 4, operand2: 2, operation: .add), userAnswer: 6)
        p2.timeTaken = 1.5
        var p3 = AnsweredProblem(problem: MathProblem(operand1: 5, operand2: 2, operation: .subtract), userAnswer: 3)
        p3.timeTaken = 2.0

        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2, p3], previouslyUnlockedIds: [])
        let fastest = vm.fastestTimePerOperation
        #expect(fastest[.add] == 1.5)
        #expect(fastest[.subtract] == 2.0)
    }

    @Test("Only correct answers count for fastest time")
    @MainActor
    func onlyCorrectForFastest() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4) // wrong
        p1.timeTaken = 1.0
        var p2 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5) // correct
        p2.timeTaken = 3.0

        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2], previouslyUnlockedIds: [])
        #expect(vm.fastestTimePerOperation[.add] == 3.0)
    }

    @Test("No time data returns empty dictionary")
    @MainActor
    func noTimeDataEmpty() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.fastestTimePerOperation.isEmpty)
    }

    // MARK: - improve-026: Streak milestone summary

    @Test("Best streak >= 5 shows milestone text")
    @MainActor
    func streakMilestoneText() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.streakMilestoneText != nil)
        #expect(vm.streakMilestoneText!.contains("5"))
    }

    @Test("Best streak < 5 returns nil milestone")
    @MainActor
    func noStreakMilestone() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<3 { session.recordAnswer(correct: true, bonusPoints: 0) }
        session.recordAnswer(correct: false, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.streakMilestoneText == nil)
    }

    @Test("Streak of 10+ shows special text")
    @MainActor
    func bigStreakMilestone() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.recordAnswer(correct: true, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.streakMilestoneText != nil)
        #expect(vm.streakMilestoneText!.contains("10"))
    }

    // MARK: - improve-027: Problem difficulty distribution

    @Test("Problems categorized by difficulty rating")
    @MainActor
    func difficultyDistribution() {
        let p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        let p2 = AnsweredProblem(problem: MathProblem(operand1: 50, operand2: 30, operation: .add), userAnswer: 80)
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1, p2], previouslyUnlockedIds: [])
        let dist = vm.problemDifficultyDistribution
        #expect(!dist.isEmpty)
    }

    @Test("Empty history returns empty distribution")
    @MainActor
    func emptyDistribution() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.problemDifficultyDistribution.isEmpty)
    }

    // MARK: - improve-028: Accuracy improvement over halves

    @Test("First half and second half accuracy computed")
    @MainActor
    func halvesAccuracy() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        let improvement = vm.accuracyImprovementOverHalves
        #expect(improvement != nil)
        #expect(improvement! > 0) // improved from 0% to 100%
    }

    @Test("Few problems returns nil for insufficient data")
    @MainActor
    func insufficientDataHalves() {
        let p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1], previouslyUnlockedIds: [])
        #expect(vm.accuracyImprovementOverHalves == nil)
    }

    // MARK: - improve-029: Consecutive correct analysis

    @Test("Longest consecutive correct run computed")
    @MainActor
    func longestConsecutiveCorrect() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.longestCorrectRun == 2)
    }

    @Test("Empty history returns 0")
    @MainActor
    func emptyHistoryZeroRun() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.longestCorrectRun == 0)
    }

    @Test("All correct returns total count")
    @MainActor
    func allCorrectRun() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 4, operand2: 1, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 3, operand2: 2, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.longestCorrectRun == 3)
    }
}
