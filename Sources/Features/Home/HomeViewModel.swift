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

    var hasPlayedBefore: Bool {
        totalSolved > 0
    }

    var levelProgressDescription: String {
        if LevelSystem.isMaxLevel(for: totalXP) {
            return "Max level reached!"
        }
        let pct = LevelSystem.xpPercentageText(for: totalXP)
        return "\(pct) to Level \(currentLevel + 1)"
    }

    var streakStatusText: String {
        if dailyStreak > 0 {
            return "\(dailyStreak) day streak"
        }
        return "No streak"
    }

    var difficultyDescription: String {
        "\(selectedDifficulty.displayName) - \(selectedDifficulty.operationCount) operations"
    }

    var dailyChallengeButtonText: String {
        dailyChallengeCompleted ? "Completed" : "Play Daily Challenge"
    }

    var isBeginner: Bool {
        totalSolved == 0
    }

    var levelNameText: String {
        levelName
    }

    var recommendedDifficultyText: String {
        "\(recommendedDifficulty.emoji) \(recommendedDifficulty.displayName)"
    }

    var totalSolvedText: String {
        "\(totalSolved) problems solved"
    }

    var bestScoreText: String {
        "\(bestScore) pts"
    }

    var xpSummaryText: String {
        "Level \(currentLevel) | \(totalXP) XP"
    }

    var isAllOperationsSelected: Bool {
        selectedOperations.count == Operation.allCases.count
    }

    var selectedOperationNames: String {
        selectedOperations.map(\.displayName).sorted().joined(separator: ", ")
    }

    var nextMilestoneText: String {
        let xpNeeded = LevelSystem.xpNeededForNextLevel(currentXP: totalXP)
        if totalSolved == 0 {
            return "Solve your first problem!"
        }
        if xpNeeded > 0 && xpNeeded <= 50 {
            return "\(xpNeeded) XP to level \(currentLevel + 1)!"
        }
        return "\(xpNeeded) XP to next level"
    }

    var dailyChallengeStatusText: String {
        dailyChallengeCompleted ? "Completed for today!" : "Ready to play!"
    }

    var selectedDifficultyEmoji: String {
        selectedDifficulty.emoji
    }

    var quickStatsSummary: String {
        guard totalSolved > 0 else {
            return "Ready to start your math journey!"
        }
        return "Level \(currentLevel) | \(totalSolved) solved"
    }

    var greetingMessage: String {
        let hour = Calendar.current.component(.hour, from: .now)
        if hour < 12 {
            return "Rise and shine! Ready for some math?"
        } else if hour < 17 {
            return "Great afternoon for math practice!"
        } else {
            return "Wind down with some math fun!"
        }
    }

    var greeting: String {
        let hour = Calendar.current.component(.hour, from: .now)
        if hour < 12 { return "Good Morning!" }
        if hour < 17 { return "Good Afternoon!" }
        return "Good Evening!"
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
}
