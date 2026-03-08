import SwiftUI
import Observation

enum GameMode: Sendable {
    case timed
    case practice
    case dailyChallenge
}

@Observable
@MainActor
final class GameViewModel {
    private(set) var engine: GameEngine
    let mode: GameMode
    var answerText: String = ""
    var showCelebration: Bool = false
    var showShake: Bool = false
    var showCountdown: Bool
    var celebrationIntensity: CelebrationIntensity = .normal
    var scorePopups: [ScorePopup] = []
    var characterMood: CharacterMood = .neutral
    var motivationalMessage: String? = nil
    var answerHistory: [Bool] = []
    var problemTransitionId: UUID = UUID()
    var correctAnswerHint: Int? = nil
    var showSpeedBonus: Bool = false
    var problemNumber: Int = 1
    var isPaused: Bool = false
    var skippedCount: Int = 0
    var showSkipIndicator: Bool = false
    var lastProblemHistory: [AnsweredProblem] { engine.problemHistory }
    var hasStreakFreeze: Bool { engine.hasStreakFreeze }
    var elapsedSeconds: Int = 0
    private var elapsedTimer: Timer?
    private(set) var dailyChallengeProblemsTotal: Int = 10
    private(set) var dailyChallengeProblemsAnswered: Int = 0

    enum CelebrationIntensity {
        case normal
        case big
        case huge
    }

    enum CharacterMood {
        case neutral
        case happy
        case excited
        case sad
    }

    init(difficulty: DifficultyLevel, mode: GameMode = .timed, allowedOperations: Set<Operation>? = nil) {
        self.engine = GameEngine(difficulty: difficulty, allowedOperations: allowedOperations)
        self.mode = mode
        self.showCountdown = (mode == .timed)
    }

    var isDailyChallenge: Bool { mode == .dailyChallenge }

    var comboMultiplier: Int {
        let streak = engine.currentStreak
        if streak >= 10 { return 4 }
        if streak >= 5 { return 3 }
        if streak >= 3 { return 2 }
        return 1
    }

    var dailyChallengeProgress: String {
        "\(dailyChallengeProblemsAnswered)/\(dailyChallengeProblemsTotal)"
    }

    var problemText: String { engine.currentProblem.displayText }
    var score: Int { engine.score }
    var timeRemaining: Int { engine.timeRemaining }
    var timeProgress: Double { engine.timeProgress }
    var currentStreak: Int { engine.currentStreak }
    var isGameOver: Bool { engine.isGameOver }
    var session: GameSession { engine.session }
    var isPracticeMode: Bool { mode == .practice }

    func startGame() {
        if mode == .timed {
            engine.startGame()
        } else if mode == .dailyChallenge {
            // Count up timer for daily challenge
            elapsedTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
                Task { @MainActor in
                    self?.elapsedSeconds += 1
                }
            }
        }
        // Practice mode: no timer started
    }

    func countdownFinished() {
        showCountdown = false
        startGame()
        SoundService.playCountdownTick()
    }

    func submitAnswer() {
        guard let answer = Int(answerText) else { return }

        let correctAnswer = engine.currentProblem.correctAnswer
        let hadSpeedBonus = engine.timeRemaining > engine.difficulty.timeLimitSeconds / 2
        let previousScore = engine.score
        engine.submitAnswer(answer)
        let pointsEarned = engine.score - previousScore

        // Track answer history (last 5)
        answerHistory.append(engine.lastAnswerCorrect == true)
        if answerHistory.count > 5 {
            answerHistory.removeFirst()
        }

        correctAnswerHint = nil
        showSpeedBonus = false

        if engine.lastAnswerCorrect == true {
            showCelebration = true
            if hadSpeedBonus { showSpeedBonus = true }
            HapticService.correctAnswer()

            if let milestone = engine.streakMilestone {
                celebrationIntensity = milestone >= 15 ? .huge : .big
                characterMood = .excited
                HapticService.streakPattern(streak: milestone)
            } else {
                celebrationIntensity = .normal
                characterMood = engine.currentStreak >= 3 ? .excited : .happy
            }

            SoundService.playCelebration(intensity: celebrationIntensity)

            if engine.currentStreak >= 2 {
                motivationalMessage = Self.motivationalMessages.randomElement()
            }

            if pointsEarned > 0 {
                addScorePopup(points: pointsEarned)
            }
        } else {
            showShake = true
            characterMood = .sad
            correctAnswerHint = correctAnswer
            HapticService.wrongAnswer()
            SoundService.playWrong()
        }

        answerText = ""
        problemTransitionId = UUID()
        problemNumber += 1

        if mode == .dailyChallenge {
            dailyChallengeProblemsAnswered += 1
            if dailyChallengeProblemsAnswered >= dailyChallengeProblemsTotal {
                endDailyChallenge()
                return
            }
        }

        Task {
            try? await Task.sleep(for: .milliseconds(1500))
            showCelebration = false
            showShake = false
            characterMood = .neutral
            motivationalMessage = nil
            correctAnswerHint = nil
            showSpeedBonus = false
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

    func togglePause() {
        guard mode == .timed else { return }
        isPaused.toggle()
        if isPaused {
            engine.pauseTimer()
        } else {
            engine.resumeTimer()
        }
    }

    func skipProblem() {
        guard mode == .practice else { return }
        HapticService.buttonTap()
        answerText = ""
        problemTransitionId = UUID()
        problemNumber += 1
        skippedCount += 1
        showSkipIndicator = true
        engine.skipToNextProblem()
        Task {
            try? await Task.sleep(for: .milliseconds(1000))
            showSkipIndicator = false
        }
    }

    func shouldPlayTick(timeRemaining: Int) -> Bool {
        guard mode == .timed else { return false }
        return timeRemaining > 0 && timeRemaining <= 5
    }

    func clearAnswer() {
        if !answerText.isEmpty {
            HapticService.buttonTap()
            answerText = ""
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

    func endPractice() {
        SoundService.playGameOver(accuracy: engine.accuracy)
        HapticService.gameOver(accuracy: engine.accuracy)
        engine.stopGame()
    }

    func endDailyChallenge() {
        elapsedTimer?.invalidate()
        elapsedTimer = nil
        SoundService.playGameOver(accuracy: engine.accuracy)
        HapticService.gameOver(accuracy: engine.accuracy)
        engine.stopGame()
    }

    func stopGame() {
        elapsedTimer?.invalidate()
        elapsedTimer = nil
        SoundService.playGameOver(accuracy: engine.accuracy)
        HapticService.gameOver(accuracy: engine.accuracy)
        engine.stopGame()
    }

    private static let motivationalMessages = [
        "Awesome!", "On fire!", "Unstoppable!", "Math genius!",
        "Brilliant!", "Keep going!", "You rock!", "Amazing!",
        "Super star!", "Nailed it!"
    ]

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
