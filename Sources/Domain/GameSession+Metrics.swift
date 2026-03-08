import Foundation

// Extension for GameSession computed properties that only use public/internal API.
// Properties that access private fields (answerHistory, correctPerOperation, etc.)
// remain in GameSession.swift.
extension GameSession {
    var scorePerCorrect: Double {
        guard totalCorrect > 0 else { return 0 }
        return Double(score) / Double(totalCorrect)
    }

    var totalWrong: Int {
        totalAnswered - totalCorrect
    }

    var baseScore: Int {
        totalCorrect * difficulty.pointsPerCorrect
    }

    var streakMilestoneReached: Int? {
        guard currentStreak > 0 && currentStreak % 5 == 0 else { return nil }
        return currentStreak
    }

    var problemsPerMinute: Double {
        let minutes = Double(totalTimePlayed) / 60.0
        guard minutes > 0 else { return 0 }
        return Double(totalAnswered) / minutes
    }

    var streakBonusPoints: Int {
        totalBonusPoints
    }

    var correctPercentage: Double {
        guard totalAnswered > 0 else { return 0 }
        return Double(totalCorrect) / Double(totalAnswered) * 100
    }

    var wrongPercentage: Double {
        guard totalAnswered > 0 else { return 0 }
        return Double(totalWrong) / Double(totalAnswered) * 100
    }

    var finalScoreWithTimeBonus: Int {
        score + timeBonus
    }

    var penaltyPoints: Int {
        totalWrong * difficulty.penaltyPerWrong
    }

    enum AnswerSpeed: Sendable {
        case fast, normal, slow
    }

    var answerSpeedClass: AnswerSpeed? {
        guard totalAnswered > 0, totalTimePlayed > 0 else { return nil }
        let avgTime = Double(totalTimePlayed) / Double(totalAnswered)
        if avgTime < 3 { return .fast }
        if avgTime <= 6 { return .normal }
        return .slow
    }

    var timeBonus: Int {
        let multiplier: Int
        switch difficulty {
        case .easy: multiplier = 1
        case .medium: multiplier = 2
        case .hard: multiplier = 3
        }
        return timeRemaining * multiplier
    }

    var projectedFinalScore: Int {
        guard totalAnswered > 0, totalTimePlayed > 0, timeRemaining > 0 else { return score }
        let scorePerSecond = Double(score) / Double(totalTimePlayed)
        return score + Int(scorePerSecond * Double(timeRemaining))
    }

    var estimatedProblemsPerRemainingMinute: Double {
        guard totalAnswered > 0, totalTimePlayed > 0, timeRemaining > 0 else { return 0 }
        return problemsPerMinute
    }

    var netScore: Int {
        max(score - penaltyPoints, 0)
    }

    var timeUsagePercentage: Int {
        let total = difficulty.timeLimitSeconds
        guard total > 0 else { return 0 }
        return totalTimePlayed * 100 / total
    }

    var scoreBreakdownText: String {
        guard score > 0 else { return "" }
        if totalBonusPoints > 0 {
            return "Base: \(baseScore) | Bonus: \(totalBonusPoints)"
        }
        return "Base: \(baseScore)"
    }

    var streakAtEnd: Int {
        currentStreak
    }

    var longestCorrectRun: Int {
        bestStreak
    }

    var scoreEfficiency: Double {
        guard totalTimePlayed > 0 else { return 0 }
        return Double(score) / Double(totalTimePlayed)
    }

    var correctAnswersPerMinute: Double {
        let minutes = Double(totalTimePlayed) / 60.0
        guard minutes > 0 else { return 0 }
        return Double(totalCorrect) / minutes
    }

    var averageTimePerAnswer: Double {
        guard totalAnswered > 0 else { return 0 }
        return Double(totalTimePlayed) / Double(totalAnswered)
    }

    enum Pace: Sendable {
        case ahead, behind, onPace
    }

    var currentPace: Pace {
        guard totalAnswered > 0, totalTimePlayed > 0 else { return .onPace }
        if accuracy >= 70 { return .ahead }
        if accuracy < 40 { return .behind }
        return .onPace
    }
}
