import SwiftUI

struct StatsView: View {
    @State var viewModel: StatsViewModel
    @State private var showCards: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    streakSection
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)

                    lifetimeSection
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)

                    difficultyBreakdown
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)

                    if let stats = viewModel.playerStats {
                        AchievementProgressView(achievements: Achievement.all, stats: stats)
                    }

                    if let milestone = viewModel.gamesMilestone {
                        HStack(spacing: 8) {
                            Image(systemName: "trophy.fill")
                                .foregroundStyle(.yellow)
                            Text(milestone)
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                            Text("(\(viewModel.gamesPlayed) games)")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(Color.yellow.opacity(0.15))
                                .overlay(
                                    Capsule().stroke(Color.yellow.opacity(0.3), lineWidth: 1)
                                )
                        )
                        .accessibilityIdentifier("gamesMilestone")
                    }

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Favorite Operation")
                            .font(.headline)

                        if let op = viewModel.favoriteOperation {
                            HStack(spacing: 8) {
                                Text(op)
                                    .font(.system(size: 32, weight: .bold, design: .rounded))
                                    .foregroundStyle(.purple)
                                Text("used \(viewModel.favoriteOperationCount) times")
                                    .font(.subheadline)
                                    .foregroundStyle(.secondary)
                            }
                        } else {
                            Text("Play more to find out!")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.purple.opacity(0.1))
                    )
                    .accessibilityIdentifier("favoriteOperation")

                    accuracyTrend

                    weeklyActivity
                }
                .padding()
            }
            .navigationTitle("Progress")
            .refreshable {
                viewModel.loadStats()
            }
            .onAppear {
                viewModel.loadStats()
                withAnimation(.easeOut(duration: 0.5)) { showCards = true }
            }
        }
    }

    private var streakSection: some View {
        VStack(spacing: 8) {
            Image(systemName: "flame.fill")
                .font(.system(size: 48))
                .foregroundStyle(.orange)
                .accessibilityIdentifier("streakIcon")

            Text("\(viewModel.dailyStreak)")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .accessibilityIdentifier("dailyStreakValue")

            Text("Day Streak")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 24)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.orange.opacity(0.1))
        )
    }

    private var lifetimeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Lifetime Stats")
                .font(.headline)

            LazyVGrid(columns: [
                GridItem(.flexible()),
                GridItem(.flexible())
            ], spacing: 12) {
                LifetimeStat(label: "Problems Solved", value: "\(viewModel.totalSolved)", icon: "checkmark.circle.fill", color: .green)
                    .accessibilityIdentifier("lifetimeSolved")

                VStack(spacing: 4) {
                    LifetimeStat(label: "Accuracy", value: "\(Int(viewModel.accuracy))%", icon: "target", color: .blue)
                    if viewModel.accuracyTrend != .stable {
                        HStack(spacing: 2) {
                            Image(systemName: viewModel.accuracyTrend == .improving ? "arrow.up.right" : "arrow.down.right")
                                .font(.system(size: 10, weight: .bold))
                            Text(viewModel.accuracyTrend == .improving ? "Improving" : "Declining")
                                .font(.system(size: 10, weight: .semibold, design: .rounded))
                        }
                        .foregroundStyle(viewModel.accuracyTrend == .improving ? .green : .red)
                        .accessibilityIdentifier("accuracyTrendArrow")
                    }
                }
                .accessibilityIdentifier("lifetimeAccuracy")

                LifetimeStat(label: "Best Streak", value: "\(viewModel.bestStreak)", icon: "flame.fill", color: .orange)
                    .accessibilityIdentifier("lifetimeBestStreak")

                LifetimeStat(label: "Best Score", value: "\(viewModel.bestScore)", icon: "star.fill", color: .yellow)
                    .accessibilityIdentifier("lifetimeBestScore")

                LifetimeStat(label: "Time Played", value: viewModel.formattedTimePlayed, icon: "clock.fill", color: .purple)
                    .accessibilityIdentifier("lifetimeTimePlayed")
            }
        }
    }

    private var difficultyBreakdown: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Games by Difficulty")
                .font(.headline)

            HStack(spacing: 12) {
                DifficultyStatCard(label: "Easy", count: viewModel.easyGames, emoji: "🌱", color: .green)
                    .accessibilityIdentifier("easyGames")
                DifficultyStatCard(label: "Medium", count: viewModel.mediumGames, emoji: "⚡", color: .orange)
                    .accessibilityIdentifier("mediumGames")
                DifficultyStatCard(label: "Hard", count: viewModel.hardGames, emoji: "🔥", color: .red)
                    .accessibilityIdentifier("hardGames")
            }
        }
    }

    private var accuracyTrend: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Accuracy Trend")
                .font(.headline)

            if viewModel.recentAccuracies.isEmpty {
                Text("Play some games to see your trend!")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 32)
                    .accessibilityIdentifier("accuracyTrendEmpty")
            } else {
                AccuracyChartView(accuracies: viewModel.recentAccuracies)
                    .frame(height: 120)
                    .accessibilityIdentifier("accuracyTrendChart")
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemGray6))
        )
    }

    private var weeklyActivity: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("This Week")
                .font(.headline)

            HStack(spacing: 8) {
                ForEach(weekDays, id: \.self) { day in
                    VStack(spacing: 4) {
                        Circle()
                            .fill(day == currentDayOfWeek && viewModel.gamesPlayed > 0 ? Color.green : Color.gray.opacity(0.2))
                            .frame(width: 32, height: 32)

                        Text(day)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
            )
        }
        .accessibilityIdentifier("weeklyActivity")
    }

    private var weekDays: [String] {
        ["M", "T", "W", "T", "F", "S", "S"]
    }

    private var currentDayOfWeek: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        let day = formatter.string(from: .now)
        return String(day.prefix(1))
    }
}

struct LifetimeStat: View {
    let label: String
    let value: String
    let icon: String
    let color: Color

    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
                .font(.system(size: 24, weight: .bold, design: .rounded))

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.1))
        )
    }
}

struct DifficultyStatCard: View {
    let label: String
    let count: Int
    let emoji: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Text(emoji)
                .font(.title2)

            Text("\(count)")
                .font(.system(size: 22, weight: .bold, design: .rounded))

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
