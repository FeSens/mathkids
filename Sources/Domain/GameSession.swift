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
    private(set) var totalBonusPoints: Int = 0
    private(set) var bestStreakOperation: Operation?
    private var currentStreakOperation: Operation?
    private var currentOperationStreak: Int = 0
    private var bestOperationStreak: Int = 0
    private var answerHistory: [Bool] = []
    private var correctPerOperation: [Operation: Int] = [:]
    private var totalPerOperation: [Operation: Int] = [:]

    init(difficulty: DifficultyLevel) {
        self.difficulty = difficulty
        self.timeRemaining = difficulty.timeLimitSeconds
    }

    var totalTimePlayed: Int {
        difficulty.timeLimitSeconds - timeRemaining
    }

    var correctAnswerCount: Int {
        totalCorrect
    }

    var isHighScore: Bool {
        score >= 100
    }

    var streakText: String {
        "\(currentStreak) streak"
    }

    var isLowScore: Bool {
        score < 50
    }

    var scoringRate: Int {
        guard totalTimePlayed > 0 else { return 0 }
        return score * 60 / totalTimePlayed
    }

    var isFirstHalf: Bool {
        totalTimePlayed <= difficulty.timeLimitSeconds / 2
    }

    var isAlmostDone: Bool {
        timeRemaining > 0 && timeRemaining <= 10
    }

    var secondsPerAnswer: Int {
        guard totalAnswered > 0 else { return 0 }
        return totalTimePlayed / totalAnswered
    }

    var timeElapsedPercentage: Int {
        guard difficulty.timeLimitSeconds > 0 else { return 0 }
        return (totalTimePlayed * 100) / difficulty.timeLimitSeconds
    }

    var hasStarted: Bool {
        totalAnswered > 0
    }

    var answeredProblemCount: Int {
        totalAnswered
    }

    var isHalfwayDone: Bool {
        totalTimePlayed > difficulty.timeLimitSeconds / 2
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
        answerHistory.append(correct)
        totalAnswered += 1
        if correct {
            totalCorrect += 1
            currentStreak += 1
            if currentStreak > bestStreak {
                bestStreak = currentStreak
            }
            totalBonusPoints += bonusPoints
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

    // MARK: - Properties requiring answerHistory access

    var firstHalfAccuracy: Double {
        guard !answerHistory.isEmpty else { return 0 }
        let half = answerHistory.count / 2
        guard half > 0 else { return 0 }
        let firstHalf = Array(answerHistory.prefix(half))
        let correct = firstHalf.filter { $0 }.count
        return Double(correct) / Double(firstHalf.count) * 100
    }

    var secondHalfAccuracy: Double {
        guard answerHistory.count >= 2 else { return 0 }
        let half = answerHistory.count / 2
        let secondHalf = Array(answerHistory.suffix(answerHistory.count - half))
        guard !secondHalf.isEmpty else { return 0 }
        let correct = secondHalf.filter { $0 }.count
        return Double(correct) / Double(secondHalf.count) * 100
    }

    var improvementRate: Double {
        guard totalAnswered >= 4 else { return 0 }
        return secondHalfAccuracy - firstHalfAccuracy
    }

    var isComeback: Bool {
        guard totalAnswered >= 4 else { return false }
        return secondHalfAccuracy - firstHalfAccuracy >= 20
    }

    var efficiencyScore: Double {
        guard totalAnswered > 0, totalTimePlayed > 0 else { return 0 }
        let accuracyFactor = accuracy / 100.0
        let speedFactor = min(Double(totalAnswered) / (Double(totalTimePlayed) / 60.0) / 20.0, 1.0)
        return min((accuracyFactor * 0.7 + speedFactor * 0.3) * 100, 100)
    }

    enum SessionTrend: Sendable {
        case improving, declining, stable
    }

    var sessionAccuracyTrend: SessionTrend {
        guard totalAnswered >= 4 else { return .stable }
        let diff = secondHalfAccuracy - firstHalfAccuracy
        if diff > 10 { return .improving }
        if diff < -10 { return .declining }
        return .stable
    }

    var estimatedQuestionsRemaining: Int? {
        guard !isFinished else { return 0 }
        guard totalAnswered > 0, totalTimePlayed > 0 else { return nil }
        let avgTimePerQuestion = Double(totalTimePlayed) / Double(totalAnswered)
        guard avgTimePerQuestion > 0 else { return nil }
        return Int(Double(timeRemaining) / avgTimePerQuestion)
    }

    var answerConsistency: Double {
        guard !answerHistory.isEmpty else { return 0 }
        let correctCount = answerHistory.filter { $0 }.count
        let ratio = Double(correctCount) / Double(answerHistory.count)
        return ratio * 100
    }

    var wrongAnswerPositions: [Int] {
        answerHistory.enumerated().compactMap { $0.element ? nil : $0.offset }
    }

    func lastNAccuracy(n: Int) -> Double {
        guard !answerHistory.isEmpty else { return 0 }
        let count = min(n, answerHistory.count)
        let lastN = Array(answerHistory.suffix(count))
        let correct = lastN.filter { $0 }.count
        return Double(correct) / Double(lastN.count) * 100
    }

    func accuracyForRange(start: Int, end: Int) -> Double {
        guard end > start, start >= 0, end <= answerHistory.count else { return 0 }
        let slice = Array(answerHistory[start..<end])
        let correct = slice.filter { $0 }.count
        return Double(correct) / Double(slice.count) * 100
    }

    mutating func endGame() {
        isFinished = true
    }
}
