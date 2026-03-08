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
}
