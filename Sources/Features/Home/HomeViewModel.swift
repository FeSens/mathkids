import Foundation
import Observation
import SwiftData

@Observable
@MainActor
final class HomeViewModel {
    var selectedDifficulty: DifficultyLevel = .easy
    var totalSolved: Int = 0
    var dailyStreak: Int = 0
    var bestScore: Int = 0

    private let statsService: StatsService

    init(statsService: StatsService) {
        self.statsService = statsService
    }

    func loadStats() {
        let stats = statsService.getOrCreateStats()
        totalSolved = stats.totalSolved
        dailyStreak = stats.dailyStreak
        bestScore = stats.bestScore
    }
}
