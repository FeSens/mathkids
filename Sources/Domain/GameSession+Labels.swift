import Foundation

extension GameSession {
    var correctStreakCount: String {
        "\(currentStreak)"
    }

    var isWarmingUp: Bool {
        totalAnswered > 0 && totalAnswered <= 3
    }

    var sessionStatusEmoji: String {
        if totalAnswered == 0 { return "🆕" }
        if accuracy >= 80 { return "🔥" }
        if accuracy >= 50 { return "👍" }
        return "💪"
    }

    var totalWrongDisplay: String {
        "\(totalAnswered - totalCorrect) wrong"
    }

    var pointsSummaryText: String {
        let base = score
        let bonus = totalBonusPoints
        let total = base + bonus
        if bonus > 0 {
            return "\(total) pts (\(base) base + \(bonus) bonus)"
        }
        return "\(total) pts"
    }

    var sessionAccuracyLabel: String {
        "Accuracy: \(Int(accuracy))%"
    }

    var difficultyStarsText: String {
        switch difficulty {
        case .easy: return "⭐"
        case .medium: return "⭐⭐"
        case .hard: return "⭐⭐⭐"
        }
    }

    var isOnFire: Bool {
        currentStreak >= 5 && accuracy >= 80
    }

    var gameProgressLabel: String {
        let estimated = difficulty.estimatedProblemsPerGame
        return "Q\(totalAnswered) of ~\(estimated)"
    }

    var timePressureLevel: String {
        let pct = difficulty.timeLimitSeconds > 0
            ? timeRemaining * 100 / difficulty.timeLimitSeconds
            : 100
        if pct > 50 { return "none" }
        if pct > 25 { return "low" }
        if pct > 10 { return "medium" }
        if pct > 5 { return "high" }
        return "critical"
    }
}
