import Foundation

extension GameSession {
    var scoreWithBonusText: String {
        "\(score) + \(totalBonusPoints) bonus"
    }

    var performanceSummary: String {
        "\(totalCorrect)/\(totalAnswered) correct | \(score) pts"
    }

    var difficultyBadge: String {
        "\(difficulty.emoji) \(difficulty.displayName)"
    }

    var streakBadge: String {
        currentStreak >= 3 ? "🔥" : ""
    }

    var timeProgressText: String {
        "\(totalTimePlayed)/\(difficulty.timeLimitSeconds)s"
    }

    var accuracyBadge: String {
        let acc = accuracy
        if acc >= 95 { return "A+" }
        if acc >= 90 { return "A" }
        if acc >= 80 { return "B" }
        if acc >= 70 { return "C" }
        if acc >= 60 { return "D" }
        return "F"
    }

    var isGoodPerformance: Bool {
        accuracy >= 70 && score >= 50
    }
}
