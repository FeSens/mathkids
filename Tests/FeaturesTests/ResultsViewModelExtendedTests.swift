import Testing
@testable import MathKids

@MainActor
@Suite("ResultsViewModel Extended Tests")
struct ResultsViewModelExtendedTests {

    private func makeSession(correct: Int, total: Int, difficulty: DifficultyLevel = .easy) -> GameSession {
        var session = GameSession(difficulty: difficulty)
        for i in 0..<total {
            session.recordAnswer(correct: i < correct, bonusPoints: 0)
        }
        return session
    }

    // MARK: - Score Comparison (ui-091)

    @Test("Score improvement shown when beating previous best")
    func scoreImprovement() {
        let session = makeSession(correct: 8, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 10)
        #expect(vm.scoreImprovement > 0)
    }

    @Test("Score decline shown when below previous best")
    func scoreDecline() {
        let session = makeSession(correct: 2, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 1000)
        #expect(vm.scoreImprovement < 0)
    }

    @Test("Score improvement is zero for first game")
    func scoreImprovementFirstGame() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.scoreImprovement >= 0)
    }

    // MARK: - Difficulty Recommendation (ui-093)

    @Test("Suggests harder difficulty for 90%+ on easy")
    func suggestsHarderOnEasy() {
        let session = makeSession(correct: 10, total: 10, difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyRecommendation == .tryHarder)
    }

    @Test("Suggests easier difficulty for below 50% on hard")
    func suggestsEasierOnHard() {
        let session = makeSession(correct: 3, total: 10, difficulty: .hard)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyRecommendation == .tryEasier)
    }

    @Test("No recommendation for mid-range accuracy")
    func noRecommendationMidRange() {
        let session = makeSession(correct: 7, total: 10, difficulty: .medium)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyRecommendation == .stayHere)
    }

    @Test("No harder suggestion when already on hard")
    func noHarderOnHard() {
        let session = makeSession(correct: 10, total: 10, difficulty: .hard)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyRecommendation == .stayHere)
    }

    @Test("No easier suggestion when already on easy")
    func noEasierOnEasy() {
        let session = makeSession(correct: 3, total: 10, difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.difficultyRecommendation == .stayHere)
    }

    // MARK: - XP Progress (ui-095)

    @Test("XP progress returns a value between 0 and 1")
    func xpProgress() {
        let session = makeSession(correct: 5, total: 10)
        let stats = PlayerStats()
        let vm = ResultsViewModel(session: session, previousBestScore: 0, stats: stats)
        #expect(vm.xpProgressFraction >= 0.0 && vm.xpProgressFraction <= 1.0)
    }

    @Test("XP progress text shows current/next format")
    func xpProgressText() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.xpProgressLabel.contains("/"))
    }

    // MARK: - Operation Breakdown (ui-102)

    @Test("Operation breakdown is empty without problem history")
    func operationBreakdownEmpty() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.operationBreakdown.isEmpty)
    }

    // MARK: - Perfect Score (ui-134)

    @Test("Perfect score detected at 100%")
    func perfectScore() {
        let session = makeSession(correct: 10, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.isPerfectScore == true)
    }

    @Test("Not perfect score under 100%")
    func notPerfectScore() {
        let session = makeSession(correct: 9, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.isPerfectScore == false)
    }

    @Test("Operation breakdown counts operations")
    func operationBreakdownCounts() {
        let session = makeSession(correct: 2, total: 2)
        let p1 = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let p2 = MathProblem(operand1: 5, operand2: 2, operation: .add)
        let history = [
            AnsweredProblem(problem: p1, userAnswer: 5),
            AnsweredProblem(problem: p2, userAnswer: 7)
        ]
        let vm = ResultsViewModel(session: session, previousBestScore: 0, problemHistory: history)
        #expect(vm.operationBreakdown.count == 1)
        #expect(vm.operationBreakdown[0].count == 2)
    }

    // MARK: - Total Time Played (ui-153)

    @Test("Total time played shows seconds")
    func totalTimePlayedShowsSeconds() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<10 { session.tick() }
        session.recordAnswer(correct: true)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.totalTimePlayed == "10s")
    }

    // MARK: - Share Text (ui-159)

    @Test("Share text includes difficulty name")
    func shareTextIncludesDifficulty() {
        let session = makeSession(correct: 5, total: 10, difficulty: .medium)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.shareText.contains("Medium"))
    }

    // MARK: - New Personal Best (logic-207)

    @Test("isNewPersonalBest true when score exceeds previous best for difficulty")
    func newPersonalBestTrue() {
        let session = makeSession(correct: 5, total: 5)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, previousBestForDifficulty: 20)
        #expect(vm.isNewPersonalBest == true)
    }

    @Test("isNewPersonalBest false when score below previous best for difficulty")
    func newPersonalBestFalse() {
        let session = makeSession(correct: 1, total: 5)
        let vm = ResultsViewModel(session: session, previousBestScore: 0, previousBestForDifficulty: 100)
        #expect(vm.isNewPersonalBest == false)
    }

    // MARK: - Problems Per Minute Text (logic-213)

    @Test("Problems per minute N/A when no time")
    func problemsPerMinuteNA() {
        let session = GameSession(difficulty: .easy)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.problemsPerMinuteText == "N/A")
    }

    @Test("Problems per minute shows formatted rate")
    func problemsPerMinuteFormatted() {
        var session = GameSession(difficulty: .easy)
        for _ in 0..<30 { session.tick() }
        for _ in 0..<10 { session.recordAnswer(correct: true) }
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.problemsPerMinuteText == "20.0")
    }

    // MARK: - Operation Accuracy Breakdown (logic-227)

    // MARK: - Fastest Answer Text (logic-242)

    @Test("Fastest answer text nil by default")
    func fastestAnswerTextNil() {
        let session = makeSession(correct: 1, total: 1)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.fastestAnswerTime == nil) // no engine data
    }

    @Test("Fastest answer text can be set")
    func fastestAnswerTextSet() {
        let session = makeSession(correct: 1, total: 1)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        vm.fastestAnswerTime = "1.5s"
        #expect(vm.fastestAnswerTime == "1.5s")
    }

    // MARK: - Score Comparison Text (logic-248)

    @Test("Score comparison for new best")
    func scoreComparisonNewBest() {
        let session = makeSession(correct: 10, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 50)
        #expect(vm.scoreComparisonText.contains("New"))
    }

    @Test("Score comparison below best")
    func scoreComparisonBelowBest() {
        let session = makeSession(correct: 1, total: 5)
        let vm = ResultsViewModel(session: session, previousBestScore: 500)
        #expect(!vm.scoreComparisonText.contains("New"))
    }

    @Test("Operation accuracy from problem history")
    func operationAccuracyBreakdown() {
        let session = makeSession(correct: 3, total: 4)
        let p1 = MathProblem(operand1: 2, operand2: 3, operation: .add)
        let p2 = MathProblem(operand1: 5, operand2: 2, operation: .add)
        let p3 = MathProblem(operand1: 4, operand2: 1, operation: .add)
        let history = [
            AnsweredProblem(problem: p1, userAnswer: 5),  // correct
            AnsweredProblem(problem: p2, userAnswer: 7),  // correct
            AnsweredProblem(problem: p3, userAnswer: 99)  // wrong
        ]
        let vm = ResultsViewModel(session: session, previousBestScore: 0, problemHistory: history)
        let addAccuracy = vm.operationAccuracy[.add]
        #expect(addAccuracy != nil)
        #expect(addAccuracy! > 66)
        #expect(addAccuracy! < 67)
    }

    // MARK: - Grade Label (logic-253)

    @Test("Grade A+ for 95%+ accuracy")
    func gradeAPlus() {
        let session = makeSession(correct: 10, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.gradeLabel == "A+")
    }

    @Test("Grade A for 90-94% accuracy")
    func gradeA() {
        let session = makeSession(correct: 9, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.gradeLabel == "A")
    }

    @Test("Grade B for 80-89% accuracy")
    func gradeB() {
        let session = makeSession(correct: 8, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.gradeLabel == "B")
    }

    @Test("Grade C for 70-79% accuracy")
    func gradeC() {
        let session = makeSession(correct: 7, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.gradeLabel == "C")
    }

    @Test("Grade D for 60-69% accuracy")
    func gradeD() {
        let session = makeSession(correct: 6, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.gradeLabel == "D")
    }

    @Test("Grade F for below 60% accuracy")
    func gradeF() {
        let session = makeSession(correct: 3, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.gradeLabel == "F")
    }

    // MARK: - Improvement Summary (logic-258)

    @Test("Perfect score shows celebration text")
    func improvementSummaryPerfect() {
        let session = makeSession(correct: 10, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.improvementSummary.lowercased().contains("perfect"))
    }

    @Test("High accuracy shows positive text")
    func improvementSummaryHigh() {
        let session = makeSession(correct: 8, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(!vm.improvementSummary.isEmpty)
    }

    @Test("Low accuracy suggests practice")
    func improvementSummaryLow() {
        let session = makeSession(correct: 3, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.improvementSummary.lowercased().contains("practice") || vm.improvementSummary.lowercased().contains("keep"))
    }

    // MARK: - Time Performance Text (logic-268)

    @Test("Shows N/A when no time played")
    func timePerformanceNA() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timePerformanceText == "N/A")
    }

    @Test("Shows Lightning fast when faster than target")
    func timePerformanceFast() {
        var session = GameSession(difficulty: .easy) // target 6s
        for _ in 0..<10 { session.tick() } // 10 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 2s per answer
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timePerformanceText.contains("Lightning"))
    }

    @Test("Shows On pace when near target")
    func timePerformanceOnPace() {
        var session = GameSession(difficulty: .easy) // target 6s
        for _ in 0..<30 { session.tick() } // 30 seconds
        for _ in 0..<5 { session.recordAnswer(correct: true) } // 6s per answer
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.timePerformanceText.contains("pace"))
    }
}
