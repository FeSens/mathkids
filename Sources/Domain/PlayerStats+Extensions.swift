import Foundation
import SwiftData

extension PlayerStats {

    func bestStreakForDifficulty(_ difficulty: DifficultyLevel) -> Int {
        switch difficulty {
        case .easy: bestStreakEasy
        case .medium: bestStreakMedium
        case .hard: bestStreakHard
        }
    }

    func totalProblemsForDifficulty(_ difficulty: DifficultyLevel) -> Int {
        switch difficulty {
        case .easy: problemsSolvedEasy
        case .medium: problemsSolvedMedium
        case .hard: problemsSolvedHard
        }
    }

    func addProblemsForDifficulty(_ count: Int, for difficulty: DifficultyLevel) {
        switch difficulty {
        case .easy: problemsSolvedEasy += count
        case .medium: problemsSolvedMedium += count
        case .hard: problemsSolvedHard += count
        }
    }

    func updateBestStreak(_ streak: Int, for difficulty: DifficultyLevel) {
        switch difficulty {
        case .easy: bestStreakEasy = max(bestStreakEasy, streak)
        case .medium: bestStreakMedium = max(bestStreakMedium, streak)
        case .hard: bestStreakHard = max(bestStreakHard, streak)
        }
    }

    func incrementGamesWithOperation(_ operation: Operation) {
        switch operation {
        case .add: addGames += 1
        case .subtract: subtractGames += 1
        case .multiply: multiplyGames += 1
        case .divide: divideGames += 1
        }
    }

    func updateLongestSession(_ seconds: Int) {
        longestSessionSeconds = max(longestSessionSeconds, seconds)
    }

    func addXPForDifficulty(_ xp: Int, for difficulty: DifficultyLevel) {
        switch difficulty {
        case .easy: xpEasy += xp
        case .medium: xpMedium += xp
        case .hard: xpHard += xp
        }
    }

    func updateBestAccuracy(_ accuracy: Double, for difficulty: DifficultyLevel) {
        switch difficulty {
        case .easy: bestAccuracyEasy = max(bestAccuracyEasy, accuracy)
        case .medium: bestAccuracyMedium = max(bestAccuracyMedium, accuracy)
        case .hard: bestAccuracyHard = max(bestAccuracyHard, accuracy)
        }
    }

    func accuracyForOperation(_ operation: Operation) -> Double {
        let correct: Int
        let total: Int
        switch operation {
        case .add: correct = addCount; total = addTotal
        case .subtract: correct = subtractCount; total = subtractTotal
        case .multiply: correct = multiplyCount; total = multiplyTotal
        case .divide: correct = divideCount; total = divideTotal
        }
        guard total > 0 else { return 0 }
        return Double(correct) / Double(total) * 100
    }

    func incrementOperationCount(_ operation: Operation) {
        switch operation {
        case .add: addCount += 1
        case .subtract: subtractCount += 1
        case .multiply: multiplyCount += 1
        case .divide: divideCount += 1
        }
    }

    enum AccuracyTrend: Sendable {
        case improving, declining, stable
    }

    var accuracyTrend: AccuracyTrend {
        guard recentAccuracies.count >= 3 else { return .stable }
        let half = recentAccuracies.count / 2
        let firstHalf = Array(recentAccuracies.prefix(half))
        let secondHalf = Array(recentAccuracies.suffix(half))
        let firstAvg = firstHalf.reduce(0, +) / Double(firstHalf.count)
        let secondAvg = secondHalf.reduce(0, +) / Double(secondHalf.count)
        let diff = secondAvg - firstAvg
        if diff > 5 { return .improving }
        if diff < -5 { return .declining }
        return .stable
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
        if dailyStreak > bestDailyStreak {
            bestDailyStreak = dailyStreak
        }
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
        updateBestScore(session.score, for: session.difficulty)

        switch session.difficulty {
        case .easy: easyGamesPlayed += 1
        case .medium: mediumGamesPlayed += 1
        case .hard: hardGamesPlayed += 1
        }

        let timePlayed = session.difficulty.timeLimitSeconds - session.timeRemaining
        totalTimePlayedSeconds += max(timePlayed, 0)

        recentAccuracies.append(session.accuracy)
        if recentAccuracies.count > 10 {
            recentAccuracies.removeFirst()
        }
    }
}
