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

            Text("Train your brain!")
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var levelBadge: some View {
        VStack(spacing: 6) {
            HStack(spacing: 8) {
                Text("Lv.\(viewModel.currentLevel)")
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    )

                Text(viewModel.levelName)
                    .font(.system(size: 16, weight: .semibold, design: .rounded))
                    .foregroundStyle(.primary)
            }
            .accessibilityIdentifier("levelBadge")

            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(width: geo.size.width * viewModel.levelProgress)
                }
            }
            .frame(height: 6)
            .padding(.horizontal, 40)
            .accessibilityIdentifier("xpProgressBar")

            HStack {
                Text("\(viewModel.totalXP) XP")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text("\(Int(viewModel.levelProgress * 100))%")
                    .font(.system(size: 12, weight: .bold, design: .rounded))
                    .foregroundStyle(.purple)
            }
        }
        .accessibilityIdentifier("levelProgressSection")
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
                icon: "star.fill",
                value: "\(viewModel.bestScore)",
                label: "Best Score",
                color: .yellow
            )
            .accessibilityIdentifier("bestScoreCard")
        }
    }

    private static let mathTips = [
        "To add 9, add 10 then subtract 1!",
        "Doubles are easy: 6+6=12, 7+7=14, 8+8=16",
        "To multiply by 5, multiply by 10 then divide by 2",
        "Subtraction is the opposite of addition",
        "To multiply by 9, multiply by 10 then subtract once",
        "Break big numbers into friendly parts: 14+8 = 14+6+2",
        "Even + Even = Even, Odd + Odd = Even",
        "Any number times 0 is always 0",
        "Practice makes permanent - keep at it!"
    ]

    private var mathTipCard: some View {
        HStack(spacing: 10) {
            Image(systemName: "lightbulb.fill")
                .font(.title3)
                .foregroundStyle(.yellow)

            Text(Self.mathTips[abs(viewModel.totalSolved) % Self.mathTips.count])
                .font(.system(size: 14, weight: .medium, design: .rounded))
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.yellow.opacity(0.08))
        )
        .accessibilityIdentifier("mathTipCard")
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
                        Text("Completed! Best: \(viewModel.dailyChallengeBestTime)s")
                            .font(.caption)
                            .foregroundStyle(.green)
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
