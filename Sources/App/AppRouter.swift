import Foundation
import Observation

enum AppRoute: Hashable {
    case game(DifficultyLevel, Set<Operation>)
    case practice(DifficultyLevel, Set<Operation>)
    case dailyChallenge
    case results(score: Int, correct: Int, total: Int, accuracy: Double, bestStreak: Int, difficulty: DifficultyLevel, isNewBest: Bool)
}

@Observable
@MainActor
final class AppRouter {
    var path: [AppRoute] = []

    func navigateToGame(difficulty: DifficultyLevel, operations: Set<Operation>) {
        path.append(.game(difficulty, operations))
    }

    func navigateToPractice(difficulty: DifficultyLevel, operations: Set<Operation>) {
        path.append(.practice(difficulty, operations))
    }

    func navigateToDailyChallenge() {
        path.append(.dailyChallenge)
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
