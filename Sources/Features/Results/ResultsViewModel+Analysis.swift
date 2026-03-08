import Foundation

extension ResultsViewModel {
    var scoreComparisonText: String {
        if isNewBestScore && previousBestScore > 0 {
            return "New Best! +\(scoreImprovement) pts"
        } else if previousBestScore > 0 {
            return "Best: \(previousBestScore) pts"
        } else {
            return "First game!"
        }
    }

    var sessionSummary: String {
        "Score: \(finalScore) | Accuracy: \(Int(accuracy))% | Streak: \(bestStreak)"
    }

    var scoreAsPercentOfMax: Double {
        let maxScore = session.difficulty.maxPossibleScore
        guard maxScore > 0 else { return 0 }
        return min(Double(session.score) / Double(maxScore) * 100, 100)
    }

    var accuracyComparisonText: String? {
        guard let avg = playerAverageAccuracy else { return nil }
        let diff = accuracy - avg
        if diff > 5 {
            return "\(Int(diff))% above your average!"
        } else if diff < -5 {
            return "\(Int(abs(diff)))% below your average"
        } else {
            return "Right at your average"
        }
    }

    var timePerformanceText: String {
        let timePlayed = session.totalTimePlayed
        guard timePlayed > 0, session.totalAnswered > 0 else { return "N/A" }
        let avgTime = Double(timePlayed) / Double(session.totalAnswered)
        let target = Double(session.difficulty.recommendedSecondsPerProblem)
        if avgTime < target * 0.7 {
            return "Lightning fast!"
        } else if avgTime <= target * 1.3 {
            return "On pace"
        } else {
            return "Take your time"
        }
    }

    var improvementSummary: String {
        if isPerfectScore {
            return "Perfect score! You nailed every problem!"
        } else if accuracy >= 80 {
            return "Great job! You're doing really well!"
        } else if accuracy >= 60 {
            return "Good effort! Keep practicing to improve!"
        } else {
            return "Keep trying! Practice makes perfect!"
        }
    }

    var gradeLabel: String {
        if accuracy >= 95 { return "A+" }
        if accuracy >= 90 { return "A" }
        if accuracy >= 80 { return "B" }
        if accuracy >= 70 { return "C" }
        if accuracy >= 60 { return "D" }
        return "F"
    }

    var accuracyWithGrade: String {
        "\(Int(accuracy))% (\(gradeLabel))"
    }

    var problemCountText: String {
        let count = session.totalAnswered
        return "\(count) problems answered"
    }

    var difficultyBadgeText: String {
        "\(session.difficulty.emoji) \(session.difficulty.displayName)"
    }

    var operationSummaryText: String {
        "\(session.difficulty.displayName) mode"
    }

    var finalScoreText: String {
        "\(session.finalScoreWithTimeBonus) pts"
    }

    var correctVsWrongText: String {
        "\(session.totalCorrect) correct / \(session.totalWrong) wrong"
    }

    var timeBonusText: String {
        "+\(session.timeBonus) pts"
    }

    var streakRewardText: String? {
        guard bestStreak >= 5 else { return nil }
        return "Amazing \(bestStreak) streak!"
    }

    var hasTimeBonus: Bool {
        session.timeBonus > 0
    }

    var streakEmoji: String {
        bestStreak >= 3 ? "🔥" : ""
    }

    var accuracyEmoji: String {
        if accuracy >= 90 { return "⭐" }
        if accuracy >= 70 { return "👍" }
        if accuracy >= 50 { return "💪" }
        return "🤔"
    }

    var isNewRecord: Bool {
        finalScore > previousBestScore && finalScore > 0
    }

    var accuracyPercentInt: Int {
        Int(accuracy)
    }

    var answeredCountText: String {
        "\(session.totalAnswered) problems"
    }

    var scoreBreakdownText: String {
        "\(session.score) + \(session.timeBonus) bonus = \(session.finalScoreWithTimeBonus) pts"
    }

    var streakSummaryText: String {
        "Best streak: \(bestStreak)"
    }

    var isPerfectGame: Bool {
        session.answeredAllCorrectly
    }

    var hasStreak: Bool {
        bestStreak > 0
    }

    var sessionDurationLabel: String {
        "\(session.totalTimePlayed)s played"
    }

    var difficultyDisplayText: String {
        "\(session.difficulty.emoji) \(session.difficulty.displayName)"
    }

    var wrongAnswerLabel: String {
        "\(session.totalWrong) wrong"
    }

    var correctAnswerLabel: String {
        "\(session.totalCorrect) correct"
    }

    var timeTakenText: String {
        "\(session.totalTimePlayed)s"
    }

    var scorePercentageText: String {
        "\(Int(scoreAsPercentOfMax))%"
    }

    var accuracyBarWidth: Double {
        accuracy / 100.0
    }

    var recommendationText: String? {
        switch difficultyRecommendation {
        case .tryHarder:
            let next = session.difficulty == .easy ? "Medium" : "Hard"
            return "You're crushing it! Try \(next) mode"
        case .tryEasier:
            let prev = session.difficulty == .hard ? "Medium" : "Easy"
            return "Try \(prev) mode to build confidence"
        case .stayHere:
            return nil
        }
    }
}
