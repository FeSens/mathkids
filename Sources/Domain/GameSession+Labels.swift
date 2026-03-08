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

    var needsEncouragement: Bool {
        totalAnswered >= 3 && accuracy < 50
    }

    var streakProgressText: String {
        if currentStreak >= 3 {
            return "\(currentStreak) streak!"
        }
        return "\(currentStreak)/3 to streak!"
    }

    var roundedAccuracy: Int {
        let acc = Int(accuracy)
        return (acc / 5) * 5
    }

    var scoreDifferenceFromAverage: Int {
        score - difficulty.averageScoreThreshold
    }

    var sessionQualityStars: String {
        let rating = performanceRating
        return String(repeating: "⭐", count: rating)
    }

    var isConsistentPerformer: Bool {
        totalAnswered >= 5 && accuracy >= 60
    }

    var quickFinishBonus: Int {
        timeRemaining / 2
    }

    var sessionTitleText: String {
        "\(difficulty.displayName) Challenge"
    }

    var answersPerSecond: Double {
        guard totalTimePlayed > 0 else { return 0.0 }
        return Double(totalAnswered) / Double(totalTimePlayed)
    }

    var perfectGameText: String {
        guard totalAnswered > 0, totalCorrect == totalAnswered else { return "" }
        return "Perfect Game!"
    }

    var difficultyScoreMultiplier: Int {
        switch difficulty {
        case .easy: return 1
        case .medium: return 2
        case .hard: return 3
        }
    }

    var isComebackStory: Bool {
        accuracy < 70 && currentStreak >= 3
    }

    var endOfGameSummary: String {
        "Score: \(score) | Accuracy: \(Int(accuracy))% | Best Streak: \(bestStreak)"
    }

    var shouldShowHint: Bool {
        totalAnswered >= 3 && accuracy < 40 && currentStreak == 0
    }

    var averagePointsPerQuestion: Int {
        guard totalAnswered > 0 else { return 0 }
        return score / totalAnswered
    }

    var isUltraStreak: Bool {
        currentStreak >= 7
    }

    var timeStatusText: String {
        let pct = difficulty.timeLimitSeconds > 0
            ? timeRemaining * 100 / difficulty.timeLimitSeconds
            : 100
        if pct > 50 { return "Plenty of time" }
        if pct > 15 { return "Running low!" }
        return "Hurry!"
    }

    var scoreGradeText: String {
        let pct = scorePercentOfMax
        if pct >= 90 { return "A" }
        if pct >= 75 { return "B" }
        if pct >= 60 { return "C" }
        if pct >= 40 { return "D" }
        return "F"
    }

    var nextMilestone: Int {
        ((score / 50) + 1) * 50
    }

    var progressEmoji: String {
        let pct = difficulty.timeLimitSeconds > 0
            ? totalTimePlayed * 100 / difficulty.timeLimitSeconds
            : 0
        if pct >= 80 { return "🏆" }
        if pct >= 40 { return "🏃" }
        return "🏁"
    }
}
