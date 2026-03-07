import Foundation
import Observation

@Observable
@MainActor
final class GameViewModel {
    private(set) var engine: GameEngine
    var answerText: String = ""
    var showCelebration: Bool = false
    var showShake: Bool = false
    var celebrationIntensity: CelebrationIntensity = .normal

    enum CelebrationIntensity {
        case normal
        case big
        case huge
    }

    init(difficulty: DifficultyLevel) {
        self.engine = GameEngine(difficulty: difficulty)
    }

    var problemText: String { engine.currentProblem.displayText }
    var score: Int { engine.score }
    var timeRemaining: Int { engine.timeRemaining }
    var timeProgress: Double { engine.timeProgress }
    var currentStreak: Int { engine.currentStreak }
    var isGameOver: Bool { engine.isGameOver }
    var session: GameSession { engine.session }

    func startGame() {
        engine.startGame()
    }

    func submitAnswer() {
        guard let answer = Int(answerText) else { return }
        engine.submitAnswer(answer)

        if engine.lastAnswerCorrect == true {
            showCelebration = true
            if let milestone = engine.streakMilestone {
                celebrationIntensity = milestone >= 15 ? .huge : .big
            } else {
                celebrationIntensity = .normal
            }
        } else {
            showShake = true
        }

        answerText = ""

        Task {
            try? await Task.sleep(for: .milliseconds(600))
            showCelebration = false
            showShake = false
        }
    }

    func appendDigit(_ digit: Int) {
        guard answerText.count < 6 else { return }
        answerText += "\(digit)"
    }

    func deleteDigit() {
        if !answerText.isEmpty {
            answerText.removeLast()
        }
    }

    func toggleNegative() {
        if answerText.hasPrefix("-") {
            answerText.removeFirst()
        } else {
            answerText = "-" + answerText
        }
    }

    func stopGame() {
        engine.stopGame()
    }
}
