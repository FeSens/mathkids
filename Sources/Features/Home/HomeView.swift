import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    @State private var showSettings = false
    var onStartGame: (DifficultyLevel) -> Void
    var onStartPractice: ((DifficultyLevel) -> Void)?

    var body: some View {
        VStack(spacing: 24) {
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

            statsCards

            difficultyPicker

            playButton

            practiceButton

            Spacer()
        }
        .padding()
        .onAppear {
            viewModel.loadStats()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
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

    private var playButton: some View {
        Button {
            onStartGame(viewModel.selectedDifficulty)
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
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                )
                .shadow(color: .purple.opacity(0.4), radius: 10, y: 5)
        }
        .accessibilityIdentifier("playButton")
        .padding(.horizontal)
    }

    private var practiceButton: some View {
        Button {
            onStartPractice?(viewModel.selectedDifficulty)
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

struct StatCard: View {
    let icon: String
    let value: String
    let label: String
    let color: Color

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)

            Text(value)
                .font(.system(size: 24, weight: .bold, design: .rounded))

            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(color.opacity(0.1))
        )
    }
}

struct DifficultyButton: View {
    let level: DifficultyLevel
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Text(level.emoji)
                    .font(.title2)
                Text(level.displayName)
                    .font(.subheadline.bold())
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 14)
                    .fill(isSelected ? levelColor.opacity(0.2) : Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(isSelected ? levelColor : .gray.opacity(0.3), lineWidth: 2)
                    )
            )
        }
        .buttonStyle(.plain)
    }

    private var levelColor: Color {
        switch level {
        case .easy: .green
        case .medium: .orange
        case .hard: .red
        }
    }
}
