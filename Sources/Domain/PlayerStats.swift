import Foundation
import SwiftData

@Model
final class PlayerStats {
    var totalSolved: Int = 0
    var totalCorrect: Int = 0
    var bestStreak: Int = 0
    var dailyStreak: Int = 0
    var lastPlayedDate: Date?
    var bestScore: Int = 0
    var gamesPlayed: Int = 0
    var easyGamesPlayed: Int = 0
    var mediumGamesPlayed: Int = 0
    var hardGamesPlayed: Int = 0
    var dailyChallengeBestTime: Int = 0
    var lastDailyChallengeDate: Date?
    var totalXP: Int = 0
    var recentAccuracies: [Double] = []
    var addCount: Int = 0
    var subtractCount: Int = 0
    var multiplyCount: Int = 0
    var divideCount: Int = 0
    var totalTimePlayedSeconds: Int = 0
    var bestScoreEasy: Int = 0
    var bestScoreMedium: Int = 0
    var bestScoreHard: Int = 0
    var totalScoreEasy: Int = 0
    var totalScoreMedium: Int = 0
    var totalScoreHard: Int = 0
    var addTotal: Int = 0
    var subtractTotal: Int = 0
    var multiplyTotal: Int = 0
    var divideTotal: Int = 0
    var easyMasteryCount: Int = 0
    var mediumMasteryCount: Int = 0
    var hardMasteryCount: Int = 0
    var bestAccuracyEasy: Double = 0
    var bestAccuracyMedium: Double = 0
    var bestAccuracyHard: Double = 0
    var xpEasy: Int = 0
    var xpMedium: Int = 0
    var xpHard: Int = 0
    var longestSessionSeconds: Int = 0
    var bestDailyStreak: Int = 0
    var addGames: Int = 0
    var subtractGames: Int = 0
    var multiplyGames: Int = 0
    var divideGames: Int = 0
    var bestStreakEasy: Int = 0
    var bestStreakMedium: Int = 0
    var bestStreakHard: Int = 0
    var problemsSolvedEasy: Int = 0
    var problemsSolvedMedium: Int = 0
    var problemsSolvedHard: Int = 0

    init() {}

    var currentLevel: Int { LevelSystem.level(for: totalXP) }
    var levelName: String { LevelSystem.levelName(for: totalXP) }
    var levelProgress: Double { LevelSystem.progressToNextLevel(for: totalXP) }

    var favoriteOperation: (symbol: String, count: Int)? {
        let ops: [(String, Int)] = [("+", addCount), ("-", subtractCount), ("x", multiplyCount), ("/", divideCount)]
        guard let best = ops.max(by: { $0.1 < $1.1 }), best.1 > 0 else { return nil }
        return (best.0, best.1)
    }

    var weakestOperation: (symbol: String, count: Int)? {
        let ops: [(String, Int)] = [("+", addCount), ("-", subtractCount), ("x", multiplyCount), ("/", divideCount)]
        let totalOps = ops.reduce(0) { $0 + $1.1 }
        guard totalOps > 0 else { return nil }
        guard let worst = ops.min(by: { $0.1 < $1.1 }) else { return nil }
        return (worst.0, worst.1)
    }

    func bestScoreForDifficulty(_ difficulty: DifficultyLevel) -> Int {
        switch difficulty {
        case .easy: bestScoreEasy
        case .medium: bestScoreMedium
        case .hard: bestScoreHard
        }
    }

    func updateBestScore(_ score: Int, for difficulty: DifficultyLevel) {
        switch difficulty {
        case .easy: bestScoreEasy = max(bestScoreEasy, score)
        case .medium: bestScoreMedium = max(bestScoreMedium, score)
        case .hard: bestScoreHard = max(bestScoreHard, score)
        }
    }

    func averageScoreForDifficulty(_ difficulty: DifficultyLevel) -> Int {
        let games: Int
        let total: Int
        switch difficulty {
        case .easy: games = easyGamesPlayed; total = totalScoreEasy
        case .medium: games = mediumGamesPlayed; total = totalScoreMedium
        case .hard: games = hardGamesPlayed; total = totalScoreHard
        }
        guard games > 0 else { return 0 }
        return total / games
    }

    func recordScoreForDifficulty(_ score: Int, for difficulty: DifficultyLevel) {
        switch difficulty {
        case .easy: totalScoreEasy += score; easyGamesPlayed += 1
        case .medium: totalScoreMedium += score; mediumGamesPlayed += 1
        case .hard: totalScoreHard += score; hardGamesPlayed += 1
        }
    }

    func totalProblemsForOperation(_ operation: Operation) -> Int {
        switch operation {
        case .add: addTotal
        case .subtract: subtractTotal
        case .multiply: multiplyTotal
        case .divide: divideTotal
        }
    }

    func incrementTotalProblems(_ operation: Operation) {
        switch operation {
        case .add: addTotal += 1
        case .subtract: subtractTotal += 1
        case .multiply: multiplyTotal += 1
        case .divide: divideTotal += 1
        }
    }

    func masteryCountForDifficulty(_ difficulty: DifficultyLevel) -> Int {
        switch difficulty {
        case .easy: easyMasteryCount
        case .medium: mediumMasteryCount
        case .hard: hardMasteryCount
        }
    }

    func recordMasteryIfQualified(accuracy: Double, difficulty: DifficultyLevel) {
        guard accuracy >= 90 else { return }
        switch difficulty {
        case .easy: easyMasteryCount += 1
        case .medium: mediumMasteryCount += 1
        case .hard: hardMasteryCount += 1
        }
    }

    func bestAccuracyForDifficulty(_ difficulty: DifficultyLevel) -> Double {
        switch difficulty {
        case .easy: bestAccuracyEasy
        case .medium: bestAccuracyMedium
        case .hard: bestAccuracyHard
        }
    }

    func xpForDifficulty(_ difficulty: DifficultyLevel) -> Int {
        switch difficulty {
        case .easy: xpEasy
        case .medium: xpMedium
        case .hard: xpHard
        }
    }

    func gamesWithOperation(_ operation: Operation) -> Int {
        switch operation {
        case .add: addGames
        case .subtract: subtractGames
        case .multiply: multiplyGames
        case .divide: divideGames
        }
    }

}
