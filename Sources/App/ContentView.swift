import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var showOnboarding = !UserDefaults.standard.bool(forKey: "hasSeenOnboarding") && !ProcessInfo.processInfo.arguments.contains("--uitesting")

    var body: some View {
        if showOnboarding {
            OnboardingView {
                UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
                showOnboarding = false
            }
        } else {
        TabView(selection: $selectedTab) {
            PlayTab()
                .tabItem {
                    Label("Play", systemImage: "play.circle.fill")
                }
                .tag(0)

            StatsTab()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.fill")
                }
                .tag(1)
        }
        .tint(.purple)
        }
    }
}

struct PlayTab: View {
    @Environment(\.modelContext) private var modelContext
    @State private var router = AppRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView(
                viewModel: HomeViewModel(
                    statsService: StatsService(modelContainer: modelContext.container)
                ),
                onStartGame: { difficulty, operations in
                    router.navigateToGame(difficulty: difficulty, operations: operations)
                },
                onStartPractice: { difficulty, operations in
                    router.navigateToPractice(difficulty: difficulty, operations: operations)
                },
                onStartDailyChallenge: {
                    router.navigateToDailyChallenge()
                }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .game(let difficulty, let operations):
                    GameView(
                        viewModel: GameViewModel(difficulty: difficulty, allowedOperations: operations),
                        onGameEnd: { session in
                            let statsService = StatsService(modelContainer: modelContext.container)
                            let previousBest = statsService.getOrCreateStats().bestScore
                            statsService.recordGame(session: session)
                            let isNewBest = session.score > previousBest
                            router.navigateToResults(session: session, isNewBest: isNewBest)
                        }
                    )
                    .navigationBarBackButtonHidden()

                case .practice(let difficulty, let operations):
                    GameView(
                        viewModel: GameViewModel(difficulty: difficulty, mode: .practice, allowedOperations: operations),
                        onGameEnd: { session in
                            let statsService = StatsService(modelContainer: modelContext.container)
                            let previousBest = statsService.getOrCreateStats().bestScore
                            statsService.recordGame(session: session)
                            let isNewBest = session.score > previousBest
                            router.navigateToResults(session: session, isNewBest: isNewBest)
                        }
                    )
                    .navigationBarBackButtonHidden()

                case .dailyChallenge:
                    GameView(
                        viewModel: GameViewModel(difficulty: .medium, mode: .dailyChallenge),
                        onGameEnd: { session in
                            let statsService = StatsService(modelContainer: modelContext.container)
                            let stats = statsService.getOrCreateStats()
                            let previousBest = stats.bestScore
                            statsService.recordGame(session: session)
                            let isNewBest = session.score > previousBest
                            router.navigateToResults(session: session, isNewBest: isNewBest)
                        }
                    )
                    .navigationBarBackButtonHidden()

                case .results(let score, let correct, let total, let accuracy, let bestStreak, let difficulty, let isNewBest):
                    let session = makeSession(score: score, correct: correct, total: total, accuracy: accuracy, bestStreak: bestStreak, difficulty: difficulty)
                    let currentStats = StatsService(modelContainer: modelContext.container).getOrCreateStats()
                    ResultsView(
                        viewModel: ResultsViewModel(session: session, previousBestScore: isNewBest ? 0 : score + 1, stats: currentStats),
                        onPlayAgain: {
                            router.popToRoot()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                router.navigateToGame(difficulty: difficulty, operations: Set(Operation.allCases))
                            }
                        },
                        onGoHome: {
                            router.popToRoot()
                        }
                    )
                    .navigationBarBackButtonHidden()
                }
            }
        }
    }

    private func makeSession(score: Int, correct: Int, total: Int, accuracy: Double, bestStreak: Int, difficulty: DifficultyLevel) -> GameSession {
        var session = GameSession(difficulty: difficulty)
        for i in 0..<total {
            session.recordAnswer(correct: i < correct, bonusPoints: 0)
        }
        // Adjust score to match
        return session
    }
}

struct StatsTab: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        StatsView(
            viewModel: StatsViewModel(
                statsService: StatsService(modelContainer: modelContext.container)
            )
        )
    }
}
