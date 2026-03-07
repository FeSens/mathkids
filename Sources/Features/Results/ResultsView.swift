import SwiftUI

struct ResultsView: View {
    @State var viewModel: ResultsViewModel
    var onPlayAgain: () -> Void
    var onGoHome: () -> Void

    var body: some View {
        ZStack(alignment: .top) {
            VStack(spacing: 24) {
                Spacer()

                headerSection

                scoreSection

                statsGrid

                xpSection

                buttonsSection

                Spacer()
            }
            .padding()

            VStack(spacing: 8) {
                ForEach(viewModel.newAchievements) { achievement in
                    AchievementToast(achievement: achievement)
                }
            }
            .padding(.top, 20)
        }
        .onAppear {
            viewModel.animateScore()
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Text(headerEmoji)
                .font(.system(size: 64))

            Text(headerText)
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .multilineTextAlignment(.center)

            if viewModel.isNewBestScore {
                Text("NEW BEST SCORE!")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.yellow)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(
                        Capsule().fill(.yellow.opacity(0.2))
                    )
                    .accessibilityIdentifier("newBestBadge")
            }
        }
    }

    private var headerEmoji: String {
        if viewModel.accuracy >= 90 { return "🏆" }
        if viewModel.accuracy >= 70 { return "🌟" }
        if viewModel.accuracy >= 50 { return "👍" }
        return "💪"
    }

    private var headerText: String {
        if viewModel.accuracy >= 90 { return "Amazing!" }
        if viewModel.accuracy >= 70 { return "Great Job!" }
        if viewModel.accuracy >= 50 { return "Nice Try!" }
        return "Keep Practicing!"
    }

    private var scoreSection: some View {
        VStack(spacing: 4) {
            Text("\(viewModel.animatedScore)")
                .font(.system(size: 72, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .accessibilityIdentifier("finalScore")

            Text("points")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var statsGrid: some View {
        HStack(spacing: 16) {
            ResultStat(
                label: "Correct",
                value: "\(viewModel.totalCorrect)/\(viewModel.totalAnswered)",
                icon: "checkmark.circle.fill",
                color: .green
            )
            .accessibilityIdentifier("correctStat")

            ResultStat(
                label: "Accuracy",
                value: "\(Int(viewModel.accuracy))%",
                icon: "target",
                color: .blue
            )
            .accessibilityIdentifier("accuracyStat")

            ResultStat(
                label: "Best Streak",
                value: "\(viewModel.bestStreak)",
                icon: "flame.fill",
                color: .orange
            )
            .accessibilityIdentifier("streakStat")
        }
    }

    private var xpSection: some View {
        VStack(spacing: 8) {
            HStack(spacing: 6) {
                Image(systemName: "sparkles")
                    .foregroundStyle(.purple)
                Text("+\(viewModel.xpEarned) XP")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundStyle(.purple)
            }
            .accessibilityIdentifier("xpEarned")

            if viewModel.didLevelUp {
                HStack(spacing: 6) {
                    Image(systemName: "arrow.up.circle.fill")
                        .foregroundStyle(.yellow)
                    Text("Level Up! \(LevelSystem.levelNames[viewModel.newLevel - 1])")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.yellow)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule().fill(.yellow.opacity(0.2))
                )
                .accessibilityIdentifier("levelUpBadge")
            }
        }
    }

    private var buttonsSection: some View {
        VStack(spacing: 12) {
            Button {
                onPlayAgain()
            } label: {
                Text("Play Again")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(
                        RoundedRectangle(cornerRadius: 18)
                            .fill(
                                LinearGradient(
                                    colors: [.blue, .purple],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
            }
            .accessibilityIdentifier("playAgainButton")

            Button {
                onGoHome()
            } label: {
                Text("Home")
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
            }
            .accessibilityIdentifier("homeButton")
        }
        .padding(.horizontal)
    }
}

struct ResultStat: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundStyle(color)

            Text(value)
                .font(.system(size: 20, weight: .bold, design: .rounded))

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(color.opacity(0.1))
        )
    }
}
