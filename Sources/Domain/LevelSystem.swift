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

    static func tierColor(for xp: Int) -> String {
        switch levelTier(for: xp) {
        case .beginner: "green"
        case .intermediate: "blue"
        case .advanced: "purple"
        case .expert: "gold"
        }
    }

    enum LevelTier: Sendable {
        case beginner, intermediate, advanced, expert
    }

    static func levelTier(for xp: Int) -> LevelTier {
        let lvl = level(for: xp)
        if lvl <= 3 { return .beginner }
        if lvl <= 6 { return .intermediate }
        if lvl <= 9 { return .advanced }
        return .expert
    }

    static func estimatedSessionsToNextLevel(currentXP: Int, avgXPPerSession: Int) -> Int {
        let needed = xpNeededForNextLevel(currentXP: currentXP)
        guard needed > 0, avgXPPerSession > 0 else { return 0 }
        return (needed + avgXPPerSession - 1) / avgXPPerSession // ceil division
    }

    static func xpRange(forLevel level: Int) -> (min: Int, max: Int?) {
        guard level >= 1, level <= thresholds.count else { return (0, nil) }
        let minXP = thresholds[level - 1]
        if level >= thresholds.count {
            return (minXP, nil)
        }
        return (minXP, thresholds[level] - 1)
    }

    static func xpForCorrectAnswer(streak: Int) -> Int {
        let base = 10
        let streakBonus = min(streak, 10) * 2
        return base + streakBonus
    }

    static func nextLevelName(for xp: Int) -> String? {
        let currentLevel = level(for: xp)
        guard currentLevel < totalLevels else { return nil }
        return levelNames[currentLevel]
    }

    static func isAtMaxLevel(xp: Int) -> Bool {
        isMaxLevel(for: xp)
    }

    static func xpUntilMax(currentXP: Int) -> Int {
        xpRemainingToMax(currentXP: currentXP)
    }

    static func currentLevelName(for xp: Int) -> String {
        levelName(for: xp)
    }

    static func didReachMilestone(oldXP: Int, newXP: Int, interval: Int) -> Bool {
        guard interval > 0 else { return false }
        return oldXP / interval != newXP / interval
    }

    static func remainingLevels(for xp: Int) -> Int {
        max(totalLevels - level(for: xp), 0)
    }

    static func levelCompletionPercentage(currentXP: Int, forLevel level: Int) -> Int {
        guard level >= 1, level < thresholds.count else { return 0 }
        let start = thresholds[level - 1]
        let end = thresholds[level]
        let range = end - start
        guard range > 0 else { return 0 }
        let progress = currentXP - start
        guard progress > 0 else { return 0 }
        return min(progress * 100 / range, 100)
    }

    static func isNewLevel(oldXP: Int, newXP: Int) -> Bool {
        level(for: oldXP) != level(for: newXP)
    }

    static func levelGap(forLevel level: Int) -> Int {
        guard level >= 1, level < thresholds.count else { return 0 }
        return thresholds[level] - thresholds[level - 1]
    }

    static var allLevelInfo: [(level: Int, name: String, threshold: Int)] {
        (0..<thresholds.count).map { i in
            (level: i + 1, name: levelNames[i], threshold: thresholds[i])
        }
    }

    static func percentToMax(currentXP: Int) -> Int {
        let maxXP = xpToMaxLevel
        guard maxXP > 0 else { return 0 }
        return min(currentXP * 100 / maxXP, 100)
    }

    static func xpToNextMilestone(currentXP: Int) -> Int {
        let next = ((currentXP / 100) + 1) * 100
        return next - currentXP
    }

    static func xpSummary(for xp: Int) -> String {
        let lvl = level(for: xp)
        let name = levelName(for: xp)
        return "Level \(lvl) \(name) | \(xp) XP"
    }

    static func milestoneDescription(forLevel level: Int) -> String {
        guard level >= 1, level <= levelNames.count else { return "" }
        let name = levelNames[level - 1]
        if level == levelNames.count {
            return "You've reached \(name) — the max level!"
        }
        return "Welcome to \(name)! Keep going!"
    }

    static func levelProgressBar(for xp: Int) -> String {
        let progress: Double
        if isMaxLevel(for: xp) {
            progress = 1.0
        } else {
            progress = progressToNextLevel(for: xp)
        }
        let pct = Int(progress * 100)
        let filled = Int(progress * 10)
        let empty = 10 - filled
        let bar = String(repeating: "█", count: filled) + String(repeating: "░", count: empty)
        return "[\(bar)] \(pct)%"
    }

    static func isLevelBoundary(xp: Int) -> Bool {
        thresholds.contains(xp)
    }

    static var totalLevels: Int {
        thresholds.count
    }

    static func levelUpMessage(from oldLevel: Int, to newLevel: Int) -> String {
        let oldName = levelNames[max(oldLevel - 1, 0)]
        let newName = levelNames[min(newLevel - 1, levelNames.count - 1)]
        return "Level Up! \(oldName) → \(newName)"
    }

    static func xpForLevel(_ level: Int) -> Int? {
        guard level >= 1, level <= thresholds.count else { return nil }
        return thresholds[level - 1]
    }

    static func levelsBetween(xp1: Int, xp2: Int) -> Int {
        abs(level(for: xp2) - level(for: xp1))
    }

    static var totalXPAcrossAllLevels: Int {
        thresholds.reduce(0, +)
    }

    static func progressDescription(for xp: Int) -> String {
        let currentLevel = level(for: xp)
        let name = levelName(for: xp)
        guard currentLevel < thresholds.count else {
            return "\(name) — Max level reached!"
        }
        let needed = xpNeededForNextLevel(currentXP: xp)
        return "\(name) — \(needed) XP to next level"
    }
}
