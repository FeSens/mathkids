import Foundation
import Observation

@Observable
@MainActor
final class ResultsViewModel {
    let session: GameSession
    let isNewBestScore: Bool
    private(set) var animatedScore: Int = 0
    private(set) var newAchievements: [Achievement] = []

    init(session: GameSession, previousBestScore: Int, stats: PlayerStats? = nil) {
        self.session = session
        self.isNewBestScore = session.score > previousBestScore

        if let stats {
            newAchievements = Achievement.all.filter { $0.isUnlocked(stats: stats) }
            // Only show first newly unlocked (simplification)
            if newAchievements.count > 3 {
                newAchievements = Array(newAchievements.prefix(3))
            }
        }
    }

    var finalScore: Int { session.score }
    var accuracy: Double { session.accuracy }
    var totalAnswered: Int { session.totalAnswered }
    var totalCorrect: Int { session.totalCorrect }
    var bestStreak: Int { session.bestStreak }
    var difficulty: DifficultyLevel { session.difficulty }
    var hasNewAchievements: Bool { !newAchievements.isEmpty }

    func animateScore() {
        let target = session.score
        guard target > 0 else {
            animatedScore = 0
            return
        }

        let steps = min(target, 30)
        let increment = max(target / steps, 1)
        var current = 0

        Task {
            for _ in 0..<steps {
                try? await Task.sleep(for: .milliseconds(30))
                current = min(current + increment, target)
                animatedScore = current
            }
            animatedScore = target
        }
    }
}
