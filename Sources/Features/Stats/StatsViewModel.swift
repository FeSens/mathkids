import Foundation
import Observation

@Observable
@MainActor
final class StatsViewModel {
    var totalSolved: Int = 0
    var totalCorrect: Int = 0
    var accuracy: Double = 0
    var bestStreak: Int = 0
    var dailyStreak: Int = 0
    var bestScore: Int = 0
    var gamesPlayed: Int = 0
    var easyGames: Int = 0
    var mediumGames: Int = 0
    var hardGames: Int = 0
    var playerStats: PlayerStats?
    var recentAccuracies: [Double] = []

    var favoriteOperation: String?
    var favoriteOperationCount: Int = 0

    var gamesMilestone: String? {
        switch gamesPlayed {
        case 100...: "Century Gamer"
        case 50..<100: "Dedicated Player"
        case 25..<50: "Rising Star"
        case 10..<25: "Getting Started"
        default: nil
        }
    }

    private let statsService: StatsService

    init(statsService: StatsService) {
        self.statsService = statsService
    }

    func loadStats() {
        let stats = statsService.getOrCreateStats()
        playerStats = stats
        totalSolved = stats.totalSolved
        totalCorrect = stats.totalCorrect
        accuracy = stats.accuracy
        bestStreak = stats.bestStreak
        dailyStreak = stats.dailyStreak
        bestScore = stats.bestScore
        gamesPlayed = stats.gamesPlayed
        easyGames = stats.easyGamesPlayed
        mediumGames = stats.mediumGamesPlayed
        hardGames = stats.hardGamesPlayed
        recentAccuracies = stats.recentAccuracies
        if let fav = stats.favoriteOperation {
            favoriteOperation = fav.symbol
            favoriteOperationCount = fav.count
        }
    }
}
