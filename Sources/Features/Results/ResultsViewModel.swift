import Foundation
import Observation

@Observable
@MainActor
final class ResultsViewModel {
    let session: GameSession
    let previousBestScore: Int
    let isNewBestScore: Bool
    private(set) var animatedScore: Int = 0
    private(set) var newAchievements: [Achievement] = []
    let xpEarned: Int
    let previousLevel: Int
    let newLevel: Int
    var didLevelUp: Bool { newLevel > previousLevel }
    let problemHistory: [AnsweredProblem]

    init(session: GameSession, previousBestScore: Int, stats: PlayerStats? = nil, problemHistory: [AnsweredProblem] = []) {
        self.problemHistory = problemHistory
        self.session = session
        self.previousBestScore = previousBestScore
        self.isNewBestScore = session.score > previousBestScore

        // Calculate XP earned
        var totalXP = 0
        for i in 0..<session.totalCorrect {
            totalXP += LevelSystem.xpForCorrectAnswer(streak: min(i, 10))
        }
        self.xpEarned = totalXP

        if let stats {
            self.previousLevel = LevelSystem.level(for: stats.totalXP - totalXP)
            self.newLevel = stats.currentLevel
            newAchievements = Achievement.all.filter { $0.isUnlocked(stats: stats) }
            if newAchievements.count > 3 {
                newAchievements = Array(newAchievements.prefix(3))
            }
        } else {
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

    var operationBreakdown: [(operation: Operation, count: Int)] {
        var counts: [Operation: Int] = [:]
        for entry in problemHistory {
            counts[entry.problem.operation, default: 0] += 1
        }
        return counts.sorted { $0.key.rawValue < $1.key.rawValue }.map { ($0.key, $0.value) }
    }

    var recommendationText: String? {
        switch difficultyRecommendation {
        case .tryHarder:
            let next = session.difficulty == .easy ? "Medium" : "Hard"
            return "You're crushing it! Try \(next) mode"
        case .tryEasier:
            let prev = session.difficulty == .hard ? "Medium" : "Easy"
            return "Try \(prev) mode to build confidence"
        case .stayHere:
            return nil
        }
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
