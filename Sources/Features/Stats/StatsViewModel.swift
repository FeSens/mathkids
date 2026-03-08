import Foundation
import Observation

@Observable
@MainActor
final class StatsViewModel {
    var totalSolved: Int = 0
    var totalCorrect: Int = 0
    var accuracy: Double = 0
    var bestStreak: Int = 0
    var dailyStreak: Int = 0
    var bestScore: Int = 0
    var gamesPlayed: Int = 0
    var easyGames: Int = 0
    var mediumGames: Int = 0
    var hardGames: Int = 0
    var playerStats: PlayerStats?
    var recentAccuracies: [Double] = []

    var favoriteOperation: String?
    var favoriteOperationCount: Int = 0
    var weakestOperationSymbol: String?
    var averageProblemsPerMinute: Double = 0
    var operationAccuracies: [String: Double] = [:]
    var totalTimePlayedMinutes: Int = 0
    var totalXP: Int = 0

    var formattedTimePlayed: String {
        if totalTimePlayedMinutes >= 60 {
            let hours = totalTimePlayedMinutes / 60
            let mins = totalTimePlayedMinutes % 60
            return "\(hours)h \(mins)m"
        }
        return "\(totalTimePlayedMinutes)m"
    }

    enum AccuracyTrend { case improving, declining, stable }

    var accuracyTrend: AccuracyTrend {
        guard recentAccuracies.count >= 3 else { return .stable }
        let recent = Array(recentAccuracies.suffix(3))
        let older = Array(recentAccuracies.prefix(recentAccuracies.count - 3).suffix(3))
        guard !older.isEmpty else { return .stable }
        let recentAvg = recent.reduce(0, +) / Double(recent.count)
        let olderAvg = older.reduce(0, +) / Double(older.count)
        let diff = recentAvg - olderAvg
        if diff > 5 { return .improving }
        if diff < -5 { return .declining }
        return .stable
    }

    var gamesMilestone: String? {
        switch gamesPlayed {
        case 100...: "Century Gamer"
        case 50..<100: "Dedicated Player"
        case 25..<50: "Rising Star"
        case 10..<25: "Getting Started"
        default: nil
        }
    }

    var levelDisplayText: String {
        "Level \(LevelSystem.level(for: totalXP))"
    }

    var xpProgressText: String {
        let currentLevel = LevelSystem.level(for: totalXP)
        guard currentLevel < LevelSystem.thresholds.count else { return "MAX" }
        let nextThreshold = LevelSystem.thresholds[currentLevel]
        return "\(totalXP)/\(nextThreshold) XP"
    }

    var sessionCountText: String {
        gamesPlayed == 1 ? "1 game" : "\(gamesPlayed) games"
    }

    var bestStreakText: String {
        "Best streak: \(bestStreak)"
    }

    var totalProblemsSolvedText: String {
        "\(totalSolved) problems solved"
    }

    var averageScoreText: String {
        guard gamesPlayed > 0 else { return "0 pts" }
        let avg = bestScore / gamesPlayed
        return "\(avg) pts"
    }

    var accuracyDescription: String {
        "\(Int(accuracy))% (\(accuracyGrade))"
    }

    var xpToNextLevelText: String {
        let needed = LevelSystem.xpNeededForNextLevel(currentXP: totalXP)
        if needed <= 0 { return "Max level!" }
        return "\(needed) XP to next level"
    }

    var favoriteOperationDescription: String {
        guard let op = favoriteOperation else { return "No favorite yet" }
        return "Favorite: \(op)"
    }

    var weakestOperationDescription: String {
        guard let symbol = weakestOperationSymbol else { return "No weak spots yet" }
        return "Weakest: \(symbol)"
    }

    var operationCountText: String {
        let count = operationAccuracies.count
        return "\(count) operation\(count == 1 ? "" : "s") tracked"
    }

    var bestScoreDescription: String {
        "Best: \(bestScore) pts"
    }

    var hasSignificantData: Bool {
        gamesPlayed >= 3
    }

    var improvementTrend: String {
        switch accuracyTrend {
        case .improving: "Getting better!"
        case .declining: "Needs practice"
        case .stable: "Steady performance"
        }
    }

    var dailyStreakText: String {
        dailyStreak == 1 ? "1 day streak" : "\(dailyStreak) day streak"
    }

    var totalCorrectText: String {
        "\(totalCorrect) correct answers"
    }

    var gamesPerDifficultyText: String {
        "Easy: \(easyGames) | Medium: \(mediumGames) | Hard: \(hardGames)"
    }

    var strongestOperation: String? {
        guard !operationAccuracies.isEmpty else { return nil }
        return operationAccuracies.max(by: { $0.value < $1.value })?.key
    }

    var gamesPlayedLabel: String {
        gamesPlayed == 1 ? "1 game" : "\(gamesPlayed) games"
    }

    var averageAccuracyText: String {
        "\(Int(accuracy))%"
    }

    var correctPercentageText: String {
        "\(Int(accuracy))% correct"
    }

    var totalWrongCount: Int {
        totalSolved - totalCorrect
    }

    var averageAccuracyRounded: Int {
        Int(accuracy.rounded())
    }

    var xpPercentText: String {
        let pct = LevelSystem.progressToNextLevel(for: totalXP)
        return "\(Int(pct * 100))%"
    }

    var accuracyTrendEmoji: String {
        switch accuracyTrend {
        case .improving: "⬆️"
        case .declining: "⬇️"
        case .stable: "➡️"
        }
    }

    var hardGamesText: String {
        "\(hardGames) hard games"
    }

    var mediumGamesText: String {
        "\(mediumGames) medium games"
    }

    var easyGamesText: String {
        "\(easyGames) easy games"
    }

    var totalWrongText: String {
        "\(totalSolved - totalCorrect) wrong"
    }

    var problemsPerGameText: String {
        guard gamesPlayed > 0 else { return "0 per game" }
        return "\(totalSolved / gamesPlayed) per game"
    }

    var accuracyGrade: String {
        if accuracy >= 95 { return "A+" }
        if accuracy >= 90 { return "A" }
        if accuracy >= 80 { return "B" }
        if accuracy >= 70 { return "C" }
        if accuracy >= 60 { return "D" }
        return "F"
    }

    private let statsService: StatsService

    init(statsService: StatsService) {
        self.statsService = statsService
    }

    func loadStats() {
        let stats = statsService.getOrCreateStats()
        playerStats = stats
        totalSolved = stats.totalSolved
        totalCorrect = stats.totalCorrect
        accuracy = stats.accuracy
        bestStreak = stats.bestStreak
        dailyStreak = stats.dailyStreak
        bestScore = stats.bestScore
        gamesPlayed = stats.gamesPlayed
        easyGames = stats.easyGamesPlayed
        mediumGames = stats.mediumGamesPlayed
        hardGames = stats.hardGamesPlayed
        recentAccuracies = stats.recentAccuracies
        totalTimePlayedMinutes = stats.totalTimePlayedSeconds / 60
        totalXP = stats.totalXP
        if let fav = stats.favoriteOperation {
            favoriteOperation = fav.symbol
            favoriteOperationCount = fav.count
        }
        if let weak = stats.weakestOperation {
            weakestOperationSymbol = weak.symbol
        }
        if totalTimePlayedMinutes > 0 {
            averageProblemsPerMinute = Double(totalSolved) / Double(totalTimePlayedMinutes)
        }
        for op in Operation.allCases {
            let acc = stats.accuracyForOperation(op)
            if acc > 0 { operationAccuracies[op.rawValue] = acc }
        }
    }
}
