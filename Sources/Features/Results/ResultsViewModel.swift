import Foundation
import Observation

@Observable
@MainActor
final class ResultsViewModel {
    let session: GameSession
    let previousBestScore: Int
    let isNewBestScore: Bool
    let isNewPersonalBest: Bool
    private(set) var animatedScore: Int = 0
    private(set) var newAchievements: [Achievement] = []
    let xpEarned: Int
    let previousLevel: Int
    let newLevel: Int
    var didLevelUp: Bool { newLevel > previousLevel }
    let problemHistory: [AnsweredProblem]
    let playerAverageAccuracy: Double?

    init(session: GameSession, previousBestScore: Int, stats: PlayerStats? = nil, problemHistory: [AnsweredProblem] = [], previousBestForDifficulty: Int = 0, previouslyUnlockedIds: Set<String> = []) {
        self.problemHistory = problemHistory
        self.session = session
        self.previousBestScore = previousBestScore
        self.isNewBestScore = session.score > previousBestScore
        self.isNewPersonalBest = session.score > previousBestForDifficulty

        // Calculate XP earned
        var totalXP = 0
        for i in 0..<session.totalCorrect {
            totalXP += LevelSystem.xpForCorrectAnswer(streak: min(i, 10))
        }
        self.xpEarned = totalXP

        if let stats {
            self.playerAverageAccuracy = stats.totalSolved > 0 ? stats.accuracy : nil
            self.previousLevel = LevelSystem.level(for: stats.totalXP - totalXP)
            self.newLevel = stats.currentLevel

            // Only show NEWLY unlocked achievements (not previously unlocked)
            let currentlyUnlocked = Achievement.all.filter { $0.isUnlocked(stats: stats) }
            let newlyUnlocked = currentlyUnlocked.filter { !previouslyUnlockedIds.contains($0.id) }

            if !newlyUnlocked.isEmpty {
                newAchievements = Array(newlyUnlocked.prefix(3))
            } else {
                // If no new achievements, show closest to unlocking
                let closest = Achievement.all
                    .filter { !$0.isUnlocked(stats: stats) }
                    .sorted { $0.progressPercentage(stats: stats) > $1.progressPercentage(stats: stats) }
                    .prefix(1)
                newAchievements = Array(closest)
            }
        } else {
            self.playerAverageAccuracy = nil
            self.previousLevel = 1
            self.newLevel = 1
        }
    }

    var finalScore: Int { session.score }
    var accuracy: Double { session.accuracy }
    var totalAnswered: Int { session.totalAnswered }
    var totalCorrect: Int { session.totalCorrect }
    var bestStreak: Int { session.bestStreak }
    var difficulty: DifficultyLevel { session.difficulty }
    var hasNewAchievements: Bool { !newAchievements.isEmpty }
    var isPerfectScore: Bool { accuracy >= 100 }
    var isNewBestStreak: Bool { isNewBestScore }

    var basePoints: Int {
        session.totalCorrect * session.difficulty.pointsPerCorrect
    }

    var bonusPoints: Int {
        session.score - basePoints
    }

    var encouragementMessage: String {
        if accuracy >= 90 {
            return ["You're a math superstar!", "Incredible performance!", "Math genius level!"].randomElement()!
        } else if accuracy >= 70 {
            return ["Great work, keep it up!", "You're getting stronger!", "Almost perfect!"].randomElement()!
        } else if accuracy >= 50 {
            return ["Good effort!", "Practice makes perfect!", "You're improving!"].randomElement()!
        } else {
            return ["Don't give up!", "Every try makes you better!", "You'll get there!"].randomElement()!
        }
    }

    var funFact: String {
        let timePlayed = session.difficulty.timeLimitSeconds - session.timeRemaining
        if session.totalAnswered > 0 && timePlayed > 0 {
            let avgTime = Double(timePlayed) / Double(session.totalAnswered)
            let perMinute = session.totalAnswered > 0 ? Double(session.totalAnswered) / (Double(timePlayed) / 60.0) : 0
            if avgTime < 3.0 {
                return "Lightning fast! \(String(format: "%.1f", avgTime))s per problem"
            } else if perMinute >= 10 {
                return "Speed machine! \(Int(perMinute)) problems per minute"
            } else {
                return "You solved \(session.totalAnswered) problems in \(timePlayed)s"
            }
        }
        return "Keep practicing to unlock fun stats!"
    }

    var fastestAnswerTime: String? = nil

    var totalTimePlayed: String {
        let time = session.totalTimePlayed
        guard time > 0 else { return "0s" }
        return "\(time)s"
    }

    var problemsPerMinuteText: String {
        let ppm = session.problemsPerMinute
        guard ppm > 0 else { return "N/A" }
        return String(format: "%.1f", ppm)
    }

    var averageTimePerProblem: String {
        let timePlayed = session.totalTimePlayed
        guard session.totalAnswered > 0, timePlayed > 0 else { return "N/A" }
        let avg = Double(timePlayed) / Double(session.totalAnswered)
        return String(format: "%.1fs", avg)
    }

    var shareText: String {
        let stars = String(repeating: "⭐", count: starCount)
        return "MathKids \(stars)\nDifficulty: \(session.difficulty.displayName)\nScore: \(finalScore) | Accuracy: \(Int(accuracy))% | Streak: \(bestStreak)\nI solved \(totalAnswered) problems!"
    }

    var starCount: Int {
        if accuracy >= 90 { return 5 }
        if accuracy >= 80 { return 4 }
        if accuracy >= 70 { return 3 }
        if accuracy >= 50 { return 2 }
        return 1
    }

    var scoreImprovement: Int {
        session.score - previousBestScore
    }

    var performanceEmoji: String {
        if isPerfectScore { return "🏆" }
        if accuracy >= 90 { return "🌟" }
        if accuracy >= 70 { return "😊" }
        if accuracy >= 50 { return "💪" }
        return "🌱"
    }

    enum Medal {
        case gold, silver, bronze, none
    }

    var medalType: Medal {
        if accuracy >= 90 { return .gold }
        if accuracy >= 70 { return .silver }
        if accuracy >= 50 { return .bronze }
        return .none
    }

    enum DifficultyRecommendation {
        case tryHarder
        case tryEasier
        case stayHere
    }

    var difficultyRecommendation: DifficultyRecommendation {
        if accuracy >= 90 && session.difficulty != .hard {
            return .tryHarder
        }
        if accuracy < 50 && session.difficulty != .easy {
            return .tryEasier
        }
        return .stayHere
    }

    var xpProgressFraction: Double {
        let totalXP: Int
        if let _ = previousBestScore as Int? {
            // Use newLevel to calculate approximate XP
            totalXP = xpEarned
        } else {
            totalXP = xpEarned
        }
        let currentLevel = LevelSystem.level(for: totalXP)
        guard currentLevel < LevelSystem.thresholds.count else { return 1.0 }
        let currentThreshold = LevelSystem.thresholds[currentLevel - 1]
        let nextThreshold = LevelSystem.thresholds[currentLevel]
        let range = nextThreshold - currentThreshold
        guard range > 0 else { return 1.0 }
        return Double(totalXP - currentThreshold) / Double(range)
    }

    var xpProgressLabel: String {
        let currentLevel = LevelSystem.level(for: xpEarned)
        guard currentLevel < LevelSystem.thresholds.count else { return "MAX" }
        let nextThreshold = LevelSystem.thresholds[currentLevel]
        return "\(xpEarned)/\(nextThreshold) XP"
    }

    var operationAccuracy: [Operation: Double] {
        var correct: [Operation: Int] = [:]
        var total: [Operation: Int] = [:]
        for entry in problemHistory {
            total[entry.problem.operation, default: 0] += 1
            if entry.isCorrect { correct[entry.problem.operation, default: 0] += 1 }
        }
        var result: [Operation: Double] = [:]
        for (op, t) in total {
            result[op] = Double(correct[op] ?? 0) / Double(t) * 100
        }
        return result
    }

    /// Per-operation accuracy breakdown (only operations with attempts)
    var operationAccuracyBreakdown: [Operation: Double] {
        var correct: [Operation: Int] = [:]
        var total: [Operation: Int] = [:]
        for entry in problemHistory {
            total[entry.problem.operation, default: 0] += 1
            if entry.isCorrect { correct[entry.problem.operation, default: 0] += 1 }
        }
        var result: [Operation: Double] = [:]
        for (op, t) in total {
            result[op] = Double(correct[op] ?? 0) / Double(t) * 100
        }
        return result
    }

    /// The operation with worst accuracy this game, nil if all 100%
    var weakestOperationThisGame: Operation? {
        let breakdown = operationAccuracyBreakdown
        guard !breakdown.isEmpty else { return nil }
        // If all are 100%, no recommendation needed
        guard breakdown.values.contains(where: { $0 < 100 }) else { return nil }
        return breakdown.min(by: { $0.value < $1.value })?.key
    }

    /// Practice recommendation text based on weakest operation
    var practiceRecommendationText: String? {
        guard let weakest = weakestOperationThisGame else { return nil }
        let accuracy = operationAccuracyBreakdown[weakest] ?? 0
        return "Practice \(weakest.rawValue) (\(Int(accuracy))% accuracy)"
    }

    /// Average response time per operation from problem history
    var averageTimePerOperation: [Operation: Double] {
        var totals: [Operation: Double] = [:]
        var counts: [Operation: Int] = [:]
        for entry in problemHistory {
            if let time = entry.timeTaken {
                totals[entry.problem.operation, default: 0] += time
                counts[entry.problem.operation, default: 0] += 1
            }
        }
        var result: [Operation: Double] = [:]
        for (op, total) in totals {
            if let count = counts[op], count > 0 {
                result[op] = total / Double(count)
            }
        }
        return result
    }

    /// The operation with the slowest average response time this game
    var slowestOperationThisGame: Operation? {
        let times = averageTimePerOperation
        guard !times.isEmpty else { return nil }
        return times.max(by: { $0.value < $1.value })?.key
    }

    /// Accuracy difference vs player's historical average (positive = above average)
    var accuracyVsAverage: Double {
        guard let avg = playerAverageAccuracy, avg > 0 else { return 0 }
        return accuracy - avg
    }

    /// Elo rating deltas from this game's problem history
    var eloDeltas: [Operation: Double] {
        guard !problemHistory.isEmpty else { return [:] }
        let initialRatings: [Operation: Double] = [
            .add: 1000, .subtract: 1000, .multiply: 1000, .divide: 1000
        ]
        return EloSystem.computeDeltas(from: problemHistory, initialRatings: initialRatings)
    }

    var operationBreakdown: [(operation: Operation, count: Int)] {
        var counts: [Operation: Int] = [:]
        for entry in problemHistory {
            counts[entry.problem.operation, default: 0] += 1
        }
        return counts.sorted { $0.key.rawValue < $1.key.rawValue }.map { ($0.key, $0.value) }
    }

    var xpEarnedText: String {
        let xp = session.totalCorrect * LevelSystem.baseXPPerAnswer
        return "+\(xp) XP"
    }

    func animateScore() {
        let target = session.score
        guard target > 0 else {
            animatedScore = 0
            return
        }

        let steps = min(target, 30)
        let increment = max(target / steps, 1)
        var current = 0

        Task {
            for _ in 0..<steps {
                try? await Task.sleep(for: .milliseconds(30))
                current = min(current + increment, target)
                animatedScore = current
            }
            animatedScore = target
        }
    }
}
