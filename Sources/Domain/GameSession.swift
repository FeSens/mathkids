import Foundation

struct GameSession: Sendable {
    let difficulty: DifficultyLevel
    private(set) var totalAnswered: Int = 0
    private(set) var totalCorrect: Int = 0
    private(set) var currentStreak: Int = 0
    private(set) var bestStreak: Int = 0
    private(set) var score: Int = 0
    private(set) var timeRemaining: Int
    private(set) var isFinished: Bool = false

    init(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
        self.timeRemaining = difficulty.timeLimitSeconds
    }

    var accuracy: Double {
        guard totalAnswered > 0 else { return 0 }
        return Double(totalCorrect) / Double(totalAnswered) * 100
    }

    mutating func recordAnswer(correct: Bool, bonusPoints: Int = 0) {
        totalAnswered += 1
        if correct {
            totalCorrect += 1
            currentStreak += 1
            if currentStreak > bestStreak {
                bestStreak = currentStreak
            }
            score += difficulty.pointsPerCorrect + bonusPoints
        } else {
            currentStreak = 0
        }
    }

    mutating func restoreStreak(_ streak: Int) {
        currentStreak = streak
    }

    mutating func tick() {
        guard timeRemaining > 0 else { return }
        timeRemaining -= 1
        if timeRemaining == 0 {
            isFinished = true
        }
    }

    mutating func endGame() {
        isFinished = true
    }
}
