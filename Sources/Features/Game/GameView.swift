import SwiftUI

struct GameView: View {
    @State var viewModel: GameViewModel
    var onGameEnd: (GameSession, [AnsweredProblem]) -> Void
    @State private var timerPulse: Bool = false
    @State private var answerScale: CGFloat = 1.0
    @State private var urgentFlash: Bool = false
    @State private var reactionEmoji: String? = nil
    @State private var emojiOffset: CGFloat = 0
    @State private var emojiOpacity: Double = 1
    @State private var gradientShift: Bool = false

    var body: some View {
        ZStack {
            ZStack {
                difficultyTintColor
                streakBackgroundColor
            }
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.5), value: viewModel.currentStreak)

            if urgentFlash {
                Color.red.opacity(0.05)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: urgentFlash)
                    .accessibilityIdentifier("urgentFlash")
            }

            VStack(spacing: 16) {
                GameHeaderView(viewModel: viewModel, timerPulse: $timerPulse)

                Spacer()

                CharacterView(mood: viewModel.characterMood)

                if viewModel.isPaused {
                    PauseOverlay { viewModel.togglePause() }
                } else {
                    ZStack {
                        problemDisplay

                        ForEach(viewModel.scorePopups) { popup in
                            ScorePopupView(popup: popup)
                        }

                        if viewModel.showCelebration {
                            MiniParticleBurst(color: operationBadgeColor)
                                .allowsHitTesting(false)
                        }
                    }
                }

                if viewModel.showSkipIndicator {
                    Text("Skipped — no points")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.orange)
                        .transition(.scale.combined(with: .opacity))
                        .accessibilityIdentifier("skipIndicator")
                }

                if viewModel.showSpeedBonus {
                    Text("+5 Speed Bonus!")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.cyan)
                        .transition(.scale.combined(with: .opacity))
                        .accessibilityIdentifier("speedBonusLabel")
                }

                if let hint = viewModel.correctAnswerHint {
                    Text("Answer: \(hint)")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(.orange)
                        .transition(.scale.combined(with: .opacity))
                        .animation(.spring(duration: 0.3), value: viewModel.correctAnswerHint)
                        .accessibilityIdentifier("correctAnswerHint")
                }

                if !viewModel.answerHistory.isEmpty {
                    HStack(spacing: 6) {
                        ForEach(Array(viewModel.answerHistory.enumerated()), id: \.offset) { _, correct in
                            Image(systemName: correct ? "checkmark.circle.fill" : "xmark.circle.fill")
                                .font(.system(size: 16))
                                .foregroundStyle(correct ? .green : .red)
                        }
                    }
                    .animation(.spring(duration: 0.3), value: viewModel.answerHistory.count)
                    .accessibilityIdentifier("answerHistory")
                }

                if let emoji = reactionEmoji {
                    Text(emoji).font(.system(size: 36)).offset(y: emojiOffset).opacity(emojiOpacity).accessibilityIdentifier("reactionEmoji")
                }

                if let milestone = viewModel.streakMilestoneMessage {
                    Text(milestone)
                        .font(.system(size: 28, weight: .black, design: .rounded))
                        .foregroundStyle(.orange)
                        .transition(.scale.combined(with: .opacity))
                        .accessibilityIdentifier("streakMilestone")
                }

                if let message = viewModel.motivationalMessage {
                    Text(message)
                        .font(.system(size: 18, weight: .bold, design: .rounded))
                        .foregroundStyle(.green)
                        .transition(.scale.combined(with: .opacity))
                        .accessibilityIdentifier("motivationalMessage")
                }

                answerDisplay

                Spacer()

                numberPad
                    .modifier(ShakeEffect(shakes: viewModel.showShake ? 2 : 0))
                    .animation(.default, value: viewModel.showShake)
            }
            .padding()
            .opacity(viewModel.showCountdown ? 0.3 : 1.0)

            if viewModel.showCelebration {
                CelebrationView(intensity: viewModel.celebrationIntensity, difficulty: viewModel.engine.difficulty)
                    .allowsHitTesting(false)
            }

            if viewModel.showCountdown {
                CountdownView {
                    viewModel.countdownFinished()
                }
            }
        }
        .onChange(of: viewModel.isGameOver) { _, isOver in
            if isOver {
                urgentFlash = false
                onGameEnd(viewModel.session, viewModel.lastProblemHistory)
            }
        }
        .onChange(of: viewModel.problemTransitionId) { _, _ in
            showReactionEmoji(correct: viewModel.engine.lastAnswerCorrect == true)
        }
        .onChange(of: viewModel.timeRemaining) { _, newValue in
            urgentFlash = newValue <= 5 && newValue > 0 && !viewModel.isPracticeMode
            if viewModel.shouldPlayTick(timeRemaining: newValue) {
                SoundService.playCountdownTick()
                HapticService.timerTick()
            }
        }
    }

    private func showReactionEmoji(correct: Bool) {
        reactionEmoji = correct ? ["🎉", "✨", "🌟", "💫", "🎯"].randomElement() : "😔"
        emojiOffset = 0; emojiOpacity = 1
        withAnimation(.easeOut(duration: 0.8)) { emojiOffset = -60; emojiOpacity = 0 }
        Task { @MainActor in try? await Task.sleep(for: .milliseconds(900)); reactionEmoji = nil }
    }

    private var problemDisplay: some View {
        HStack(spacing: 8) {
            Text(viewModel.problemText)
                .font(.system(size: 64, weight: .bold, design: .rounded))
                .foregroundStyle(difficultyTextColor)
                .modifier(ShakeEffect(shakes: viewModel.showShake ? 4 : 0))
                .animation(.default, value: viewModel.showShake)
                .id(viewModel.problemTransitionId)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))
                .animation(.spring(duration: 0.3), value: viewModel.problemTransitionId)
                .accessibilityIdentifier("problemLabel")
                .accessibilityLabel("\(viewModel.engine.currentProblem.operand1) \(viewModel.engine.currentProblem.operation.accessibilityName) \(viewModel.engine.currentProblem.operand2)")

            VStack(spacing: 2) {
                Circle()
                    .fill(problemDifficultyColor)
                    .frame(width: 10, height: 10)
                Text(problemDifficultyLabel)
                    .font(.system(size: 9, weight: .bold, design: .rounded))
                    .foregroundStyle(problemDifficultyColor)
            }
            .offset(y: -20)
            .accessibilityIdentifier("difficultyDot")

            Text(operationBadgeSymbol)
                .font(.system(size: 14, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .frame(width: 28, height: 28)
                .background(Circle().fill(operationBadgeColor))
                .offset(y: -20)
                .accessibilityIdentifier("operationBadge")
        }
    }

    private var streakBackgroundColor: Color { let s = viewModel.currentStreak; return s >= 10 ? Color.orange.opacity(0.06) : s >= 5 ? Color.yellow.opacity(0.04) : .clear }
    private var operationBadgeSymbol: String { viewModel.engine.currentProblem.operation.rawValue }

    private var difficultyTextColor: Color {
        switch viewModel.engine.difficulty {
        case .easy: Color(red: 0.15, green: 0.4, blue: 0.15); case .medium: Color(red: 0.5, green: 0.3, blue: 0.05); case .hard: Color(red: 0.5, green: 0.1, blue: 0.1)
        }
    }
    private var operationBadgeColor: Color {
        switch viewModel.engine.currentProblem.operation {
        case .add: .green; case .subtract: .blue; case .multiply: .orange; case .divide: .purple
        }
    }
    private var problemDifficultyLabel: String {
        switch viewModel.engine.currentProblem.problemDifficulty { case .easy: "Easy"; case .moderate: "Med"; case .hard: "Hard" }
    }
    private var problemDifficultyColor: Color {
        switch viewModel.engine.currentProblem.problemDifficulty { case .easy: .green; case .moderate: .yellow; case .hard: .red }
    }

    private var answerDisplay: some View {
        Text(viewModel.answerText.isEmpty ? "?" : viewModel.answerText)
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .foregroundStyle(viewModel.answerText.isEmpty ? .gray : .primary)
            .scaleEffect(answerScale)
            .animation(.spring(duration: 0.15, bounce: 0.5), value: viewModel.answerText)
            .onChange(of: viewModel.answerText) { _, _ in
                answerScale = 1.08
                Task { @MainActor in try? await Task.sleep(for: .milliseconds(100)); answerScale = 1.0 }
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(difficultyTextColor.opacity(0.3), lineWidth: 1.5))
            )
            .accessibilityIdentifier("answerField")
    }

    private var difficultyTintColor: Color {
        switch viewModel.engine.difficulty {
        case .easy: .green.opacity(0.03); case .medium: .orange.opacity(0.03); case .hard: .red.opacity(0.03)
        }
    }

    private var numberPad: some View {
        VStack(spacing: 12) {
            ForEach(0..<3) { row in
                HStack(spacing: 12) {
                    ForEach(1...3, id: \.self) { col in
                        let digit = row * 3 + col
                        NumberButton(label: "\(digit)") {
                            viewModel.appendDigit(digit)
                        }
                        .accessibilityIdentifier("num_\(digit)")
                    }
                }
            }
            HStack(spacing: 12) {
                NumberButton(label: "+/-", color: .gray) {
                    viewModel.toggleNegative()
                }
                .accessibilityIdentifier("num_negative")
                .accessibilityLabel("Toggle negative")

                NumberButton(label: "0") {
                    viewModel.appendDigit(0)
                }
                .accessibilityIdentifier("num_0")
                .accessibilityLabel("Zero")

                NumberButton(label: "⌫", color: .gray) {
                    viewModel.deleteDigit()
                }
                .accessibilityIdentifier("num_delete")
                .accessibilityLabel("Delete")
            }

            Button { viewModel.submitAnswer() } label: {
                Text("GO!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity).frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 16).fill(LinearGradient(colors: gradientShift ? [.purple, .blue] : [.blue, .purple], startPoint: .leading, endPoint: .trailing)))
                    .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: gradientShift)
                    .onAppear { gradientShift = true }
            }
            .accessibilityIdentifier("submitButton")
            .buttonStyle(BounceButtonStyle())

            if viewModel.isPracticeMode {
                Button {
                    viewModel.skipProblem()
                } label: {
                    Text("Skip")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundStyle(.secondary)
                }
                .accessibilityIdentifier("skipButton")
            }
        }
    }
}

