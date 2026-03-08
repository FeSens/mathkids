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
    @State private var emojiFloat: Bool = false
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @State private var showConfetti: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            if showConfetti && !reduceMotion {
                ConfettiView()
            }

            ScrollView {
            VStack(spacing: 24) {
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
                    if !viewModel.operationBreakdown.isEmpty {
                        OperationBreakdownView(breakdown: viewModel.operationBreakdown)
                            .opacity(showXP ? 1 : 0)
                    }
                    // Per-operation accuracy bars
                    if !viewModel.operationAccuracyBreakdown.isEmpty {
                        OperationAccuracyBars(breakdown: viewModel.operationAccuracyBreakdown)
                            .opacity(showXP ? 1 : 0)
                    }

                    // Elo rating changes
                    if !viewModel.eloDeltas.isEmpty {
                        EloDeltaView(deltas: viewModel.eloDeltas)
                            .opacity(showXP ? 1 : 0)
                    }

                    // Speed breakdown per operation
                    if !viewModel.averageTimePerOperation.isEmpty {
                        SpeedBreakdownView(times: viewModel.averageTimePerOperation, slowest: viewModel.slowestOperationThisGame)
                            .opacity(showXP ? 1 : 0)
                    }

                    // Practice recommendation
                    if let recommendation = viewModel.practiceRecommendationText {
                        HStack(spacing: 8) {
                            Image(systemName: "target")
                                .foregroundStyle(.red)
                            Text(recommendation)
                                .font(.system(size: 14, weight: .semibold, design: .rounded))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.red.opacity(0.08))
                        )
                        .opacity(showXP ? 1 : 0)
                        .accessibilityIdentifier("practiceRecommendation")
                    }

                    ProblemHistorySection(problemHistory: viewModel.problemHistory)
                        .opacity(showXP ? 1 : 0)
                }

                if viewModel.previousBestScore > 0 {
                    ScoreComparisonView(scoreImprovement: viewModel.scoreImprovement)
                        .opacity(showXP ? 1 : 0)
                }

                if let comparisonText = viewModel.accuracyComparisonText {
                    AccuracyComparisonView(accuracyVsAverage: viewModel.accuracyVsAverage, comparisonText: comparisonText)
                        .opacity(showXP ? 1 : 0)
                }

                if let recommendation = viewModel.recommendationText {
                    DifficultyRecommendationView(
                        recommendation: recommendation,
                        isHarder: viewModel.difficultyRecommendation == .tryHarder
                    )
                    .opacity(showXP ? 1 : 0)
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

            }
            .padding()
            }

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
                .offset(y: reduceMotion ? 0 : (emojiFloat ? -8 : 8))
                .animation(reduceMotion ? nil : .easeInOut(duration: 1.5).repeatForever(autoreverses: true), value: emojiFloat)
                .onAppear { if !reduceMotion { emojiFloat = true } }

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
        if viewModel.isPerfectScore { return "👑" }
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
                label: "Streak",
                value: "\(viewModel.bestStreak)",
                icon: "flame.fill",
                color: .orange
            )
            .accessibilityIdentifier("streakStat")

            ResultStat(
                label: "Avg Time",
                value: viewModel.averageTimePerProblem,
                icon: "clock.fill",
                color: .purple
            )
            .accessibilityIdentifier("avgTimeStat")
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

            VStack(spacing: 4) {
                GeometryReader { geo in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color(.systemGray5))
                        RoundedRectangle(cornerRadius: 4)
                            .fill(.purple)
                            .frame(width: geo.size.width * viewModel.xpProgressFraction)
                    }
                }
                .frame(height: 8)
                Text(viewModel.xpProgressLabel)
                    .font(.system(size: 11, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: 200)
            .accessibilityIdentifier("xpProgressBar")

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
            Button { onPlayAgain() } label: {
                Text("Play Again")
                    .font(.system(size: 22, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity).frame(height: 56)
                    .background(RoundedRectangle(cornerRadius: 18).fill(LinearGradient(colors: [.blue, .purple], startPoint: .leading, endPoint: .trailing)))
            }
            .accessibilityIdentifier("playAgainButton")
            HStack(spacing: 16) {
                Button { onGoHome() } label: {
                    Text("Home").font(.system(size: 18, weight: .semibold, design: .rounded)).foregroundStyle(.primary)
                }.accessibilityIdentifier("homeButton")
                ShareLink(item: viewModel.shareText) {
                    Label("Share", systemImage: "square.and.arrow.up").font(.system(size: 18, weight: .semibold, design: .rounded)).foregroundStyle(.blue)
                }.accessibilityIdentifier("shareButton")
            }
        }
        .padding(.horizontal)
    }
}
