import Foundation

extension AnsweredProblem {
    var answeredProblemBonusMultiplier: Int {
        guard isCorrect else { return 0 }
        if let time = timeTaken, time < 3.0 { return 2 }
        return 1
    }

    var answeredProblemIsStreakBreaker: Bool {
        !isCorrect
    }

    var answeredProblemRewardTier: String {
        guard isCorrect else { return "none" }
        guard let time = timeTaken else { return "bronze" }
        if time < 1.0 { return "platinum" }
        if time < 3.0 { return "gold" }
        if time < 6.0 { return "silver" }
        return "bronze"
    }

    var answeredProblemComboValue: Int {
        isCorrect ? 1 : -1
    }

    var answeredProblemExperienceCategory: String {
        guard isCorrect else { return "novice" }
        guard let time = timeTaken else { return "competent" }
        if time < 3.0 { return "expert" }
        if time < 6.0 { return "competent" }
        return "novice"
    }

    var answeredProblemLevelUpEligible: Bool {
        isCorrect && !problem.operation.isPrimaryOperation && (timeTaken ?? Double.infinity) < 3.0
    }

    var answeredProblemSpeedBonus: Int {
        guard isCorrect, let time = timeTaken else { return 0 }
        if time < 1.0 { return 5 }
        if time < 3.0 { return 3 }
        return 0
    }

    var answeredProblemAccuracyScore: Int {
        let delta = abs(userAnswer - problem.correctAnswer)
        if delta == 0 { return 100 }
        return max(0, 100 - delta * 20)
    }

    var answeredProblemChallengeTier: String {
        "tier\(problem.operation.difficultyWeight)"
    }

    var answeredProblemPenaltyPoints: Int {
        guard !isCorrect else { return 0 }
        return abs(userAnswer - problem.correctAnswer) * 2
    }

    var answeredProblemTotalScore: Int {
        guard isCorrect else { return 0 }
        let base = problem.operation.difficultyWeight * 10
        return base * answeredProblemBonusMultiplier + answeredProblemSpeedBonus
    }

    var answeredProblemAchievementCandidate: Bool {
        isCorrect && !problem.operation.isPrimaryOperation && (timeTaken ?? Double.infinity) < 3.0
    }

    var answeredProblemStreakMultiplier: Int {
        guard isCorrect else { return 0 }
        if let time = timeTaken, time < 2.0 { return 3 }
        if let time = timeTaken, time < 4.0 { return 2 }
        return 1
    }

    var answeredProblemGemReward: Int {
        guard isCorrect, let time = timeTaken, time < 1.0 else { return 0 }
        return 1
    }

    var answeredProblemRankPoints: Int {
        guard isCorrect else { return 0 }
        return problem.operation.difficultyWeight * 3
    }

    var answeredProblemMilestoneProgress: String {
        guard isCorrect else { return "0%" }
        return "\(problem.operation.difficultyWeight * 10)%"
    }

    var answeredProblemIsGoldStar: Bool {
        isCorrect && (timeTaken ?? Double.infinity) < 2.0
    }

    var answeredProblemScoreLabel: String {
        "+\(answeredProblemTotalScore)"
    }

    var answeredProblemDifficultyBonus: Int {
        guard isCorrect else { return 0 }
        let weight = problem.operation.difficultyWeight
        return weight > 2 ? (weight - 2) * 5 : 0
    }

    var answeredProblemProgressPoints: Int {
        isCorrect ? 1 : 0
    }

    var answeredProblemLeaderboardScore: String {
        "\(answeredProblemTotalScore)"
    }

    var answeredProblemIsNewRecord: Bool {
        isCorrect && !problem.operation.isPrimaryOperation && (timeTaken ?? Double.infinity) < 1.0
    }

    var answeredProblemTicketReward: Int {
        isCorrect ? 1 : 0
    }

    var answeredProblemPowerUpCharge: Int {
        guard isCorrect else { return 0 }
        if let time = timeTaken, time < 2.0 { return 2 }
        return 1
    }

    var answeredProblemQuestProgress: Int {
        isCorrect ? problem.operation.difficultyWeight : 0
    }

    var answeredProblemStaminaCost: Int {
        problem.operation.difficultyWeight
    }

    var answeredProblemChallengeRating: String {
        guard isCorrect else { return "D" }
        guard let time = timeTaken else { return "C" }
        if time < 1.0 && !problem.operation.isPrimaryOperation { return "S" }
        if time < 2.0 { return "A" }
        if time < 5.0 { return "B" }
        return "C"
    }

    var answeredProblemUnlockValue: Int {
        isCorrect ? problem.operation.difficultyWeight : 0
    }

    var answeredProblemIsCriticalHit: Bool {
        isCorrect && !problem.operation.isPrimaryOperation && (timeTaken ?? Double.infinity) < 1.0
    }

    var answeredProblemEnergyGain: Int {
        guard isCorrect else { return 0 }
        if let time = timeTaken, time < 2.0 { return 3 }
        return 1
    }
}
