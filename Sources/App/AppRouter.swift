import Foundation
import Observation

enum AppRoute: Hashable {
    case game(DifficultyLevel)
    case practice(DifficultyLevel)
    case results(score: Int, correct: Int, total: Int, accuracy: Double, bestStreak: Int, difficulty: DifficultyLevel, isNewBest: Bool)
}

@Observable
@MainActor
final class AppRouter {
    var path: [AppRoute] = []

    func navigateToGame(difficulty: DifficultyLevel) {
        path.append(.game(difficulty))
    }

    func navigateToPractice(difficulty: DifficultyLevel) {
        path.append(.practice(difficulty))
    }

    func navigateToResults(session: GameSession, isNewBest: Bool) {
        path.append(.results(
            score: session.score,
            correct: session.totalCorrect,
            total: session.totalAnswered,
            accuracy: session.accuracy,
            bestStreak: session.bestStreak,
            difficulty: session.difficulty,
            isNewBest: isNewBest
        ))
    }

    func popToRoot() {
        path.removeAll()
    }

    func pop() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
