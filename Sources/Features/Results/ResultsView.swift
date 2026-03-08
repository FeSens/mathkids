import SwiftUI

struct ResultsView: View {
    @State var viewModel: ResultsViewModel
    var onPlayAgain: () -> Void
    var onGoHome: () -> Void
    @State private var bestScalePulse: Bool = false
    @State private var showHeader: Bool = false
    @State private var showStats: Bool = false
    @State private var showXP: Bool = false
    @State private var showButtons: Bool = false
    @State private var showConfetti: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            if showConfetti {
                ConfettiView()
            }

            VStack(spacing: 24) {
                Spacer()

                headerSection
                    .opacity(showHeader ? 1 : 0)
                    .offset(y: showHeader ? 0 : 20)

                StarRatingView(accuracy: viewModel.accuracy, show: showHeader)
                    .opacity(showHeader ? 1 : 0)

                scoreSection
                    .opacity(showHeader ? 1 : 0)

                if viewModel.bonusPoints > 0 {
                    HStack(spacing: 16) {
                        VStack(spacing: 2) {
                            Text("\(viewModel.basePoints)")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                            Text("Base")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        Text("+")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundStyle(.secondary)
                        VStack(spacing: 2) {
                            Text("\(viewModel.bonusPoints)")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                                .foregroundStyle(.cyan)
                            Text("Bonus")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .opacity(showStats ? 1 : 0)
                    .accessibilityIdentifier("scoreBreakdown")
                }

                statsGrid
                    .opacity(showStats ? 1 : 0)
                    .offset(y: showStats ? 0 : 20)

                xpSection
                    .opacity(showXP ? 1 : 0)
                    .offset(y: showXP ? 0 : 20)

                if !viewModel.problemHistory.isEmpty {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Recent Problems")
                            .font(.system(size: 14, weight: .bold, design: .rounded))
                            .foregroundStyle(.secondary)

                        ForEach(viewModel.problemHistory) { entry in
                            HStack {
                                Text(entry.problem.displayText)
                                    .font(.system(size: 14, design: .rounded))
                                Spacer()
                                Text("= \(entry.userAnswer)")
                                    .font(.system(size: 14, weight: .bold, design: .rounded))
                                    .foregroundStyle(entry.isCorrect ? .green : .red)
                                Image(systemName: entry.isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                                    .font(.system(size: 12))
                                    .foregroundStyle(entry.isCorrect ? .green : .red)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                    )
                    .opacity(showXP ? 1 : 0)
                    .accessibilityIdentifier("problemHistory")
                }

                Text(viewModel.encouragementMessage)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(.blue)
                    .opacity(showXP ? 1 : 0)
                    .accessibilityIdentifier("encouragementMessage")

                Text(viewModel.funFact)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
                    .italic()
                    .opacity(showButtons ? 1 : 0)
                    .accessibilityIdentifier("funFact")

                buttonsSection
                    .opacity(showButtons ? 1 : 0)
                    .offset(y: showButtons ? 0 : 20)

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
            withAnimation(.easeOut(duration: 0.4)) { showHeader = true }
            withAnimation(.easeOut(duration: 0.4).delay(0.3)) { showStats = true }
            withAnimation(.easeOut(duration: 0.4).delay(0.6)) { showXP = true }
            withAnimation(.easeOut(duration: 0.4).delay(0.9)) { showButtons = true }
            if viewModel.accuracy >= 80 {
                showConfetti = true
            }
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
                    .shadow(color: .yellow.opacity(bestScalePulse ? 0.6 : 0.2), radius: bestScalePulse ? 12 : 4)
                    .scaleEffect(bestScalePulse ? 1.1 : 0.95)
                    .animation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true), value: bestScalePulse)
                    .onAppear { bestScalePulse = true }
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

struct StarRatingView: View {
    let accuracy: Double
    let show: Bool
    @State private var animatedStars: Int = 0

    var starCount: Int {
        if accuracy >= 90 { return 5 }
        if accuracy >= 80 { return 4 }
        if accuracy >= 70 { return 3 }
        if accuracy >= 50 { return 2 }
        return 1
    }

    var body: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) { i in
                Image(systemName: i <= animatedStars ? "star.fill" : "star")
                    .font(.system(size: 24))
                    .foregroundStyle(i <= animatedStars ? .yellow : .gray.opacity(0.3))
                    .scaleEffect(i <= animatedStars ? 1.0 : 0.8)
                    .animation(.spring(duration: 0.3).delay(Double(i) * 0.1), value: animatedStars)
            }
        }
        .accessibilityIdentifier("starRating")
        .onChange(of: show) { _, newValue in
            if newValue {
                Task { @MainActor in
                    try? await Task.sleep(for: .milliseconds(300))
                    animatedStars = starCount
                }
            }
        }
    }
}
