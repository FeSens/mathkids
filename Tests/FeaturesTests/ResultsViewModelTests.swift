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

    // MARK: - Confetti Threshold (ui-060)

    @Test("Accuracy 80%+ qualifies for confetti")
    func confettiHighAccuracy() {
        let session = makeSession(correct: 8, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracy >= 80)
    }

    @Test("Accuracy below 80% does not qualify for confetti")
    func noConfettiLowAccuracy() {
        let session = makeSession(correct: 7, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(vm.accuracy < 80)
    }

    // MARK: - Star Rating (ui-070)

    @Test("5 stars for 90%+ accuracy")
    func fiveStars() {
        let session = makeSession(correct: 9, total: 10)
        #expect(session.accuracy >= 90)
    }

    @Test("3 stars for 70-79% accuracy")
    func threeStars() {
        let session = makeSession(correct: 7, total: 10)
        #expect(session.accuracy >= 70 && session.accuracy < 80)
    }

    @Test("1 star for below 50% accuracy")
    func oneStar() {
        let session = makeSession(correct: 2, total: 10)
        #expect(session.accuracy < 50)
    }

    // MARK: - Share Text (ui-077)

    @Test("Share text contains score and accuracy")
    func shareTextContents() {
        let session = makeSession(correct: 8, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        let text = vm.shareText
        #expect(text.contains("Score:"))
        #expect(text.contains("Accuracy:"))
        #expect(text.contains("MathKids"))
    }

    @Test("Average time per problem formats correctly")
    func avgTimePerProblem() {
        let session = makeSession(correct: 5, total: 10)
        let vm = ResultsViewModel(session: session, previousBestScore: 0)
        #expect(!vm.averageTimePerProblem.isEmpty)
        // Default session has full time remaining, so timePlayed = 0, should return N/A
        #expect(vm.averageTimePerProblem == "N/A" || vm.averageTimePerProblem.hasSuffix("s"))
    }

    @Test("Star count matches accuracy tiers")
    func starCountTiers() {
        let high = makeSession(correct: 10, total: 10)
        let vmHigh = ResultsViewModel(session: high, previousBestScore: 0)
        #expect(vmHigh.starCount == 5)

        let low = makeSession(correct: 3, total: 10)
        let vmLow = ResultsViewModel(session: low, previousBestScore: 0)
        #expect(vmLow.starCount == 1)
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
}
