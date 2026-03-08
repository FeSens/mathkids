import Testing
@testable import MathKids

@Suite("GameEngine Tests")
struct GameEngineTests {
    @Test("Adaptive range starts nil")
    @MainActor
    func adaptiveRangeStartsNil() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.adaptiveRange == nil)
    }

    @Test("Adaptive range increases after 5 consecutive correct")
    @MainActor
    func adaptiveRangeIncreasesAfter5Correct() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()

        for _ in 0..<5 {
            let correct = engine.currentProblem.correctAnswer
            engine.submitAnswer(correct)
        }

        #expect(engine.adaptiveRange != nil)
        let baseUpper = DifficultyLevel.easy.operandRange.upperBound
        #expect(engine.adaptiveRange!.upperBound > baseUpper)
    }

    @Test("Adaptive range decreases after 3 consecutive wrong")
    @MainActor
    func adaptiveRangeDecreasesAfter3Wrong() {
        let engine = GameEngine(difficulty: .medium)
        engine.startGame()

        for _ in 0..<3 {
            engine.submitAnswer(999999)
        }

        #expect(engine.adaptiveRange != nil)
        let baseUpper = DifficultyLevel.medium.operandRange.upperBound
        #expect(engine.adaptiveRange!.upperBound < baseUpper)
    }

    @Test("Adaptive range stays within bounds")
    @MainActor
    func adaptiveRangeStaysWithinBounds() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()

        // Many correct answers to push range up
        for _ in 0..<20 {
            let correct = engine.currentProblem.correctAnswer
            engine.submitAnswer(correct)
        }

        if let range = engine.adaptiveRange {
            let baseUpper = DifficultyLevel.easy.operandRange.upperBound
            #expect(range.upperBound <= baseUpper * 2)
            #expect(range.lowerBound >= DifficultyLevel.easy.operandRange.lowerBound)
        }
    }

    @Test("Reset adaptive range clears state")
    @MainActor
    func resetAdaptiveRange() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()

        for _ in 0..<5 {
            let correct = engine.currentProblem.correctAnswer
            engine.submitAnswer(correct)
        }
        #expect(engine.adaptiveRange != nil)

        engine.resetAdaptiveRange()
        #expect(engine.adaptiveRange == nil)
    }

    @Test("Streak freeze awarded at 10-streak")
    @MainActor
    func streakFreezeAwardedAt10() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        #expect(engine.hasStreakFreeze == false)

        for _ in 0..<10 {
            let correct = engine.currentProblem.correctAnswer
            engine.submitAnswer(correct)
        }

        #expect(engine.hasStreakFreeze == true)
    }

    @Test("Streak freeze protects streak on wrong answer")
    @MainActor
    func streakFreezeProtectsStreak() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()

        for _ in 0..<10 {
            let correct = engine.currentProblem.correctAnswer
            engine.submitAnswer(correct)
        }
        #expect(engine.hasStreakFreeze == true)
        let streakBefore = engine.currentStreak

        engine.submitAnswer(999999)
        #expect(engine.currentStreak == streakBefore)
        #expect(engine.hasStreakFreeze == false)
        #expect(engine.streakFreezeUsed == true)
    }

    @Test("Streak freeze consumed after one use")
    @MainActor
    func streakFreezeConsumedAfterUse() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()

        for _ in 0..<10 {
            let correct = engine.currentProblem.correctAnswer
            engine.submitAnswer(correct)
        }

        // First wrong - protected
        engine.submitAnswer(999999)
        #expect(engine.hasStreakFreeze == false)

        // Second wrong - not protected, streak resets
        engine.submitAnswer(999999)
        #expect(engine.currentStreak == 0)
    }

    // MARK: - Full Problem History (ui-145)

    @Test("Problem history retains all answers not just last 5")
    @MainActor
    func problemHistoryRetainsAll() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        for _ in 0..<8 {
            let answer = engine.currentProblem.correctAnswer
            engine.submitAnswer(answer)
        }
        #expect(engine.problemHistory.count == 8)
    }

    // MARK: - Response Time Tracking (ui-146)

    @Test("Problem history records timeTaken")
    @MainActor
    func problemHistoryRecordsTime() async throws {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        try await Task.sleep(for: .milliseconds(100))
        let answer = engine.currentProblem.correctAnswer
        engine.submitAnswer(answer)
        let entry = engine.problemHistory.first
        #expect(entry != nil)
        #expect(entry?.timeTaken != nil)
        #expect(entry!.timeTaken! > 0)
    }

    // MARK: - Fastest Answer Time (ui-179)

    @Test("Fastest answer time starts nil")
    @MainActor
    func fastestTimeStartsNil() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.fastestAnswerTime == nil)
    }

    @Test("Fastest answer time recorded on correct answer")
    @MainActor
    func fastestTimeRecorded() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        let answer = engine.currentProblem.correctAnswer
        engine.submitAnswer(answer)
        #expect(engine.fastestAnswerTime != nil)
    }

    // MARK: - Correct Count By Operation (logic-210)

    @Test("Correct count by operation starts empty")
    @MainActor
    func correctCountByOperationStartsEmpty() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.correctCountByOperation.isEmpty)
    }

    @Test("Correct count tracks correct answers per operation")
    @MainActor
    func correctCountTracksPerOperation() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        let answer = engine.currentProblem.correctAnswer
        let op = engine.currentProblem.operation
        engine.submitAnswer(answer)
        #expect(engine.correctCountByOperation[op] == 1)
    }

    @Test("Wrong answers not counted in correctCountByOperation")
    @MainActor
    func wrongAnswersNotCounted() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        engine.submitAnswer(99999) // Wrong answer
        let total = engine.correctCountByOperation.values.reduce(0, +)
        #expect(total == 0)
    }

    // MARK: - Operation Frequency (logic-220)

    @Test("Operation frequency starts empty")
    @MainActor
    func operationFrequencyStartsEmpty() {
        let engine = GameEngine(difficulty: .easy)
        #expect(engine.operationFrequency.isEmpty)
    }

    @Test("Operation frequency tracks all answers")
    @MainActor
    func operationFrequencyTracks() {
        let engine = GameEngine(difficulty: .easy)
        engine.startGame()
        let op = engine.currentProblem.operation
        engine.submitAnswer(99999) // wrong but still counted
        #expect(engine.operationFrequency[op] == 1)
    }
}
