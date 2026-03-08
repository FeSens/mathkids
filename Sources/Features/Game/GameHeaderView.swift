import SwiftUI

struct GameHeaderView: View {
    @Bindable var viewModel: GameViewModel
    @Binding var timerPulse: Bool
    @State private var scoreScale: Double = 1.0
    @State private var streakScale: Double = 1.0

    var body: some View {
        VStack(spacing: 6) {
            // Row 1: Score, problem counter, difficulty, spacer, timer/controls
            HStack(spacing: 8) {
                Label("\(viewModel.score)", systemImage: "star.fill")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.yellow)
                    .scaleEffect(scoreScale)
                    .onChange(of: viewModel.score) { _, _ in
                        withAnimation(.spring(duration: 0.3, bounce: 0.5)) { scoreScale = 1.2 }
                        withAnimation(.spring(duration: 0.3).delay(0.15)) { scoreScale = 1.0 }
                    }
                    .accessibilityIdentifier("scoreLabel")

                Text("#\(viewModel.problemNumber)")
                    .font(.system(size: 13, weight: .semibold, design: .rounded))
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Capsule().fill(Color(.systemGray5)))
                    .accessibilityIdentifier("problemCounter")

                Text(viewModel.engine.difficulty.displayName)
                    .font(.system(size: 11, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(Capsule().fill(difficultyColor))
                    .accessibilityIdentifier("difficultyLabel")

                Spacer()

                if viewModel.isPracticeMode {
                    practiceControls
                } else if viewModel.isDailyChallenge {
                    dailyChallengeControls
                } else {
                    timedControls
                }
            }

            // Row 2: Accuracy, streak, combo (only when there's data)
            if viewModel.engine.totalAnswered > 0 {
                HStack(spacing: 12) {
                    Text("\(viewModel.engine.totalCorrect)/\(viewModel.engine.totalAnswered)")
                        .font(.system(size: 12, weight: .semibold, design: .rounded))
                        .foregroundStyle(.green)

                    Text("\(Int(viewModel.engine.accuracy))%")
                        .font(.system(size: 12, weight: .bold, design: .rounded))
                        .foregroundStyle(viewModel.engine.accuracy >= 70 ? .green : viewModel.engine.accuracy >= 50 ? .orange : .red)
                        .accessibilityIdentifier("sessionAccuracy")

                    Spacer()

                    if viewModel.comboMultiplier > 1 {
                        Text("\(viewModel.comboMultiplier)x")
                            .font(.system(size: 14, weight: .black, design: .rounded))
                            .foregroundStyle(.purple)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(Capsule().fill(.purple.opacity(0.15)))
                            .accessibilityIdentifier("comboMultiplier")
                    }

                    if viewModel.hasStreakFreeze {
                        Image(systemName: "shield.fill")
                            .font(.system(size: 14))
                            .foregroundStyle(.cyan)
                            .accessibilityIdentifier("streakFreezeIndicator")
                    }

                    if viewModel.currentStreak > 0 {
                        HStack(spacing: 2) {
                            Image(systemName: "flame.fill")
                                .font(.system(size: 14))
                                .foregroundStyle(.orange)
                            Text("\(viewModel.currentStreak)")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(.orange)
                        }
                        .scaleEffect(streakScale)
                        .onChange(of: viewModel.currentStreak) { _, _ in
                            withAnimation(.spring(duration: 0.2, bounce: 0.6)) { streakScale = 1.2 }
                            withAnimation(.spring(duration: 0.2).delay(0.15)) { streakScale = 1.0 }
                        }
                        .accessibilityIdentifier("streakLabel")
                    }
                }
                .font(.system(size: 12, design: .rounded))
            }
        }
    }

    private var practiceControls: some View {
        HStack(spacing: 8) {
            Text("Solved: \(viewModel.engine.totalAnswered)")
                .font(.system(size: 14, weight: .semibold, design: .rounded))
                .foregroundStyle(.blue)
                .accessibilityIdentifier("practiceSolvedCount")

            Button {
                viewModel.endPractice()
            } label: {
                Label("Done", systemImage: "checkmark.circle.fill")
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .foregroundStyle(.green)
            }
            .accessibilityIdentifier("doneButton")
        }
    }

    private var dailyChallengeControls: some View {
        HStack(spacing: 8) {
            Label("\(viewModel.elapsedSeconds)s", systemImage: "stopwatch")
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.blue)
                .accessibilityIdentifier("elapsedTimerLabel")

            Text(viewModel.dailyChallengeProgress)
                .font(.system(size: 16, weight: .bold, design: .rounded))
                .foregroundStyle(.purple)
                .accessibilityIdentifier("dailyProgressLabel")
        }
    }

    private var timedControls: some View {
        HStack(spacing: 8) {
            TimerRingView(
                progress: viewModel.timeProgress,
                timeRemaining: viewModel.timeRemaining,
                isPulsing: timerPulse
            )
            .frame(width: 44, height: 44)
            .onChange(of: viewModel.timeRemaining) { _, newValue in
                timerPulse = newValue <= 10
            }
            .accessibilityIdentifier("timerLabel")

            Button {
                viewModel.togglePause()
            } label: {
                Image(systemName: viewModel.isPaused ? "play.fill" : "pause.fill")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.secondary)
            }
            .accessibilityIdentifier("pauseButton")
        }
    }

    private var difficultyColor: Color {
        switch viewModel.engine.difficulty {
        case .easy: .green; case .medium: .orange; case .hard: .red
        }
    }
}
