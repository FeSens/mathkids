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
}
