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

    /// Elo trend for a given operation
    enum EloTrend { case improving, declining, stable }

    func eloTrend(for operation: Operation) -> EloTrend {
        let history: [Double]
        switch operation {
        case .add: history = eloHistoryAdd
        case .subtract: history = eloHistorySubtract
        case .multiply: history = eloHistoryMultiply
        case .divide: history = eloHistoryDivide
        }
        guard history.count >= 3 else { return .stable }
        let recent = Array(history.suffix(3))
        let older = Array(history.dropLast(3).suffix(3))
        guard !older.isEmpty else { return .stable }
        let recentAvg = recent.reduce(0, +) / Double(recent.count)
        let olderAvg = older.reduce(0, +) / Double(older.count)
        let diff = recentAvg - olderAvg
        if diff > 30 { return .improving }
        if diff < -30 { return .declining }
        return .stable
    }

    /// Total problems by operation text
    var totalProblemsByOperationText: String {
        guard !operationAccuracies.isEmpty else { return "No operations tracked yet" }
        return operationAccuracies.keys.sorted().map { "\($0)" }.joined(separator: ", ")
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
