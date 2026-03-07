import Foundation
import Observation

@Observable
@MainActor
final class GameEngine {
    private(set) var session: GameSession
    private(set) var currentProblem: MathProblem
    private(set) var lastAnswerCorrect: Bool?
    private(set) var streakMilestone: Int?

    private let generator = ProblemGenerator()
    private let allowedOperations: Set<Operation>?
    private var timer: Timer?
    private(set) var adaptiveRange: ClosedRange<Int>?
    private var consecutiveCorrect: Int = 0
    private var consecutiveWrong: Int = 0

    init(difficulty: DifficultyLevel, allowedOperations: Set<Operation>? = nil) {
        self.session = GameSession(difficulty: difficulty)
        self.allowedOperations = allowedOperations
        self.currentProblem = generator.generate(for: difficulty, allowedOperations: allowedOperations)
    }

    var isGameOver: Bool { session.isFinished }
    var timeRemaining: Int { session.timeRemaining }
    var score: Int { session.score }
    var currentStreak: Int { session.currentStreak }
    var totalAnswered: Int { session.totalAnswered }
    var totalCorrect: Int { session.totalCorrect }
    var accuracy: Double { session.accuracy }
    var bestStreak: Int { session.bestStreak }
    var difficulty: DifficultyLevel { session.difficulty }

    var timeProgress: Double {
        Double(session.timeRemaining) / Double(session.difficulty.timeLimitSeconds)
    }

    func startGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            Task { @MainActor in
                self?.tick()
            }
        }
    }

    func submitAnswer(_ answer: Int) {
        let correct = currentProblem.isCorrect(answer: answer)
        let speedBonus = session.timeRemaining > session.difficulty.timeLimitSeconds / 2 ? 5 : 0
        session.recordAnswer(correct: correct, bonusPoints: correct ? speedBonus : 0)

        lastAnswerCorrect = correct

        if correct {
            consecutiveCorrect += 1
            consecutiveWrong = 0
            let streak = session.currentStreak
            if streak > 0 && streak % 5 == 0 {
                streakMilestone = streak
            } else {
                streakMilestone = nil
            }
        } else {
            consecutiveWrong += 1
            consecutiveCorrect = 0
            streakMilestone = nil
        }

        updateAdaptiveRange()

        if !session.isFinished {
            currentProblem = generator.generate(for: session.difficulty, allowedOperations: allowedOperations, adaptiveRange: adaptiveRange)
        }
    }

    private func updateAdaptiveRange() {
        let baseRange = session.difficulty.operandRange
        let baseLower = baseRange.lowerBound
        let baseUpper = baseRange.upperBound

        if consecutiveCorrect >= 5 {
            // Increase range by 25%, capped at 2x base upper
            let currentUpper = adaptiveRange?.upperBound ?? baseUpper
            let newUpper = min(currentUpper + baseUpper / 4, baseUpper * 2)
            adaptiveRange = baseLower...newUpper
        } else if consecutiveWrong >= 3 {
            // Decrease range by 25%, floored at half base upper (minimum 2)
            let currentUpper = adaptiveRange?.upperBound ?? baseUpper
            let newUpper = max(currentUpper - baseUpper / 4, max(baseUpper / 2, 2))
            adaptiveRange = baseLower...newUpper
        }
    }

    func resetAdaptiveRange() {
        adaptiveRange = nil
        consecutiveCorrect = 0
        consecutiveWrong = 0
    }

    func skipToNextProblem() {
        currentProblem = generator.generate(for: session.difficulty, allowedOperations: allowedOperations, adaptiveRange: adaptiveRange)
    }

    func stopGame() {
        timer?.invalidate()
        timer = nil
        session.endGame()
    }

    private func tick() {
        session.tick()
        if session.isFinished {
            timer?.invalidate()
            timer = nil
        }
    }
}
