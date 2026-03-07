import SwiftUI
import Observation

@Observable
@MainActor
final class GameViewModel {
    private(set) var engine: GameEngine
    var answerText: String = ""
    var showCelebration: Bool = false
    var showShake: Bool = false
    var showCountdown: Bool = true
    var celebrationIntensity: CelebrationIntensity = .normal
    var scorePopups: [ScorePopup] = []

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

    func countdownFinished() {
        showCountdown = false
        startGame()
    }

    func submitAnswer() {
        guard let answer = Int(answerText) else { return }

        let previousScore = engine.score
        engine.submitAnswer(answer)
        let pointsEarned = engine.score - previousScore

        if engine.lastAnswerCorrect == true {
            showCelebration = true
            HapticService.correctAnswer()

            if let milestone = engine.streakMilestone {
                celebrationIntensity = milestone >= 15 ? .huge : .big
                HapticService.streakMilestone()
            } else {
                celebrationIntensity = .normal
            }

            if pointsEarned > 0 {
                addScorePopup(points: pointsEarned)
            }
        } else {
            showShake = true
            HapticService.wrongAnswer()
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
        HapticService.buttonTap()
        answerText += "\(digit)"
    }

    func deleteDigit() {
        if !answerText.isEmpty {
            HapticService.buttonTap()
            answerText.removeLast()
        }
    }

    func toggleNegative() {
        HapticService.buttonTap()
        if answerText.hasPrefix("-") {
            answerText.removeFirst()
        } else {
            answerText = "-" + answerText
        }
    }

    func stopGame() {
        engine.stopGame()
    }

    private func addScorePopup(points: Int) {
        let popup = ScorePopup(text: "+\(points)", color: .green)
        scorePopups.append(popup)
        let popupId = popup.id

        Task {
            try? await Task.sleep(for: .milliseconds(50))
            if let idx = scorePopups.firstIndex(where: { $0.id == popupId }) {
                withAnimation(.easeOut(duration: 0.8)) {
                    scorePopups[idx].offset = -80
                    scorePopups[idx].opacity = 0
                }
            }

            try? await Task.sleep(for: .milliseconds(900))
            scorePopups.removeAll { $0.id == popupId }
        }
    }
}
