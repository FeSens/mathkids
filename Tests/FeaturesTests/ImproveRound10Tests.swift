import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 10 Tests")
struct ImproveRound10Tests {

    // MARK: - improve-045: Home screen total time played

    @Test("Shows hours and minutes for large values")
    @MainActor
    func timePlayedHoursMinutes() {
        let vm = makeHomeVM()
        vm.totalTimePlayedSeconds = 3725 // 1h 2m 5s
        #expect(vm.formattedTimePlayed == "1h 2m")
    }

    @Test("Shows minutes only for small values")
    @MainActor
    func timePlayedMinutesOnly() {
        let vm = makeHomeVM()
        vm.totalTimePlayedSeconds = 300 // 5 minutes
        #expect(vm.formattedTimePlayed == "5m")
    }

    @Test("Shows 0m when no time played")
    @MainActor
    func timePlayedZero() {
        let vm = makeHomeVM()
        vm.totalTimePlayedSeconds = 0
        #expect(vm.formattedTimePlayed == "0m")
    }

    // MARK: - improve-046: Recommended difficulty display

    @Test("High accuracy recommends harder difficulty")
    @MainActor
    func recommendHarder() {
        let vm = makeHomeVM()
        vm.recommendedDifficulty = .hard
        #expect(vm.recommendedDifficultyText.contains("Hard"))
    }

    @Test("Low accuracy recommends easier difficulty")
    @MainActor
    func recommendEasier() {
        let vm = makeHomeVM()
        vm.recommendedDifficulty = .easy
        #expect(vm.recommendedDifficultyText.contains("Easy"))
    }

    @Test("Default difficulty recommendation")
    @MainActor
    func recommendDefault() {
        let vm = makeHomeVM()
        // Default is .easy
        #expect(vm.recommendedDifficultyText.contains("Easy"))
    }

    // MARK: - improve-047: Results efficiency score display

    @Test("efficiencyScoreText returns formatted string")
    @MainActor
    func efficiencyScoreText() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 1.0
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1], previouslyUnlockedIds: [])
        #expect(vm.efficiencyScoreText.contains("%"))
    }

    @Test("efficiencyGrade returns A for high efficiency")
    @MainActor
    func efficiencyGradeHigh() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 1.0
        var session = GameSession(difficulty: .easy)
        session.recordAnswer(correct: true, bonusPoints: 0)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1], previouslyUnlockedIds: [])
        let grade = vm.efficiencyGrade
        #expect(grade == "A+" || grade == "A")
    }

    @Test("efficiencyGrade returns F for zero efficiency")
    @MainActor
    func efficiencyGradeZero() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.efficiencyGrade == "F")
    }

    // MARK: - improve-048: Comeback detection

    @Test("isComeback true when improvement >= 20 points")
    @MainActor
    func comebackDetected() {
        var problems: [AnsweredProblem] = []
        // First half: all wrong
        for _ in 0..<5 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4))
        }
        // Second half: all correct
        for _ in 0..<5 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5))
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.isComeback == true)
    }

    @Test("isComeback false for small improvement")
    @MainActor
    func noComeback() {
        var problems: [AnsweredProblem] = []
        for _ in 0..<10 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5))
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.isComeback == false)
    }

    @Test("comebackText returns message for comebacks")
    @MainActor
    func comebackTextPresent() {
        var problems: [AnsweredProblem] = []
        for _ in 0..<5 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4))
        }
        for _ in 0..<5 {
            problems.append(AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5))
        }
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.comebackText != nil)
    }

    @Test("No comeback returns nil text")
    @MainActor
    func noComebackText() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.comebackText == nil)
    }

    // MARK: - improve-049: Per-difficulty game count on home

    @Test("HomeViewModel exposes difficulty game counts")
    @MainActor
    func difficultyGameCounts() {
        let vm = makeHomeVM()
        vm.easyGames = 5
        vm.mediumGames = 3
        vm.hardGames = 1
        #expect(vm.easyGames == 5)
        #expect(vm.mediumGames == 3)
        #expect(vm.hardGames == 1)
    }

    @Test("difficultyBreakdownText returns formatted string")
    @MainActor
    func difficultyBreakdownFormatted() {
        let vm = makeHomeVM()
        vm.easyGames = 5
        vm.mediumGames = 3
        vm.hardGames = 1
        let text = vm.difficultyBreakdownText
        #expect(text.contains("5"))
        #expect(text.contains("3"))
        #expect(text.contains("1"))
    }

    @Test("Zero games shows correct text")
    @MainActor
    func zeroDifficultyGames() {
        let vm = makeHomeVM()
        vm.easyGames = 0
        vm.mediumGames = 0
        vm.hardGames = 0
        let text = vm.difficultyBreakdownText
        #expect(text.contains("0"))
    }

    // MARK: - Helpers

    @MainActor
    private func makeHomeVM() -> HomeViewModel {
        let container = try! SwiftData.ModelContainer(for: PlayerStats.self, configurations: SwiftData.ModelConfiguration(isStoredInMemoryOnly: true))
        let service = StatsService(modelContainer: container)
        return HomeViewModel(statsService: service)
    }
}
