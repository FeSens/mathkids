import SwiftUI

struct GameHeaderView: View {
    @Bindable var viewModel: GameViewModel
    @Binding var timerPulse: Bool
    @State private var scoreScale: Double = 1.0
    @State private var streakScale: Double = 1.0

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

                ZStack {
                    Circle()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 3)
                        .frame(width: 36, height: 36)
                    Circle()
                        .trim(from: 0, to: viewModel.problemGoalProgress)
                        .stroke(Color.blue, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                        .frame(width: 36, height: 36)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 0.3), value: viewModel.problemGoalProgress)
                    VStack(spacing: 0) {
                        Text("#\(viewModel.problemNumber)")
                            .font(.system(size: 11, weight: .semibold, design: .rounded))
                            .foregroundStyle(.secondary)
                    }
                }
                .accessibilityIdentifier("problemCounter")

                if viewModel.engine.totalAnswered > 0 {
                    Text("\(viewModel.engine.totalCorrect)/\(viewModel.engine.totalAnswered)")
                        .font(.system(size: 10, weight: .medium, design: .rounded))
                        .foregroundStyle(.green)
                }

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

                if viewModel.engine.totalAnswered > 0 {
                    Text("\(Int(viewModel.engine.accuracy))%")
                        .font(.system(size: 14, weight: .bold, design: .rounded))
                        .foregroundStyle(viewModel.engine.accuracy >= 70 ? .green : viewModel.engine.accuracy >= 50 ? .orange : .red)
                        .accessibilityIdentifier("sessionAccuracy")
                        .accessibilityLabel("Session accuracy: \(Int(viewModel.engine.accuracy)) percent")
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
                            .scaleEffect(streakScale)
                            .onChange(of: viewModel.currentStreak) { _, _ in
                                withAnimation(.spring(duration: 0.2, bounce: 0.6)) {
                                    streakScale = 1.3
                                }
                                withAnimation(.spring(duration: 0.2).delay(0.15)) {
                                    streakScale = 1.0
                                }
                            }
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
