import SwiftUI

struct GameHeaderView: View {
    @Bindable var viewModel: GameViewModel
    @Binding var timerPulse: Bool
    @State private var scoreScale: Double = 1.0

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Label("\(viewModel.score)", systemImage: "star.fill")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.yellow)
                    .scaleEffect(scoreScale)
                    .onChange(of: viewModel.score) { _, _ in
                        withAnimation(.spring(duration: 0.3, bounce: 0.5)) {
                            scoreScale = 1.2
                        }
                        withAnimation(.spring(duration: 0.3).delay(0.15)) {
                            scoreScale = 1.0
                        }
                    }
                    .accessibilityIdentifier("scoreLabel")
                    .accessibilityLabel("Score: \(viewModel.score) points")

                VStack(spacing: 1) {
                    Text("#\(viewModel.problemNumber)")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                        .foregroundStyle(.secondary)
                    if viewModel.engine.totalAnswered > 0 {
                        Text("\(viewModel.engine.totalCorrect)/\(viewModel.engine.totalAnswered)")
                            .font(.system(size: 10, weight: .medium, design: .rounded))
                            .foregroundStyle(.green)
                    }
                }
                .accessibilityIdentifier("problemCounter")

                Spacer()

                if viewModel.comboMultiplier > 1 {
                    HStack(spacing: 4) {
                        Text("\(viewModel.comboMultiplier)x")
                            .font(.system(size: 18, weight: .black, design: .rounded))
                            .foregroundStyle(.purple)

                        if viewModel.comboMultiplier >= 3 {
                            Text("2x XP")
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Capsule().fill(.orange))
                                .accessibilityIdentifier("doubleXPBadge")
                        }
                    }
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Capsule().fill(.purple.opacity(0.15)))
                    .scaleEffect(1.0 + Double(viewModel.comboMultiplier) * 0.05)
                    .animation(.spring(duration: 0.3), value: viewModel.comboMultiplier)
                    .accessibilityIdentifier("comboMultiplier")
                }

                if viewModel.hasStreakFreeze {
                    Image(systemName: "shield.fill")
                        .font(.system(size: 16))
                        .foregroundStyle(.cyan)
                        .accessibilityIdentifier("streakFreezeIndicator")
                        .accessibilityLabel("Streak freeze active")
                }

                if viewModel.currentStreak > 0 {
                    HStack(spacing: 2) {
                        Label("\(viewModel.currentStreak)", systemImage: "flame.fill")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundStyle(.orange)
                            .accessibilityIdentifier("streakLabel")
                            .accessibilityLabel("Streak: \(viewModel.currentStreak) correct in a row")

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
                    TimerRingView(
                        progress: viewModel.timeProgress,
                        timeRemaining: viewModel.timeRemaining,
                        isPulsing: timerPulse
                    )
                    .frame(width: 48, height: 48)
                    .onChange(of: viewModel.timeRemaining) { _, newValue in
                        timerPulse = newValue <= 10
                    }
                    .accessibilityIdentifier("timerLabel")
                    .accessibilityLabel("\(viewModel.timeRemaining) seconds remaining")

                    Button {
                        viewModel.togglePause()
                    } label: {
                        Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundStyle(.secondary)
                    }
                    .accessibilityIdentifier("pauseButton")
                }
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
}
