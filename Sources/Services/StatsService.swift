import Foundation
import SwiftData

@MainActor
final class StatsService {
    private let modelContainer: ModelContainer

    init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
    }

    @MainActor
    func getOrCreateStats() -> PlayerStats {
        let context = modelContainer.mainContext
        let descriptor = FetchDescriptor<PlayerStats>()

        if let existing = try? context.fetch(descriptor).first {
            return existing
        }

        let stats = PlayerStats()
        context.insert(stats)
        try? context.save()
        return stats
    }

    func recordGame(session: GameSession) {
        let stats = getOrCreateStats()
        stats.recordGame(session: session)
        stats.updateStreak()
        try? modelContainer.mainContext.save()
    }
}
