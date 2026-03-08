import Foundation

struct Achievement: Identifiable {
    enum Category: Sendable { case streak, score, games, mastery }

    let id: String
    let title: String
    let description: String
    let emoji: String
    let requirement: @Sendable (PlayerStats) -> Bool
    let progress: (@Sendable (PlayerStats) -> (current: Int, target: Int))?

    var category: Category {
        if id.contains("streak") { return .streak }
        if id.contains("score") || id == "accuracy_90" { return .score }
        if id.contains("mastery") { return .mastery }
        return .games
    }

    static let all: [Achievement] = [
        Achievement(
            id: "first_game",
            title: "First Steps",
            description: "Complete your first game",
            emoji: "🎯",
            requirement: { $0.gamesPlayed >= 1 },
            progress: { (min($0.gamesPlayed, 1), 1) }
        ),
        Achievement(
            id: "ten_games",
            title: "Getting Started",
            description: "Play 10 games",
            emoji: "🎮",
            requirement: { $0.gamesPlayed >= 10 },
            progress: { (min($0.gamesPlayed, 10), 10) }
        ),
        Achievement(
            id: "century",
            title: "Century Club",
            description: "Solve 100 problems",
            emoji: "💯",
            requirement: { $0.totalSolved >= 100 },
            progress: { (min($0.totalSolved, 100), 100) }
        ),
        Achievement(
            id: "streak_5",
            title: "On Fire",
            description: "Get a streak of 5 correct answers",
            emoji: "🔥",
            requirement: { $0.bestStreak >= 5 },
            progress: { (min($0.bestStreak, 5), 5) }
        ),
        Achievement(
            id: "streak_10",
            title: "Streak Master",
            description: "Get a streak of 10 correct answers",
            emoji: "⚡",
            requirement: { $0.bestStreak >= 10 },
            progress: { (min($0.bestStreak, 10), 10) }
        ),
        Achievement(
            id: "streak_20",
            title: "Unstoppable",
            description: "Get a streak of 20 correct answers",
            emoji: "🌟",
            requirement: { $0.bestStreak >= 20 },
            progress: { (min($0.bestStreak, 20), 20) }
        ),
        Achievement(
            id: "medium_player",
            title: "Leveling Up",
            description: "Complete a medium difficulty game",
            emoji: "📈",
            requirement: { $0.mediumGamesPlayed >= 1 },
            progress: { (min($0.mediumGamesPlayed, 1), 1) }
        ),
        Achievement(
            id: "hard_player",
            title: "Speed Demon",
            description: "Complete a hard difficulty game",
            emoji: "🏎️",
            requirement: { $0.hardGamesPlayed >= 1 },
            progress: { (min($0.hardGamesPlayed, 1), 1) }
        ),
        Achievement(
            id: "score_100",
            title: "High Scorer",
            description: "Score 100 points in a single game",
            emoji: "🏆",
            requirement: { $0.bestScore >= 100 },
            progress: { (min($0.bestScore, 100), 100) }
        ),
        Achievement(
            id: "daily_3",
            title: "Dedicated",
            description: "Maintain a 3-day streak",
            emoji: "📅",
            requirement: { $0.dailyStreak >= 3 },
            progress: { (min($0.dailyStreak, 3), 3) }
        ),
        Achievement(
            id: "daily_7",
            title: "Week Warrior",
            description: "Maintain a 7-day streak",
            emoji: "🗓️",
            requirement: { $0.dailyStreak >= 7 },
            progress: { (min($0.dailyStreak, 7), 7) }
        ),
        Achievement(
            id: "accuracy_90",
            title: "Sharp Mind",
            description: "Achieve 90%+ accuracy with 50+ problems solved",
            emoji: "🧠",
            requirement: { $0.totalSolved >= 50 && $0.accuracy >= 90 },
            progress: { (min($0.totalSolved, 50), 50) }
        ),
        Achievement(
            id: "easy_mastery",
            title: "Easy Master",
            description: "Get 90%+ accuracy on Easy 5 times",
            emoji: "🌱",
            requirement: { $0.easyMasteryCount >= 5 },
            progress: { (min($0.easyMasteryCount, 5), 5) }
        ),
        Achievement(
            id: "medium_mastery",
            title: "Medium Master",
            description: "Get 90%+ accuracy on Medium 5 times",
            emoji: "⚡",
            requirement: { $0.mediumMasteryCount >= 5 },
            progress: { (min($0.mediumMasteryCount, 5), 5) }
        ),
        Achievement(
            id: "hard_mastery",
            title: "Hard Master",
            description: "Get 90%+ accuracy on Hard 5 times",
            emoji: "🔥",
            requirement: { $0.hardMasteryCount >= 5 },
            progress: { (min($0.hardMasteryCount, 5), 5) }
        )
    ]

    func isUnlocked(stats: PlayerStats) -> Bool {
        requirement(stats)
    }

    static func unlockedCount(for stats: PlayerStats) -> Int {
        all.filter { $0.isUnlocked(stats: stats) }.count
    }

    static func lockedCount(for stats: PlayerStats) -> Int {
        all.count - unlockedCount(for: stats)
    }

    func progressPercentage(stats: PlayerStats) -> Int {
        guard let progress else { return isUnlocked(stats: stats) ? 100 : 0 }
        let result = progress(stats)
        guard result.target > 0 else { return 0 }
        return min(result.current * 100 / result.target, 100)
    }

    static func totalProgressPercentage(for stats: PlayerStats) -> Int {
        guard !all.isEmpty else { return 0 }
        let totalPct = all.reduce(0) { $0 + $1.progressPercentage(stats: stats) }
        return totalPct / all.count
    }

    func progressFraction(stats: PlayerStats) -> Double {
        guard let progress else { return isUnlocked(stats: stats) ? 1.0 : 0.0 }
        let result = progress(stats)
        guard result.target > 0 else { return 0.0 }
        return min(Double(result.current) / Double(result.target), 1.0)
    }

    static func categoryCount(for category: Category) -> Int {
        all.filter { $0.category == category }.count
    }

    static func unlockedAchievements(for stats: PlayerStats) -> [Achievement] {
        all.filter { $0.isUnlocked(stats: stats) }
    }

    static func lockedAchievements(for stats: PlayerStats) -> [Achievement] {
        all.filter { !$0.isUnlocked(stats: stats) }
    }

    static func nextClosest(for stats: PlayerStats) -> Achievement? {
        let locked = all.filter { !$0.isUnlocked(stats: stats) }
        guard !locked.isEmpty else { return nil }
        return locked.max { a, b in
            a.progressPercentage(stats: stats) < b.progressPercentage(stats: stats)
        }
    }
}
