import Foundation
import Observation

@Observable
@MainActor
final class ResultsViewModel {
    let session: GameSession
    let isNewBestScore: Bool
    private(set) var animatedScore: Int = 0

    init(session: GameSession, previousBestScore: Int) {
        self.session = session
        self.isNewBestScore = session.score > previousBestScore
    }

    var finalScore: Int { session.score }
    var accuracy: Double { session.accuracy }
    var totalAnswered: Int { session.totalAnswered }
    var totalCorrect: Int { session.totalCorrect }
    var bestStreak: Int { session.bestStreak }
    var difficulty: DifficultyLevel { session.difficulty }

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
