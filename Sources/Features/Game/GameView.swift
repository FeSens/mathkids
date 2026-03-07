import SwiftUI

struct GameView: View {
    @State var viewModel: GameViewModel
    var onGameEnd: (GameSession) -> Void
    @State private var timerPulse: Bool = false

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                headerBar

                Spacer()

                CharacterView(mood: viewModel.characterMood)

                ZStack {
                    problemDisplay

                    ForEach(viewModel.scorePopups) { popup in
                        ScorePopupView(popup: popup)
                    }
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
                onGameEnd(viewModel.session)
            }
        }
    }

    private var headerBar: some View {
        VStack(spacing: 8) {
            HStack {
                Label("\(viewModel.score)", systemImage: "star.fill")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.yellow)
                    .accessibilityIdentifier("scoreLabel")

                Text("#\(viewModel.problemNumber)")
                    .font(.system(size: 14, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
                    .accessibilityIdentifier("problemCounter")

                Spacer()

                if viewModel.comboMultiplier > 1 {
                    Text("\(viewModel.comboMultiplier)x")
                        .font(.system(size: 18, weight: .black, design: .rounded))
                        .foregroundStyle(.purple)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(Capsule().fill(.purple.opacity(0.15)))
                        .scaleEffect(1.0 + Double(viewModel.comboMultiplier) * 0.05)
                        .animation(.spring(duration: 0.3), value: viewModel.comboMultiplier)
                        .accessibilityIdentifier("comboMultiplier")
                }

                if viewModel.currentStreak > 0 {
                    HStack(spacing: 2) {
                        Label("\(viewModel.currentStreak)", systemImage: "flame.fill")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.orange)
                            .accessibilityIdentifier("streakLabel")

                        ForEach(0..<streakFlameCount, id: \.self) { i in
                            Text("🔥")
                                .font(.system(size: CGFloat(12 + min(viewModel.currentStreak, 10))))
                                .scaleEffect(1.0 + Double(i) * 0.1)
                                .animation(.spring(duration: 0.3).delay(Double(i) * 0.05), value: viewModel.currentStreak)
                        }
                    }
                }

                Spacer()

                if viewModel.isPracticeMode {
                    Button {
                        viewModel.endPractice()
                    } label: {
                        Label("Done", systemImage: "checkmark.circle.fill")
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.green)
                    }
                    .accessibilityIdentifier("doneButton")
                } else if viewModel.isDailyChallenge {
                    HStack(spacing: 12) {
                        Label("\(viewModel.elapsedSeconds)s", systemImage: "stopwatch")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.blue)
                            .accessibilityIdentifier("elapsedTimerLabel")

                        Text(viewModel.dailyChallengeProgress)
                            .font(.system(size: 18, weight: .bold, design: .rounded))
                            .foregroundStyle(.purple)
                            .accessibilityIdentifier("dailyProgressLabel")
                    }
                } else {
                    Label("\(viewModel.timeRemaining)s", systemImage: "timer")
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .foregroundStyle(viewModel.timeRemaining <= 10 ? .red : .primary)
                        .scaleEffect(viewModel.timeRemaining <= 10 && timerPulse ? 1.15 : 1.0)
                        .animation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true), value: timerPulse)
                        .onChange(of: viewModel.timeRemaining) { _, newValue in
                            timerPulse = newValue <= 10
                        }
                        .accessibilityIdentifier("timerLabel")
                }
            }

            if !viewModel.isPracticeMode && !viewModel.isDailyChallenge {
                GeometryReader { geo in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: timerColors,
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * viewModel.timeProgress)
                        .animation(.linear(duration: 1), value: viewModel.timeProgress)
                }
                .frame(height: 8)
                .background(Color.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 4))
                .accessibilityIdentifier("timerBar")
            }
        }
    }

    private var streakFlameCount: Int {
        let streak = viewModel.currentStreak
        if streak >= 10 { return 4 }
        if streak >= 5 { return 3 }
        if streak >= 3 { return 2 }
        return 1
    }

    private var timerColors: [Color] {
        if viewModel.timeProgress > 0.5 {
            return [.green, .blue]
        } else if viewModel.timeProgress > 0.25 {
            return [.yellow, .orange]
        } else {
            return [.orange, .red]
        }
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

            Circle()
                .fill(problemDifficultyColor)
                .frame(width: 10, height: 10)
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

    private var operationBadgeSymbol: String {
        switch viewModel.engine.currentProblem.operation {
        case .add: "+"
        case .subtract: "-"
        case .multiply: "x"
        case .divide: "/"
        }
    }

    private var difficultyTextColor: Color {
        switch viewModel.engine.difficulty {
        case .easy: Color(red: 0.15, green: 0.4, blue: 0.15)
        case .medium: Color(red: 0.5, green: 0.3, blue: 0.05)
        case .hard: Color(red: 0.5, green: 0.1, blue: 0.1)
        }
    }

    private var operationBadgeColor: Color {
        switch viewModel.engine.currentProblem.operation {
        case .add: .green
        case .subtract: .blue
        case .multiply: .orange
        case .divide: .purple
        }
    }

    private var problemDifficultyColor: Color {
        switch viewModel.engine.currentProblem.problemDifficulty {
        case .easy: .green
        case .moderate: .yellow
        case .hard: .red
        }
    }

    private var answerDisplay: some View {
        Text(viewModel.answerText.isEmpty ? "?" : viewModel.answerText)
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .foregroundStyle(viewModel.answerText.isEmpty ? .gray : .primary)
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
            )
            .accessibilityIdentifier("answerField")
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

                NumberButton(label: "0") {
                    viewModel.appendDigit(0)
                }
                .accessibilityIdentifier("num_0")

                NumberButton(label: "⌫", color: .gray) {
                    viewModel.deleteDigit()
                }
                .accessibilityIdentifier("num_delete")
            }

            Button {
                viewModel.submitAnswer()
            } label: {
                Text("GO!")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
            }
            .accessibilityIdentifier("submitButton")
            .buttonStyle(BounceButtonStyle())
        }
    }
}

struct NumberButton: View {
    let label: String
    var color: Color = .blue
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(color.opacity(0.15))
                )
        }
        .buttonStyle(BounceButtonStyle())
    }
}

struct BounceButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.92 : 1.0)
            .brightness(configuration.isPressed ? 0.1 : 0)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white.opacity(configuration.isPressed ? 0.2 : 0))
            )
            .animation(.spring(duration: 0.2, bounce: 0.4), value: configuration.isPressed)
    }
}
