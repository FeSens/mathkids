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

    static func isMaxLevel(for xp: Int) -> Bool {
        level(for: xp) >= thresholds.count
    }

    static func levelTitle(for xp: Int) -> String {
        let lvl = level(for: xp)
        return "Lv. \(lvl) \(levelNames[lvl - 1])"
    }

    static func xpNeededForNextLevel(currentXP: Int) -> Int {
        let currentLevel = level(for: currentXP)
        guard currentLevel < thresholds.count else { return 0 }
        return thresholds[currentLevel] - currentXP
    }

    static var xpToMaxLevel: Int {
        thresholds.last ?? 0
    }

    static func xpRemainingToMax(currentXP: Int) -> Int {
        max(xpToMaxLevel - currentXP, 0)
    }

    static let levelEmojis = ["🌱", "📚", "🔍", "🧠", "🔧", "🧮", "⭐", "🏆", "👑", "🧙"]

    static func levelEmoji(for xp: Int) -> String {
        let lvl = level(for: xp)
        return levelEmojis[lvl - 1]
    }

    static func xpPercentageText(for xp: Int) -> String {
        let progress = progressToNextLevel(for: xp)
        let pct = Int(progress * 100)
        return "\(pct)%"
    }

    static let baseXPPerAnswer = 10

    static func streakBonusXP(streak: Int) -> Int {
        min(streak, 10) * 2
    }

    static func xpForCorrectAnswer(streak: Int) -> Int {
        let base = 10
        let streakBonus = min(streak, 10) * 2
        return base + streakBonus
    }
}
