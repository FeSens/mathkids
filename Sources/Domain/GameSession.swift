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
    private(set) var bestStreakOperation: Operation?
    private var currentStreakOperation: Operation?
    private var currentOperationStreak: Int = 0
    private var bestOperationStreak: Int = 0
    private var correctPerOperation: [Operation: Int] = [:]
    private var totalPerOperation: [Operation: Int] = [:]

    init(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
        self.timeRemaining = difficulty.timeLimitSeconds
    }

    var totalTimePlayed: Int {
        difficulty.timeLimitSeconds - timeRemaining
    }

    var accuracy: Double {
        guard totalAnswered > 0 else { return 0 }
        return Double(totalCorrect) / Double(totalAnswered) * 100
    }

    func accuracyForOperation(_ operation: Operation) -> Double {
        guard let total = totalPerOperation[operation], total > 0 else { return 0 }
        let correct = correctPerOperation[operation] ?? 0
        return Double(correct) / Double(total) * 100
    }

    mutating func recordAnswer(correct: Bool, bonusPoints: Int = 0, operation: Operation? = nil) {
        if let op = operation {
            totalPerOperation[op, default: 0] += 1
            if correct { correctPerOperation[op, default: 0] += 1 }
        }
        totalAnswered += 1
        if correct {
            totalCorrect += 1
            currentStreak += 1
            if currentStreak > bestStreak {
                bestStreak = currentStreak
            }
            score += difficulty.pointsPerCorrect + bonusPoints

            if let op = operation {
                if op == currentStreakOperation {
                    currentOperationStreak += 1
                } else {
                    currentStreakOperation = op
                    currentOperationStreak = 1
                }
                if currentOperationStreak > bestOperationStreak {
                    bestOperationStreak = currentOperationStreak
                    bestStreakOperation = op
                }
            }
        } else {
            currentStreak = 0
            currentStreakOperation = nil
            currentOperationStreak = 0
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

    var problemsPerMinute: Double {
        let minutes = Double(totalTimePlayed) / 60.0
        guard minutes > 0 else { return 0 }
        return Double(totalAnswered) / minutes
    }

    mutating func endGame() {
        isFinished = true
    }
}
