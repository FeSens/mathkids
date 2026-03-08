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

    var correctCountPerOperation: [Operation: Int] {
        [.add: addCount, .subtract: subtractCount, .multiply: multiplyCount, .divide: divideCount]
    }

    func winRateForDifficulty(_ difficulty: DifficultyLevel) -> Int {
        let games: Int
        let wins: Int
        switch difficulty {
        case .easy: games = easyGamesPlayed; wins = easyMasteryCount
        case .medium: games = mediumGamesPlayed; wins = mediumMasteryCount
        case .hard: games = hardGamesPlayed; wins = hardMasteryCount
        }
        guard games > 0 else { return 0 }
        return wins * 100 / games
    }

    var averageXPPerSession: Int {
        guard gamesPlayed > 0 else { return 0 }
        return totalXP / gamesPlayed
    }

    var averageSessionSeconds: Int {
        guard gamesPlayed > 0 else { return 0 }
        return totalTimePlayedSeconds / gamesPlayed
    }

    func recordPerfectGameIfQualified(accuracy: Double) {
        guard accuracy >= 100 else { return }
        perfectGameCount += 1
    }

    var favoriteDifficulty: DifficultyLevel? {
        let games = [(DifficultyLevel.easy, easyGamesPlayed), (.medium, mediumGamesPlayed), (.hard, hardGamesPlayed)]
        guard let best = games.max(by: { $0.1 < $1.1 }), best.1 > 0 else { return nil }
        return best.0
    }

    func bestStreakForOperation(_ operation: Operation) -> Int {
        switch operation {
        case .add: bestStreakAdd
        case .subtract: bestStreakSubtract
        case .multiply: bestStreakMultiply
        case .divide: bestStreakDivide
        }
    }

    var xpPercentageByDifficulty: (easy: Int, medium: Int, hard: Int) {
        guard totalXP > 0 else { return (0, 0, 0) }
        return (
            xpEasy * 100 / totalXP,
            xpMedium * 100 / totalXP,
            xpHard * 100 / totalXP
        )
    }

    var improvementStreak: Int {
        guard recentAccuracies.count >= 2 else { return 0 }
        var streak = 0
        for i in stride(from: recentAccuracies.count - 1, through: 1, by: -1) {
            if recentAccuracies[i] > recentAccuracies[i - 1] {
                streak += 1
            } else {
                break
            }
        }
        return streak
    }

    func updateBestStreakForOperation(_ streak: Int, for operation: Operation) {
        switch operation {
        case .add: bestStreakAdd = max(bestStreakAdd, streak)
        case .subtract: bestStreakSubtract = max(bestStreakSubtract, streak)
        case .multiply: bestStreakMultiply = max(bestStreakMultiply, streak)
        case .divide: bestStreakDivide = max(bestStreakDivide, streak)
        }
    }

    var difficultyPercentages: (easy: Int, medium: Int, hard: Int) {
        let total = easyGamesPlayed + mediumGamesPlayed + hardGamesPlayed
        guard total > 0 else { return (0, 0, 0) }
        return (
            easyGamesPlayed * 100 / total,
            mediumGamesPlayed * 100 / total,
            hardGamesPlayed * 100 / total
        )
    }

    var consistencyScore: Double {
        guard recentAccuracies.count >= 2 else { return 0 }
        let mean = recentAccuracies.reduce(0, +) / Double(recentAccuracies.count)
        let variance = recentAccuracies.reduce(0) { $0 + ($1 - mean) * ($1 - mean) } / Double(recentAccuracies.count)
        let stdDev = variance.squareRoot()
        return max(0, 100 - stdDev * 2)
    }
}
