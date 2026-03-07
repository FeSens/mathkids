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
}
