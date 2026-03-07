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
}
