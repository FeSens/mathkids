import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
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

struct PlayTab: View {
    @Environment(\.modelContext) private var modelContext
    @State private var router = AppRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            HomeView(
                viewModel: HomeViewModel(
                    statsService: StatsService(modelContainer: modelContext.container)
                ),
                onStartGame: { difficulty in
                    router.navigateToGame(difficulty: difficulty)
                },
                onStartPractice: { difficulty in
                    router.navigateToPractice(difficulty: difficulty)
                }
            )
            .navigationDestination(for: AppRoute.self) { route in
                switch route {
                case .game(let difficulty):
                    GameView(
                        viewModel: GameViewModel(difficulty: difficulty),
                        onGameEnd: { session in
                            let statsService = StatsService(modelContainer: modelContext.container)
                            let previousBest = statsService.getOrCreateStats().bestScore
                            statsService.recordGame(session: session)
                            let isNewBest = session.score > previousBest
                            router.navigateToResults(session: session, isNewBest: isNewBest)
                        }
                    )
                    .navigationBarBackButtonHidden()

                case .practice(let difficulty):
                    GameView(
                        viewModel: GameViewModel(difficulty: difficulty, mode: .practice),
                        onGameEnd: { session in
                            let statsService = StatsService(modelContainer: modelContext.container)
                            let previousBest = statsService.getOrCreateStats().bestScore
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
                                router.navigateToGame(difficulty: difficulty)
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
