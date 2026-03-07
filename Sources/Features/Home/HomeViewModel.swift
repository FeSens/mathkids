import Foundation
import Observation
import SwiftData

@Observable
@MainActor
final class HomeViewModel {
    var selectedDifficulty: DifficultyLevel = .easy
    var selectedOperations: Set<Operation> = Set(Operation.allCases)
    var totalSolved: Int = 0
    var dailyStreak: Int = 0
    var bestScore: Int = 0
    var dailyChallengeCompleted: Bool = false
    var dailyChallengeBestTime: Int = 0

    private let statsService: StatsService

    init(statsService: StatsService) {
        self.statsService = statsService
        // Load saved operations
        if let saved = UserDefaults.standard.array(forKey: "selectedOperations") as? [String] {
            let ops = saved.compactMap { Operation(rawValue: $0) }
            if !ops.isEmpty {
                selectedOperations = Set(ops)
            }
        }
    }

    func toggleOperation(_ op: Operation) {
        if selectedOperations.contains(op) && selectedOperations.count > 1 {
            selectedOperations.remove(op)
        } else {
            selectedOperations.insert(op)
        }
        UserDefaults.standard.set(selectedOperations.map(\.rawValue), forKey: "selectedOperations")
    }

    func loadStats() {
        let stats = statsService.getOrCreateStats()
        totalSolved = stats.totalSolved
        dailyStreak = stats.dailyStreak
        bestScore = stats.bestScore
        dailyChallengeBestTime = stats.dailyChallengeBestTime

        let calendar = Calendar.current
        if let lastChallenge = stats.lastDailyChallengeDate {
            dailyChallengeCompleted = calendar.isDateInToday(lastChallenge)
        } else {
            dailyChallengeCompleted = false
        }
    }
}
