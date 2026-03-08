import Foundation

extension StatsViewModel {

    /// Average problems solved per game
    var averageProblemsPerGame: Double {
        guard gamesPlayed > 0 else { return 0 }
        return Double(totalSolved) / Double(gamesPlayed)
    }

    /// Formatted average problems per game text
    var averageProblemsPerGameText: String {
        String(format: "%.1f per game", averageProblemsPerGame)
    }

    /// Correct/total ratio text (e.g., "45/50 correct")
    var correctRatioText: String {
        "\(totalCorrect)/\(totalSolved) correct"
    }

    /// Gap between highest and lowest Elo ratings
    var eloGap: Int {
        let ratings = [eloAdd, eloSubtract, eloMultiply, eloDivide]
        guard let max = ratings.max(), let min = ratings.min() else { return 0 }
        return Int(max - min)
    }

    /// Formatted Elo gap text
    var eloGapText: String {
        "\(eloGap) point gap"
    }

    /// Skill balance based on Elo gap
    enum SkillBalance { case balanced, unbalanced }

    var skillBalance: SkillBalance {
        eloGap >= 200 ? .unbalanced : .balanced
    }

    /// Difficulty accuracy summary text
    var difficultyAccuracySummary: String {
        let parts: [String] = [
            "Easy: \(bestAccuracyEasy > 0 ? "\(Int(bestAccuracyEasy))%" : "N/A")",
            "Medium: \(bestAccuracyMedium > 0 ? "\(Int(bestAccuracyMedium))%" : "N/A")",
            "Hard: \(bestAccuracyHard > 0 ? "\(Int(bestAccuracyHard))%" : "N/A")",
        ]
        return parts.joined(separator: " | ")
    }
}
