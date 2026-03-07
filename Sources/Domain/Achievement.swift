import Foundation

struct Achievement: Identifiable {
    let id: String
    let title: String
    let description: String
    let emoji: String
    let requirement: @Sendable (PlayerStats) -> Bool
    let progress: (@Sendable (PlayerStats) -> (current: Int, target: Int))?

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
        )
    ]

    func isUnlocked(stats: PlayerStats) -> Bool {
        requirement(stats)
    }
}
