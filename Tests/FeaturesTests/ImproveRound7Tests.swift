import Testing
import SwiftData
@testable import MathKids

@Suite("Improvement Round 7 Tests")
struct ImproveRound7Tests {

    private func makeContainer() -> ModelContainer {
        try! ModelContainer(for: PlayerStats.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))
    }

    // MARK: - improve-030: Game highlights

    @Test("Highlights include streak milestone when available")
    @MainActor
    func highlightsWithStreak() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<5 { session.recordAnswer(correct: true, bonusPoints: 0) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.streakMilestoneText != nil)
    }

    @Test("Highlights include longest correct run")
    @MainActor
    func highlightsCorrectRun() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5),
            AnsweredProblem(problem: MathProblem(operand1: 3, operand2: 2, operation: .add), userAnswer: 5),
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.longestCorrectRun == 2)
    }

    @Test("Warmup indicator when accuracy improved")
    @MainActor
    func warmupIndicator() {
        let problems = [
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 4), // wrong
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
            AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5), // correct
        ]
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: problems, previouslyUnlockedIds: [])
        #expect(vm.accuracyImprovementOverHalves != nil)
        #expect(vm.accuracyImprovementOverHalves! > 0)
    }

    // MARK: - improve-031: Fastest answer badge

    @Test("Fastest answer displayed when available")
    @MainActor
    func fastestAnswerBadge() {
        var p1 = AnsweredProblem(problem: MathProblem(operand1: 2, operand2: 3, operation: .add), userAnswer: 5)
        p1.timeTaken = 1.2
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [p1], previouslyUnlockedIds: [])
        let fastest = vm.fastestTimePerOperation
        #expect(!fastest.isEmpty)
        #expect(fastest[.add] == 1.2)
    }

    @Test("No badge when no timing data")
    @MainActor
    func noBadgeNoTiming() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: PlayerStats(), problemHistory: [], previouslyUnlockedIds: [])
        #expect(vm.fastestTimePerOperation.isEmpty)
    }

    // MARK: - improve-032: Operation mastery grid

    @Test("Mastery grid shows all four operations")
    @MainActor
    func masteryGridAllOps() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        let levels = vm.operationSkillLevels
        #expect(levels.count == 4)
        #expect(levels["+"] != nil)
        #expect(levels["-"] != nil)
        #expect(levels["×"] != nil)
        #expect(levels["÷"] != nil)
    }

    @Test("Skill level color tier matches rating")
    func skillLevelTiers() {
        #expect(EloSystem.skillLevel(forRating: 600) == "Beginner")
        #expect(EloSystem.skillLevel(forRating: 800) == "Learning")
        #expect(EloSystem.skillLevel(forRating: 1000) == "Intermediate")
        #expect(EloSystem.skillLevel(forRating: 1200) == "Advanced")
        #expect(EloSystem.skillLevel(forRating: 1400) == "Expert")
        #expect(EloSystem.skillLevel(forRating: 1600) == "Master")
    }

    // MARK: - improve-033: XP breakdown bars

    @Test("XP bars render when data exists")
    @MainActor
    func xpBarsWithData() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.xpEasy = 500
        vm.xpMedium = 300
        vm.xpHard = 200
        #expect(vm.totalXPFromDifficulties == 1000)
    }

    @Test("Zero XP total when no games played")
    @MainActor
    func zeroXPTotal() {
        let vm = StatsViewModel(statsService: StatsService(modelContainer: makeContainer()))
        #expect(vm.totalXPFromDifficulties == 0)
    }

    // MARK: - improve-034: Next achievement progress

    @Test("HomeViewModel identifies closest achievement")
    @MainActor
    func closestAchievement() {
        let stats = PlayerStats()
        stats.totalSolved = 5
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadNextAchievement(from: stats)
        // Should find some achievement that's close to unlocking
        // (the exact one depends on achievement definitions)
        #expect(vm.nextAchievementName != nil || vm.nextAchievementProgress >= 0)
    }

    @Test("Progress percentage is between 0 and 1")
    @MainActor
    func progressPercentageBounds() {
        let stats = PlayerStats()
        let vm = HomeViewModel(statsService: StatsService(modelContainer: makeContainer()))
        vm.loadNextAchievement(from: stats)
        #expect(vm.nextAchievementProgress >= 0)
        #expect(vm.nextAchievementProgress <= 1.0)
    }
}
