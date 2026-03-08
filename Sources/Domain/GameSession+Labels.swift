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

    var scorePercentOfMax: Int {
        let maxScore = difficulty.maxPossibleScore
        guard maxScore > 0 else { return 0 }
        return score * 100 / maxScore
    }

    var hasReachedHalfTime: Bool {
        totalTimePlayed > difficulty.timeLimitSeconds / 2
    }

    var efficiencyRating: String {
        guard totalAnswered > 0 else { return "poor" }
        let acc = accuracy
        let speed = totalTimePlayed > 0 ? totalAnswered * 60 / totalTimePlayed : 0
        if acc >= 80 && speed >= 10 { return "excellent" }
        if acc >= 60 && speed >= 5 { return "good" }
        if acc >= 40 { return "average" }
        return "poor"
    }

    var currentMomentumText: String {
        if currentStreak >= 5 { return "On fire!" }
        if currentStreak >= 3 { return "Great momentum" }
        if currentStreak >= 1 { return "Good start" }
        return "Building momentum"
    }

    var sessionCompletionEstimate: Int {
        guard totalAnswered > 0, totalTimePlayed > 0 else { return 0 }
        return totalAnswered * timeRemaining / totalTimePlayed
    }
}
