import Foundation

enum LevelSystem {
    static let thresholds = [0, 100, 300, 600, 1000, 1500, 2100, 2800, 3600, 4500]

    static let levelNames = [
        "Beginner",
        "Learner",
        "Explorer",
        "Thinker",
        "Problem Solver",
        "Calculator",
        "Math Star",
        "Math Champion",
        "Math Master",
        "Math Wizard"
    ]

    static func level(for xp: Int) -> Int {
        var level = 1
        for (index, threshold) in thresholds.enumerated() {
            if xp >= threshold {
                level = index + 1
            }
        }
        return level
    }

    static func progressToNextLevel(for xp: Int) -> Double {
        let currentLevel = level(for: xp)
        guard currentLevel < thresholds.count else { return 1.0 }

        let currentThreshold = thresholds[currentLevel - 1]
        let nextThreshold = thresholds[currentLevel]
        let range = nextThreshold - currentThreshold

        guard range > 0 else { return 1.0 }
        return Double(xp - currentThreshold) / Double(range)
    }

    static func levelName(for xp: Int) -> String {
        let lvl = level(for: xp)
        return levelNames[lvl - 1]
    }

    static func xpForCorrectAnswer(streak: Int) -> Int {
        let base = 10
        let streakBonus = min(streak, 10) * 2
        return base + streakBonus
    }
}
