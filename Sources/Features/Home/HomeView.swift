import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    @State private var showSettings = false
    @State private var animateGradient = false
    var onStartGame: (DifficultyLevel, Set<Operation>) -> Void
    var onStartPractice: ((DifficultyLevel, Set<Operation>) -> Void)?
    var onStartDailyChallenge: (() -> Void)?

    var body: some View {
        ZStack {
            AnimatedGradientBackground(
                colors: difficultyGradientColors,
                animate: $animateGradient
            )
            .ignoresSafeArea()

        ScrollView {
        VStack(spacing: 16) {
            HStack {
                Spacer()
                Button {
                    showSettings = true
                } label: {
                    Image(systemName: "gearshape.fill")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                }
                .accessibilityIdentifier("settingsButton")
            }
            .padding(.horizontal)

            titleSection

            levelBadge

            statsCards

            dailyChallengeCard

            mathTipCard

            difficultyPicker

            operationPicker
                .animation(.spring(duration: 0.3), value: viewModel.selectedDifficulty)

            playButton

            practiceButton
        }
        .padding()
        }
        .onAppear {
            viewModel.loadStats()
            animateGradient = true
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
        }
        }
    }

    private var difficultyGradientColors: [Color] {
        switch viewModel.selectedDifficulty {
        case .easy: [.green.opacity(0.1), .blue.opacity(0.05), .green.opacity(0.08)]
        case .medium: [.orange.opacity(0.1), .yellow.opacity(0.05), .orange.opacity(0.08)]
        case .hard: [.red.opacity(0.1), .purple.opacity(0.05), .red.opacity(0.08)]
        }
    }

    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("MathKids")
                .font(.system(size: 48, weight: .bold, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .accessibilityIdentifier("appTitle")

            Text(viewModel.greeting)
                .font(.title3)
                .foregroundStyle(.secondary)
                .accessibilityIdentifier("greeting")
        }
    }

    private var levelBadge: some View {
        LevelBadgeView(
            level: viewModel.currentLevel,
            name: viewModel.levelName,
            progress: viewModel.levelProgress,
            totalXP: viewModel.totalXP
        )
    }

    private var statsCards: some View {
        HStack(spacing: 16) {
            StatCard(
                icon: "flame.fill",
                value: "\(viewModel.dailyStreak)",
                label: "Day Streak",
                color: .orange
            )
            .accessibilityIdentifier("dailyStreakCard")

            StatCard(
                icon: "checkmark.circle.fill",
                value: "\(viewModel.totalSolved)",
                label: "Solved",
                color: .green
            )
            .accessibilityIdentifier("totalSolvedCard")

            StatCard(
                icon: "crown.fill",
                value: "\(viewModel.bestScore)",
                label: "Best Score",
                color: .yellow
            )
            .accessibilityIdentifier("bestScoreCard")
        }
    }

    private var mathTipCard: some View {
        MathTipCard(seed: viewModel.totalSolved)
    }

    private var difficultyPicker: some View {
        VStack(spacing: 12) {
            Text("Difficulty")
                .font(.headline)

            HStack(spacing: 12) {
                ForEach(DifficultyLevel.allCases, id: \.self) { level in
                    DifficultyButton(
                        level: level,
                        isSelected: viewModel.selectedDifficulty == level
                    ) {
                        withAnimation(.spring(duration: 0.3)) {
                            viewModel.selectedDifficulty = level
                        }
                    }
                    .accessibilityIdentifier("difficulty_\(level.rawValue)")
                }
            }
        }
    }

    private var dailyChallengeCard: some View {
        Button {
            onStartDailyChallenge?()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(spacing: 6) {
                        Image(systemName: "calendar.badge.clock")
                            .foregroundStyle(.blue)
                        Text("Daily Challenge")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                    }
                    if viewModel.dailyChallengeCompleted {
                        if let resetTime = viewModel.dailyChallengeResetTime {
                            Text("Completed! Best: \(viewModel.dailyChallengeBestTime)s • Resets in \(resetTime)")
                                .font(.caption)
                                .foregroundStyle(.green)
                        } else {
                            Text("Completed! Best: \(viewModel.dailyChallengeBestTime)s")
                                .font(.caption)
                                .foregroundStyle(.green)
                        }
                    } else {
                        Text("10 problems - beat your best time!")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                Spacer()
                if viewModel.dailyChallengeCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.green)
                } else {
                    Image(systemName: "chevron.right.circle.fill")
                        .font(.title2)
                        .foregroundStyle(.blue)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(viewModel.dailyChallengeCompleted ? Color.green.opacity(0.1) : Color.blue.opacity(0.1))
            )
        }
        .buttonStyle(.plain)
        .accessibilityIdentifier("dailyChallengeCard")
        .padding(.horizontal)
    }

    private var operationPicker: some View {
        VStack(spacing: 8) {
            Text("Operations")
                .font(.headline)

            HStack(spacing: 10) {
                ForEach(Operation.allCases, id: \.self) { op in
                    OperationChip(
                        operation: op,
                        isSelected: viewModel.selectedOperations.contains(op)
                    ) {
                        withAnimation(.spring(duration: 0.3)) {
                            viewModel.toggleOperation(op)
                        }
                    }
                    .accessibilityIdentifier("operation_\(op.rawValue)")
                }
            }
        }
    }

    private var playButton: some View {
        Button {
            onStartGame(viewModel.selectedDifficulty, viewModel.selectedOperations)
        } label: {
            Text("PLAY!")
                .font(.system(size: 28, weight: .bold, design: .rounded))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: animateGradient ? .topLeading : .leading,
                                endPoint: animateGradient ? .bottomTrailing : .trailing
                            )
                        )
                        .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true), value: animateGradient)
                )
                .shadow(color: .purple.opacity(0.4), radius: 10, y: 5)
        }
        .accessibilityIdentifier("playButton")
        .padding(.horizontal)
    }

    private var practiceButton: some View {
        Button {
            onStartPractice?(viewModel.selectedDifficulty, viewModel.selectedOperations)
        } label: {
            Text("PRACTICE")
                .font(.system(size: 22, weight: .bold, design: .rounded))
                .foregroundStyle(.purple)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            lineWidth: 2
                        )
                )
        }
        .accessibilityIdentifier("practiceButton")
        .padding(.horizontal)
    }
}
