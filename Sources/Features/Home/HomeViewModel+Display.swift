import Foundation

extension HomeViewModel {

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

    var difficultyBadge: String {
        "\(selectedDifficulty.emoji) \(selectedDifficulty.displayName)"
    }

    var hasDailyStreak: Bool {
        dailyStreak > 0
    }

    var maxOperandText: String {
        "Up to \(selectedDifficulty.maxOperand)"
    }

    var difficultyStarRating: String {
        selectedDifficulty.starRating
    }

    var selectedOperationCount: Int {
        selectedOperations.count
    }

    var canPlayDailyChallenge: Bool {
        !dailyChallengeCompleted
    }

    var selectedDifficultyDescription: String {
        selectedDifficulty.challengeDescription
    }

    var dailyChallengeBestTimeText: String {
        "\(dailyChallengeBestTime)s"
    }

    var levelProgressPercent: Int {
        Int(levelProgress * 100)
    }

    var showDailyChallengeReset: Bool {
        dailyChallengeCompleted
    }

    var hasCompletedDailyChallenge: Bool {
        dailyChallengeCompleted
    }

    var difficultyPointsText: String {
        "\(selectedDifficulty.pointsPerCorrect) pts"
    }

    var selectedDifficultyColor: String {
        selectedDifficulty.color
    }

    var operationCountLabel: String {
        "\(selectedOperations.count) operations selected"
    }

    var difficultyTimeLimitText: String {
        "\(selectedDifficulty.timeLimitSeconds)s"
    }

    var totalXPText: String {
        "\(totalXP) XP"
    }

    var currentLevelText: String {
        "Level \(currentLevel)"
    }

    var dailyStreakEmoji: String {
        dailyStreak > 0 ? "🔥" : "❄️"
    }

    var selectedOperationsEmojis: String {
        selectedOperations.sorted(by: { $0.rawValue < $1.rawValue }).map(\.emoji).joined()
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

    var formattedTimePlayed: String {
        if totalTimePlayedSeconds >= 3600 {
            let hours = totalTimePlayedSeconds / 3600
            let mins = (totalTimePlayedSeconds % 3600) / 60
            return "\(hours)h \(mins)m"
        }
        return "\(totalTimePlayedSeconds / 60)m"
    }

    var difficultyBreakdownText: String {
        "Easy: \(easyGames) | Medium: \(mediumGames) | Hard: \(hardGames)"
    }
}
