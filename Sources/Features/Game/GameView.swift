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
    @State private var cursorBlink: Bool = false

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

                // Fixed-height feedback area to prevent layout shifts
                ZStack {
                    // Answer history dots (always reserve space)
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
                }
                .frame(height: 20)

                // Hint display
                if let hintText = viewModel.currentHintText {
                    HStack(spacing: 8) {
                        Image(systemName: "lightbulb.fill")
                            .foregroundStyle(.yellow)
                        Text(hintText)
                            .font(.system(size: 15, weight: .medium, design: .rounded))
                            .foregroundStyle(.primary)
                        if viewModel.hasMoreHintSteps {
                            Button {
                                viewModel.requestHint()
                            } label: {
                                Text("Next")
                                    .font(.system(size: 13, weight: .bold, design: .rounded))
                                    .foregroundStyle(.blue)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.yellow.opacity(0.1))
                            .overlay(RoundedRectangle(cornerRadius: 12).stroke(Color.yellow.opacity(0.3), lineWidth: 1))
                    )
                    .transition(.scale.combined(with: .opacity))
                    .accessibilityIdentifier("hintDisplay")
                }

                // Overlay area for transient messages (no layout shift)
                ZStack {
                    if viewModel.showSkipIndicator {
                        Text("Skipped — no points")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(.orange)
                            .transition(.scale.combined(with: .opacity))
                            .accessibilityIdentifier("skipIndicator")
                    } else if viewModel.showSpeedBonus {
                        Text("+5 Speed Bonus!")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundStyle(.cyan)
                            .transition(.scale.combined(with: .opacity))
                            .accessibilityIdentifier("speedBonusLabel")
                    } else if let hint = viewModel.correctAnswerHint {
                        Text("Answer: \(hint)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.orange)
                            .transition(.scale.combined(with: .opacity))
                            .accessibilityIdentifier("correctAnswerHint")
                    } else if let milestone = viewModel.streakMilestoneMessage {
                        Text(milestone)
                            .font(.system(size: 28, weight: .black, design: .rounded))
                            .foregroundStyle(.orange)
                            .transition(.scale.combined(with: .opacity))
                            .accessibilityIdentifier("streakMilestone")
                    } else if let message = viewModel.motivationalMessage {
                        Text(message)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.green)
                            .transition(.scale.combined(with: .opacity))
                            .accessibilityIdentifier("motivationalMessage")
                    }
                }
                .frame(height: 32)
                .animation(.spring(duration: 0.3), value: viewModel.correctAnswerHint)
                .animation(.spring(duration: 0.3), value: viewModel.motivationalMessage != nil)

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
                Task { @MainActor in
                    try? await Task.sleep(for: .milliseconds(500))
                    onGameEnd(viewModel.session, viewModel.lastProblemHistory)
                }
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
        Text(viewModel.problemText)
            .font(.system(size: 64, weight: .bold, design: .rounded))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
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
        Text(viewModel.answerText.isEmpty ? "" : viewModel.answerText)
            .overlay(alignment: .trailing) {
                if viewModel.answerText.isEmpty {
                    Text("|").opacity(cursorBlink ? 1 : 0)
                        .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: cursorBlink)
                        .onAppear { cursorBlink = true }
                }
            }
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .foregroundStyle(viewModel.answerText.isEmpty ? .gray : .primary)
            .scaleEffect(answerScale)
            .animation(.spring(duration: 0.15, bounce: 0.5), value: viewModel.answerText)
            .onChange(of: viewModel.answerText) { _, _ in
                answerScale = 1.08
                Task { @MainActor in try? await Task.sleep(for: .milliseconds(100)); answerScale = 1.0 }
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(viewModel.answerFieldFlash?.opacity(0.15) ?? Color(.systemGray6))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(difficultyTextColor.opacity(0.3), lineWidth: 1.5))
                    .animation(.easeOut(duration: 0.3), value: viewModel.answerFieldFlash == nil)
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
                NumberButton(label: "+/-", color: .gray) { viewModel.toggleNegative() }
                    .accessibilityIdentifier("num_negative").accessibilityLabel("Toggle negative")
                NumberButton(label: "0") { viewModel.appendDigit(0) }
                    .accessibilityIdentifier("num_0").accessibilityLabel("Zero")
                NumberButton(label: "⌫", color: .gray) { viewModel.deleteDigit() }
                    .onLongPressGesture { viewModel.clearAnswer() }
                    .accessibilityIdentifier("num_delete").accessibilityLabel("Delete")
            }

            Button { viewModel.submitAnswer() } label: {
                Text("GO!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity).frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing))
                    )
            }
            .accessibilityIdentifier("submitButton")
            .buttonStyle(BounceButtonStyle())

            HStack(spacing: 24) {
                Button {
                    withAnimation(.spring(duration: 0.3)) {
                        viewModel.requestHint()
                    }
                } label: {
                    Label("Hint", systemImage: "lightbulb.fill")
                        .font(.system(size: 16, weight: .semibold, design: .rounded))
                        .foregroundStyle(.yellow)
                }
                .accessibilityIdentifier("hintButton")

                if viewModel.isPracticeMode {
                    Button { viewModel.skipProblem() } label: {
                        Text("Skip").font(.system(size: 16, weight: .semibold, design: .rounded)).foregroundStyle(.secondary)
                    }.accessibilityIdentifier("skipButton")
                }
            }
        }
    }
}

