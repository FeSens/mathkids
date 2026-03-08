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

                    operationStreaksSection
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)

                    if viewModel.perfectGameCount > 0 {
                        HStack(spacing: 8) {
                            Image(systemName: "star.circle.fill")
                                .foregroundStyle(.yellow)
                            Text("\(viewModel.perfectGameCount) Perfect Game\(viewModel.perfectGameCount == 1 ? "" : "s")")
                                .font(.system(size: 16, weight: .bold, design: .rounded))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(Capsule().fill(Color.yellow.opacity(0.15)))
                        .accessibilityIdentifier("perfectGameCount")
                        .opacity(showCards ? 1 : 0)
                    }

                    masteryGrid
                        .opacity(showCards ? 1 : 0)
                        .offset(y: showCards ? 0 : 20)

                    if viewModel.totalXPFromDifficulties > 0 {
                        xpBreakdownSection
                            .opacity(showCards ? 1 : 0)
                            .offset(y: showCards ? 0 : 20)
                    }

                    EloChartView(
                        addHistory: viewModel.eloHistoryAdd,
                        subtractHistory: viewModel.eloHistorySubtract,
                        multiplyHistory: viewModel.eloHistoryMultiply,
                        divideHistory: viewModel.eloHistoryDivide,
                        addRating: viewModel.eloAdd,
                        subtractRating: viewModel.eloSubtract,
                        multiplyRating: viewModel.eloMultiply,
                        divideRating: viewModel.eloDivide
                    )
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

            if viewModel.totalXP > 0 {
                HStack(spacing: 4) {
                    Image(systemName: "sparkles")
                        .foregroundStyle(.purple)
                    Text("\(viewModel.totalXP) XP")
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundStyle(.purple)
                }
                .accessibilityIdentifier("totalXPDisplay")
            }
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
                DifficultyStatCard(label: "Easy", count: viewModel.easyGames, emoji: "🌱", color: .green, bestScore: viewModel.bestScoreEasy, accuracy: viewModel.bestAccuracyEasy)
                    .accessibilityIdentifier("easyGames")
                DifficultyStatCard(label: "Medium", count: viewModel.mediumGames, emoji: "⚡", color: .orange, bestScore: viewModel.bestScoreMedium, accuracy: viewModel.bestAccuracyMedium)
                    .accessibilityIdentifier("mediumGames")
                DifficultyStatCard(label: "Hard", count: viewModel.hardGames, emoji: "🔥", color: .red, bestScore: viewModel.bestScoreHard, accuracy: viewModel.bestAccuracyHard)
                    .accessibilityIdentifier("hardGames")
            }
        }
    }

    private var masteryGrid: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Operation Mastery")
                .font(.headline)

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                MasteryCard(symbol: "+", rating: viewModel.eloAdd, level: viewModel.operationSkillLevels["+"] ?? "")
                MasteryCard(symbol: "-", rating: viewModel.eloSubtract, level: viewModel.operationSkillLevels["-"] ?? "")
                MasteryCard(symbol: "\u{00d7}", rating: viewModel.eloMultiply, level: viewModel.operationSkillLevels["×"] ?? "")
                MasteryCard(symbol: "\u{00f7}", rating: viewModel.eloDivide, level: viewModel.operationSkillLevels["÷"] ?? "")
            }
        }
        .accessibilityIdentifier("masteryGrid")
    }

    private var xpBreakdownSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("XP by Difficulty")
                .font(.headline)

            XPBar(label: "Easy", xp: viewModel.xpEasy, total: viewModel.totalXPFromDifficulties, color: .green)
            XPBar(label: "Medium", xp: viewModel.xpMedium, total: viewModel.totalXPFromDifficulties, color: .orange)
            XPBar(label: "Hard", xp: viewModel.xpHard, total: viewModel.totalXPFromDifficulties, color: .red)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 16).fill(Color(.systemGray6)))
        .accessibilityIdentifier("xpBreakdown")
    }

    private var operationStreaksSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Best Streaks by Operation")
                .font(.headline)

            HStack(spacing: 12) {
                OperationStreakCard(symbol: "+", streak: viewModel.bestStreakAdd, color: .green)
                OperationStreakCard(symbol: "-", streak: viewModel.bestStreakSubtract, color: .blue)
                OperationStreakCard(symbol: "\u{00d7}", streak: viewModel.bestStreakMultiply, color: .orange)
                OperationStreakCard(symbol: "\u{00f7}", streak: viewModel.bestStreakDivide, color: .purple)
            }
        }
        .accessibilityIdentifier("operationStreaks")
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

    private var weekDays: [String] { ["M", "T", "W", "T", "F", "S", "S"] }
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

struct MasteryCard: View {
    let symbol: String
    let rating: Double
    let level: String

    private var color: Color {
        switch level {
        case "Master": .purple
        case "Expert": .blue
        case "Advanced": .green
        case "Intermediate": .orange
        case "Learning": .yellow
        default: .gray
        }
    }

    var body: some View {
        VStack(spacing: 4) {
            Text(symbol)
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundStyle(color)
            Text("\(Int(rating))")
                .font(.system(size: 18, weight: .bold, design: .rounded))
            Text(level)
                .font(.system(size: 11, weight: .semibold, design: .rounded))
                .foregroundStyle(color)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(RoundedRectangle(cornerRadius: 12).fill(color.opacity(0.1)))
    }
}

struct XPBar: View {
    let label: String
    let xp: Int
    let total: Int
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            Text(label)
                .font(.system(size: 12, weight: .semibold, design: .rounded))
                .frame(width: 50, alignment: .leading)
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.15))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: total > 0 ? geo.size.width * Double(xp) / Double(total) : 0)
                }
            }
            .frame(height: 10)
            Text("\(xp)")
                .font(.system(size: 11, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
                .frame(width: 40, alignment: .trailing)
        }
    }
}

struct OperationStreakCard: View {
    let symbol: String
    let streak: Int
    let color: Color

    var body: some View {
        VStack(spacing: 4) {
            Text(symbol)
                .font(.system(size: 18, weight: .bold, design: .rounded))
                .foregroundStyle(color)
            Text("\(streak)")
                .font(.system(size: 20, weight: .bold, design: .rounded))
            Text("streak")
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(RoundedRectangle(cornerRadius: 12).fill(color.opacity(0.1)))
    }
}

struct DifficultyStatCard: View {
    let label: String
    let count: Int
    let emoji: String
    let color: Color
    var bestScore: Int = 0
    var accuracy: Double = 0

    var body: some View {
        VStack(spacing: 4) {
            Text(emoji)
                .font(.title2)

            Text("\(count)")
                .font(.system(size: 22, weight: .bold, design: .rounded))

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)

            if bestScore > 0 {
                Text("\(bestScore) pts")
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .foregroundStyle(color)
            }
            if accuracy > 0 {
                Text("\(Int(accuracy))%")
                    .font(.system(size: 10, weight: .medium, design: .rounded))
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(color.opacity(0.1))
        )
    }
}
