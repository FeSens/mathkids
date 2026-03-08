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

    var sessionGrade: String {
        let badge = accuracyBadge
        if badge == "A+" { return "⭐ A+" }
        return badge
    }

    var questionsPerMinute: Int {
        guard totalTimePlayed > 0 else { return 0 }
        return totalAnswered * 60 / totalTimePlayed
    }

    var correctStreakEmoji: String {
        bestStreak >= 3 ? "🔥" : ""
    }

    var timeUsedPercentText: String {
        guard difficulty.timeLimitSeconds > 0 else { return "0%" }
        let pct = totalTimePlayed * 100 / difficulty.timeLimitSeconds
        return "\(pct)%"
    }

    var hasAnsweredAny: Bool {
        totalAnswered > 0
    }

    var remainingTimeDisplay: String {
        "\(timeRemaining)s left"
    }

    var isPerfectAccuracy: Bool {
        totalAnswered > 0 && totalCorrect == totalAnswered
    }

    var scoreEmoji: String {
        if score >= 100 { return "🏆" }
        if score >= 50 { return "⭐" }
        return "📝"
    }

    var bestStreakText: String {
        "Best: \(bestStreak)"
    }

    var totalPointsEarned: Int {
        score + totalBonusPoints
    }

    var progressBarValue: Double {
        guard difficulty.timeLimitSeconds > 0 else { return 0 }
        return Double(totalTimePlayed) / Double(difficulty.timeLimitSeconds)
    }

    var answerRateText: String {
        guard totalTimePlayed > 0 else { return "0/min" }
        let rate = totalAnswered * 60 / totalTimePlayed
        return "\(rate)/min"
    }

    var isStrugglingSession: Bool {
        totalAnswered > 0 && accuracy < 40
    }

    var correctPercentText: String {
        "\(Int(accuracy))%"
    }

    var isTimeCritical: Bool {
        timeRemaining > 0 && timeRemaining < 5
    }
}
