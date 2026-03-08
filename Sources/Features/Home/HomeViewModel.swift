import Foundation
import Observation
import SwiftData

@Observable
@MainActor
final class HomeViewModel {
    var selectedDifficulty: DifficultyLevel = .easy
    var selectedOperations: Set<Operation> = Set(Operation.allCases)
    var totalSolved: Int = 0
    var dailyStreak: Int = 0
    var bestScore: Int = 0
    var dailyChallengeCompleted: Bool = false
    var dailyChallengeBestTime: Int = 0
    var currentLevel: Int = 1
    var levelName: String = "Beginner"
    var levelProgress: Double = 0
    var totalXP: Int = 0
    var recommendedDifficulty: DifficultyLevel = .easy
    var weakestEloOperation: Operation? = nil
    var weakestEloRating: Double = 1000
    var weakestEloSkillLevel: String = ""
    var recentAccuracies: [Double] = []
    var nextAchievementName: String? = nil
    var nextAchievementProgress: Double = 0
    var totalTimePlayedSeconds: Int = 0
    var easyGames: Int = 0
    var mediumGames: Int = 0
    var hardGames: Int = 0

    enum AccuracyTrend { case improving, declining, stable }

    var accuracyTrend: AccuracyTrend {
        guard recentAccuracies.count >= 4 else { return .stable }
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

    private let statsService: StatsService

    init(statsService: StatsService) {
        self.statsService = statsService
        // Load saved operations
        if let saved = UserDefaults.standard.array(forKey: "selectedOperations") as? [String] {
            let ops = saved.compactMap { Operation(rawValue: $0) }
            if !ops.isEmpty {
                selectedOperations = Set(ops)
            }
        }
    }

    func selectAllOperations() {
        selectedOperations = Set(Operation.allCases)
        UserDefaults.standard.set(selectedOperations.map(\.rawValue), forKey: "selectedOperations")
    }

    func toggleOperation(_ op: Operation) {
        if selectedOperations.contains(op) && selectedOperations.count > 1 {
            selectedOperations.remove(op)
        } else {
            selectedOperations.insert(op)
        }
        UserDefaults.standard.set(selectedOperations.map(\.rawValue), forKey: "selectedOperations")
    }

    var dailyChallengeResetTime: String? {
        guard dailyChallengeCompleted else { return nil }
        let calendar = Calendar.current
        guard let tomorrow = calendar.date(byAdding: .day, value: 1, to: calendar.startOfDay(for: .now)) else { return nil }
        let remaining = Int(tomorrow.timeIntervalSinceNow)
        let hours = remaining / 3600
        let minutes = (remaining % 3600) / 60
        return "\(hours)h \(minutes)m"
    }

    var operationCountText: String {
        "\(selectedOperations.count) of \(Operation.allCases.count) operations"
    }

    func loadStats() {
        let stats = statsService.getOrCreateStats()
        totalSolved = stats.totalSolved
        dailyStreak = stats.dailyStreak
        bestScore = stats.bestScore
        dailyChallengeBestTime = stats.dailyChallengeBestTime
        currentLevel = stats.currentLevel
        levelName = stats.levelName
        levelProgress = stats.levelProgress
        totalXP = stats.totalXP

        totalTimePlayedSeconds = stats.totalTimePlayedSeconds
        easyGames = stats.easyGamesPlayed
        mediumGames = stats.mediumGamesPlayed
        hardGames = stats.hardGamesPlayed

        // Load weakest Elo operation
        if let weakest = stats.weakestEloOperation {
            weakestEloOperation = weakest
            weakestEloRating = stats.eloRating(for: weakest)
            weakestEloSkillLevel = EloSystem.skillLevel(forRating: weakestEloRating)
        } else {
            weakestEloOperation = nil
        }

        // Load recent accuracies for trend
        recentAccuracies = stats.recentAccuracies
        loadNextAchievement(from: stats)

        // Compute recommended difficulty
        if stats.accuracy >= 90 && stats.gamesPlayed >= 5 {
            if stats.hardGamesPlayed > 0 { recommendedDifficulty = .hard }
            else { recommendedDifficulty = .medium }
        } else if stats.accuracy >= 70 && stats.gamesPlayed >= 3 {
            recommendedDifficulty = .medium
        } else {
            recommendedDifficulty = .easy
        }

        let calendar = Calendar.current
        if let lastChallenge = stats.lastDailyChallengeDate {
            dailyChallengeCompleted = calendar.isDateInToday(lastChallenge)
        } else {
            dailyChallengeCompleted = false
        }
    }

    func loadNextAchievement(from stats: PlayerStats) {
        let locked = Achievement.all.filter { !$0.isUnlocked(stats: stats) }
        if let closest = locked.max(by: { $0.progressPercentage(stats: stats) < $1.progressPercentage(stats: stats) }) {
            nextAchievementName = closest.title
            nextAchievementProgress = Double(closest.progressPercentage(stats: stats)) / 100.0
        } else {
            nextAchievementName = nil
            nextAchievementProgress = 0
        }
    }
}
