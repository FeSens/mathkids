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

    init() {}

    var currentLevel: Int { LevelSystem.level(for: totalXP) }
    var levelName: String { LevelSystem.levelName(for: totalXP) }
    var levelProgress: Double { LevelSystem.progressToNextLevel(for: totalXP) }

    var favoriteOperation: (symbol: String, count: Int)? {
        let ops: [(String, Int)] = [("+", addCount), ("-", subtractCount), ("x", multiplyCount), ("/", divideCount)]
        guard let best = ops.max(by: { $0.1 < $1.1 }), best.1 > 0 else { return nil }
        return (best.0, best.1)
    }

    func incrementOperationCount(_ operation: Operation) {
        switch operation {
        case .add: addCount += 1
        case .subtract: subtractCount += 1
        case .multiply: multiplyCount += 1
        case .divide: divideCount += 1
        }
    }

    var accuracy: Double {
        guard totalSolved > 0 else { return 0 }
        return Double(totalCorrect) / Double(totalSolved) * 100
    }

    func updateStreak(on date: Date = .now) {
        let calendar = Calendar.current

        if let lastPlayed = lastPlayedDate {
            let lastDay = calendar.startOfDay(for: lastPlayed)
            let today = calendar.startOfDay(for: date)

            if lastDay == today {
                return
            }

            let daysBetween = calendar.dateComponents([.day], from: lastDay, to: today).day ?? 0
            if daysBetween == 1 {
                dailyStreak += 1
            } else {
                dailyStreak = 1
            }
        } else {
            dailyStreak = 1
        }

        lastPlayedDate = date
    }

    func recordGame(session: GameSession) {
        totalSolved += session.totalAnswered
        totalCorrect += session.totalCorrect
        gamesPlayed += 1

        if session.bestStreak > bestStreak {
            bestStreak = session.bestStreak
        }

        if session.score > bestScore {
            bestScore = session.score
        }

        switch session.difficulty {
        case .easy: easyGamesPlayed += 1
        case .medium: mediumGamesPlayed += 1
        case .hard: hardGamesPlayed += 1
        }

        recentAccuracies.append(session.accuracy)
        if recentAccuracies.count > 10 {
            recentAccuracies.removeFirst()
        }
    }
}
