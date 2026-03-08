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

    var motivationalMessage: String {
        if accuracy >= 90 { return "Amazing work!" }
        if accuracy >= 70 { return "Great job!" }
        if accuracy >= 50 { return "Good effort!" }
        return "Keep trying!"
    }

    var correctCountDisplay: String {
        "✅ \(totalCorrect)"
    }

    var wrongCountDisplay: String {
        "❌ \(totalAnswered - totalCorrect)"
    }

    var hasStreak: Bool {
        bestStreak > 0
    }

    var elapsedSeconds: Int {
        totalTimePlayed
    }

    var formattedScore: String {
        "\(score) pts"
    }

    var streakLevel: String {
        if bestStreak >= 10 { return "amazing" }
        if bestStreak >= 5 { return "great" }
        if bestStreak >= 3 { return "good" }
        return "none"
    }

    var isQuickAnswerer: Bool {
        guard totalAnswered > 0, totalTimePlayed > 0 else { return false }
        return totalTimePlayed / totalAnswered < 3
    }

    var totalQuestionsLeft: Int {
        guard totalAnswered > 0, totalTimePlayed > 0 else { return 0 }
        let rate = totalAnswered * timeRemaining / totalTimePlayed
        return rate
    }

    var difficultyColor: String {
        difficulty.color
    }

    var gameStatusText: String {
        isFinished ? "Finished" : "In Progress"
    }

    var pointsPerCorrectAnswer: String {
        "\(difficulty.pointsPerCorrect) pts/correct"
    }

    var isNewGame: Bool {
        totalAnswered == 0 && timeRemaining == difficulty.timeLimitSeconds
    }

    var currentScoreLabel: String {
        "Score: \(score)"
    }

    var hasPerfectStreak: Bool {
        totalAnswered > 0 && totalCorrect == totalAnswered
    }

    var timeLimitText: String {
        "\(difficulty.timeLimitSeconds)s total"
    }

    var isSlowPace: Bool {
        guard totalAnswered > 0, totalTimePlayed > 0 else { return false }
        let avgTime = totalTimePlayed / totalAnswered
        return avgTime > difficulty.recommendedSecondsPerProblem
    }

    var streakStatusDescription: String {
        if bestStreak >= 10 { return "Amazing \(bestStreak) streak!" }
        if bestStreak >= 5 { return "Great \(bestStreak) streak!" }
        if bestStreak >= 3 { return "\(bestStreak) streak" }
        return "No streak"
    }

    var totalAnsweredDisplay: String {
        "\(totalAnswered) answers"
    }

    var isEndOfGame: Bool {
        isFinished || timeRemaining <= 0
    }

    var accuracyColor: String {
        if accuracy >= 80 { return "green" }
        if accuracy >= 50 { return "orange" }
        return "red"
    }

    var bonusDisplay: String {
        "+\(totalBonusPoints)"
    }

    var scoreProgress: Double {
        let maxScore = difficulty.maxPossibleScore
        guard maxScore > 0 else { return 0 }
        return min(Double(score) / Double(maxScore), 1.0)
    }

    var isHighStreak: Bool {
        bestStreak >= 5
    }

    var answeredPercentage: Int {
        let estimated = difficulty.estimatedProblemsPerGame
        guard estimated > 0 else { return 0 }
        return totalAnswered * 100 / estimated
    }

    var xpEarnedDisplay: String {
        let xp = totalCorrect * difficulty.xpPerCorrectAnswer
        return "+\(xp) XP"
    }

    var finalResultEmoji: String {
        if accuracy >= 90 { return "⭐" }
        if accuracy >= 70 { return "👍" }
        if accuracy >= 50 { return "💪" }
        return "🤔"
    }

    var sessionDurationText: String {
        "\(totalTimePlayed)s"
    }

    var wrongAnswerPercent: Int {
        guard totalAnswered > 0 else { return 0 }
        return (totalAnswered - totalCorrect) * 100 / totalAnswered
    }

    var hasTimedOut: Bool {
        timeRemaining <= 0
    }

    var averageTimePerAnswerText: String {
        guard totalAnswered > 0 else { return "0s/answer" }
        let avg = totalTimePlayed / totalAnswered
        return "\(avg)s/answer"
    }

    var isAboveAverageScore: Bool {
        score >= difficulty.averageScoreThreshold
    }

    var timeRemainingPercent: Int {
        guard difficulty.timeLimitSeconds > 0 else { return 0 }
        return timeRemaining * 100 / difficulty.timeLimitSeconds
    }

    var streakMultiplierText: String {
        if currentStreak >= 5 { return "x3" }
        if currentStreak >= 3 { return "x2" }
        return "x1"
    }

    var performanceRating: Int {
        let acc = accuracy
        if acc >= 90 { return 5 }
        if acc >= 75 { return 4 }
        if acc >= 60 { return 3 }
        if acc >= 40 { return 2 }
        return 1
    }
}
